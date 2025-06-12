<#
.SYNOPSIS
	This Azure script assigns the Owner Role to subscription in the $SubscriptionList variable.

.DESCRIPTION
	This Azure script assigns the Owner Role to subscription in the $SubscriptionList variable.
    You will need to login to Azure before running this script.

    You login to this like

    $Credential = Get-Credential
    Connect-AzAccount -Credential $Credential | Out-Null

.PARAMETER Account
    Specifies the account the assign the role to for the $SubscriptionList
    Account should be specified like this CPAea52tg@nngroup.onmicrosoft.com

.INPUTS
	None.

.OUTPUTS
	Human-readable informational and error messages produced during the job. Not intended to be consumed by another script.

#>


$SubScriptionList = @("LPDAP-Meta",
                      "LPDAP-DEV",
                      "LPDAP-TST",
                      "LPDAP-ACC",
                      "LPDAP-PRD",
                      "LPDAP-ADFaaS-ACC",
                      "LPDAP-ADFaaS-DEV",
                      "LPDAP-ADFaaS-TST",
                      "LPDAP-ADFaaS-PRD",
                      "PSDL-Contain-Dev",
                      "PSDL-Contain-TST",
                      "PSDL-Contain-ACC",
                      "PSDL-Contain-PRD"
                      )

$Account = Read-Host -Prompt "Please enter CSA/CPA Account"

$UserObjectId = (Get-AzADUser -UserPrincipalName $Account).Id



ForEach ($SubScription in $SubScriptionList) {

    $SubscriptionId = (Get-AzSubscription -SubscriptionName $SubScription).Id

    New-AzRoleAssignment -ObjectId $UserObjectId -Scope "/subscriptions/$SubscriptionId" -RoleDefinitionName Owner

}