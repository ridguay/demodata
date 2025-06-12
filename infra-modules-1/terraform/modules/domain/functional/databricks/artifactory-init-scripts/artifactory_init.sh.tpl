#!/bin/bash

# NOTE: Save this file with LF-line endings. Otherwise it will not run on the Databricks Cluster

# This script is meant to extract and store certificates in the right places to be able to connect to various source systems.
# The certificates will either be retrieved from the terraform module in our infrastructure, or from the meta keyvault (Kafka).

set -e

echo "LPDAP Cluster Initialization Script"

echo "Checking if certificates are available.."
i=1
while [ $i -le 10 ]
do
    if [ -f "/Volumes/${unity_catalog_name}/lpdap_databricks_cluster/cluster_packages/artifactory-init-scripts/certificates/INSIMCertsCA1.zip" ]; then
        echo "Certificates found at /Volumes/${unity_catalog_name}/lpdap_databricks_cluster/cluster_packages/artifactory-init-scripts/certificates"
        break
    else
        echo "Cannot reach Unity Catalog Volume... waiting 5s"
        sleep 5
        i=$(( i++ ))
    fi
    if [ $i = 11 ]; then
        echo "Cannot reach Unity Catalog Volume after 10 tries"
        exit 1
    fi
done


echo "Initializing INSIM certificates share.."
sudo rm -rf /usr/local/share/ca-certificates/INSIM
sudo mkdir /usr/local/share/ca-certificates/INSIM
sudo chmod 775 /usr/local/share/ca-certificates/INSIM

echo "Copying INSIM certificates to share.."
cp /Volumes/${unity_catalog_name}/lpdap_databricks_cluster/cluster_packages/artifactory-init-scripts/certificates/INSIMCertsCA1.zip /tmp/INSIMCertsCA1.zip
cp /Volumes/${unity_catalog_name}/lpdap_databricks_cluster/cluster_packages/artifactory-init-scripts/certificates/INSIMCertsCA2.zip /tmp/INSIMCertsCA2.zip

echo "Extracting INSIM certificates.."
unzip -o /tmp/INSIMCertsCA1.zip  -d /usr/local/share/ca-certificates/INSIM
unzip -o /tmp/INSIMCertsCA2.zip  -d /usr/local/share/ca-certificates/INSIM

echo "Renaming .txt to .crt.."
cd  /usr/local/share/ca-certificates/INSIM
for file in *.cer; do cp "$file" "$${file%.txt}.crt"; done

echo "Changing permissions on INSIM certificate files.."
find /usr/local/share/ca-certificates/INSIM -type f -exec chmod 644 {} \;

echo "Adding INSIM certificates to system certificates.."
cp /usr/local/share/ca-certificates/INSIM/* /usr/local/share/ca-certificates
sudo update-ca-certificates --fresh

echo "Configuring NN Python and NN DAP Python repositories (globally).."
pip config --global set global.disable-pip-version-check true
pip config --global set global.index-url ${index_url}
pip config --global set global.extra-index-url ${extra_index_url}

# From here on, the Kafka certificate will be retrieved from our meta keyvault and stored inside a Java Keystore.

if [[ -z "$KAFKA_CERT" ]]; then
  echo "Environment variable holding the kafka certificate is empty..."
  exit 0
else
  echo "Kafka Certificate successfully retrieved from meta key vault..."
fi

echo "Put Kafka certificate in a temp file..."
TEMP_LOCATION="/tmp/kafka_server.pem"

PREFIX="-----BEGIN CERTIFICATE-----"
SUFFIX="-----END CERTIFICATE-----"

KAFKA_CERT=$${KAFKA_CERT#"$PREFIX"}
KAFKA_CERT=$${KAFKA_CERT%"$SUFFIX"}

END_RESULT="$${PREFIX}\n$(echo "$KAFKA_CERT" | tr ' ' '\n')\n$${SUFFIX}"  

echo -e $END_RESULT > $TEMP_LOCATION

echo "Set some variables..."
PASSWORD="changeit"
JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")
KEYSTORE="$JAVA_HOME/lib/security/cacerts"

CERTS=$(grep 'END CERTIFICATE' $TEMP_LOCATION| wc -l)

echo "Put certificate in keystore..."
for N in $(seq 0 $(($CERTS - 1))); do
  ALIAS="$(basename $TEMP_LOCATION)-$N"
  echo "Adding to keystore with alias:$ALIAS"
  cat $TEMP_LOCATION |
    awk "n==$N { print }; /END CERTIFICATE/ { n++ }" |
    keytool -noprompt -import -trustcacerts \
            -alias $ALIAS -keystore $KEYSTORE -storepass $PASSWORD
  echo "$KEYSTORE/$ALIAS"
done

# For Unity Catalog clusters the keystore needs to be available on a Unity Catalog volume

keystorefolder="/Volumes/${unity_catalog_name}/lpdap_databricks_cluster/cluster_packages/keystore"

if [ ! -d "$keystorefolder" ]; then
  # if not, create it
  mkdir -p "$keystorefolder"
  echo "Directory created: $keystorefolder"
else
  echo "Directory allready exists: $keystorefolder"
fi

if [ -f "$keystorefolder/cacerts" ]; then
   echo "File $keystorefolder/cacerts exists."
else
   echo "File $keystorefolder/cacerts does not exist."
   cp -f "$KEYSTORE" "$keystorefolder/cacerts"
fi

echo "##Setting Environment variables##"
echo "Setting certificate folder Java truststore for Kafka connection"
echo "export JAVA_TOOL_OPTIONS=-Djavax.net.ssl.truststore=$keystorefolder/cacerts -Djavax.net.ssl.trustStorePassword=changeit -Djavax.net.ssl.trustStoreType=jks"
echo "export JAVA_TOOL_OPTIONS=-Djavax.net.ssl.truststore=$keystorefolder/cacerts -Djavax.net.ssl.trustStorePassword=changeit -Djavax.net.ssl.trustStoreType=jks" >> /databricks/spark/conf/spark-env.sh

rm $TEMP_LOCATION
echo "rm $TEMP_LOCATION exit code" $?

echo "Init Script complete"
exit 0
