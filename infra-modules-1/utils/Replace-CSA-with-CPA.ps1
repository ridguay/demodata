<#
.SYNOPSIS
	This Azure script assigns the same roles someone had on the CSA account to their new CPA Account

.DESCRIPTION
    This Azure script assigns the same roles someone had on the CSA account to their new CPA Account

    When first team switched from CSA to CPA, we got a lot of incidents and problems for the CnW team. 
    This script was build to prevent that.

    The script should also be run AFTER the new CPA have been impletemented in the code and these 
    changes have been deployed.

    You will need to login to Azure before running this script and also have Az modules v12.0 installed.

    You login to this like

    Connect-AzAccount

.INPUTS
	None.

.OUTPUTS
	Human-readable informational and error messages produced during the job. Not intended to be consumed by another script.

#>


# List of subscriptions

$SubScriptionList = @("LPDAP-Meta",
                      "LPDAP-DEV",
                      "LPDAP-TST",
                      "LPDAP-ACC",
                      "LPDAP-PRD"
                      )

# List of Data enginers from variables.yaml

$DataEngineersList = @("CSACH84NA@INSIM.BIZ", # Jaap Wagemans
                       "CSABK00VS@INSIM.BIZ", # Michael Post
                       "CSARY87CU@INSIM.BIZ", # Meint Ijbema
                       "CSAUQ32AK@INSIM.BIZ", # Milan Hirko
                       "CSAEA25HY@INSIM.BIZ", # Jacob Nurup
                       "CSAWC51JJ@INSIM.BIZ", # Rob Duikersloot
                       "CSAOQ68OA@INSIM.BIZ", # Wilma van der Burg
                       "CSACM36OL@INSIM.BIZ", # Vincent Poot
                       "CSAFK98LR@INSIM.BIZ", # Steffen Schurink
                       "CSARS03MF@INSIM.BIZ", # Ellen in de Braekt
                       "CSAHS14YO@INSIM.BIZ"  # Meny Metekia
                      )

ForEach ($SubScription in $SubScriptionList) {

    Set-AzContext -SubscriptionName $SubScription | Out-Null

    ForEach ($CSAAccount in $DataEngineersList) {

        # Retrieve all roles of user defined with signinname and put them in a list

        $CSARolesList = Get-AzRoleAssignment -SignInName $CSAAccount

        $CSAAccount = $CSAAccount.Replace("CSA","")
        $Account    = $CSAAccount.Replace("@INSIM.BIZ","")
        $CPAAccount = "CPA$account@NNGROUP.ONMICROSOFT.COM"
        $CPADescription = (Get-AzADUser -UserPrincipalName $CPAAccount).DisplayName

        If ((Get-AzADUser -UserPrincipalName $CPAAccount) -ne $Null) {

            # Loop through list and set all roles assigned to CSA account to new CPA Account.

            ForEach($RoleAssignment in $CSARolesList) {

                $Role = $RoleAssignment.RoleDefinitionName
                $Scope = ($RoleAssignment.Scope).Substring(($RoleAssignment.Scope).lastIndexOf('/') + 1)

                # Set role to CPAAccount

                If ((Get-AzRoleAssignment -SignInName $CPAAccount -RoleDefinitionName $RoleAssignment.RoleDefinitionName -Scope $RoleAssignment.Scope) -eq $null) 
                    {
                        New-AzRoleAssignment -RoleDefinitionName $RoleAssignment.RoleDefinitionName -Scope $RoleAssignment.Scope -SignInName $CPAAccount | Out-Null
                        Write-Host "$CPADescription ($CPAAccount) role $Role on $Scope"
                    }
                    Else {
                        Write-Host "Error: $CPADescription ($CPAAccount) role $Role on $Scope all ready exists." -foregroundcolor "red"
                    }

                # Remove role assigned to CSAAccount

                #Remove-AzRoleAssignment -InputObject $roleassignment

            }
        } Else {
            Write-Host "Error: $CPAAccount not found in Entra ID" -foregroundcolor Red
        }

    }

}