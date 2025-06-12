# Reason for this folder

## Configuration 
This folder contains the configurations for each team. This is available after MAJOR version 8. 

It also contains a mapping of users to object_ids, which will be deprecated when we move to actually using groups.

## DTAP, pdv (predev) and sbx (sandbox)
Each environment has a file {env}\_env\_configuration.yaml, these are now hosted in the new configuration directory as well.

## Teams
Each team has a configuration file detailing its configuration for each DTAP environment. It also contains the list of users that need access (data engineers or devops engineers).

## User Mapping
Maps user names to object_ids. This makes it so that it is easy to change accounts for a user.