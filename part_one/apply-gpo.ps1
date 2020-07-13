# apply-gpo.ps1
# Purpose: Installs the GPOs for the custom WinEventLog auditing policy.

Write-Host "Configuring auditing policy GPOS..."
$GPOName = 'Domain Controllers Enhanced Auditing Policy'
$OU = "ou=Domain Controllers,dc=lab,dc=aws"
Write-Host "Importing $GPOName..."
Import-GPO -BackupGpoName $GPOName -Path "c:\GPO\Domain_Controllers_Enhanced_Auditing_Policy" -TargetName $GPOName -CreateIfNeeded
$gpLinks = $null
$gPLinks = Get-ADOrganizationalUnit -Identity $OU -Properties name, distinguishedName, gPLink, gPOptions
$GPO = Get-GPO -Name $GPOName
If ($gPLinks.LinkedGroupPolicyObjects -notcontains $gpo.path) {
    New-GPLink -Name $GPOName -Target $OU -Enforced yes
}
else {
    Write-Host "GpLink $GPOName already linked on $OU. Moving On."
}
$GPOName = 'Servers Enhanced Auditing Policy'
$OU = "ou=Servers,dc=lab,dc=aws"
Write-Host "Importing $GPOName..."
Import-GPO -BackupGpoName $GPOName -Path "c:\GPO\Servers_Enhanced_Auditing_Policy" -TargetName $GPOName -CreateIfNeeded
$gpLinks = $null
$gPLinks = Get-ADOrganizationalUnit -Identity $OU -Properties name, distinguishedName, gPLink, gPOptions
$GPO = Get-GPO -Name $GPOName
If ($gPLinks.LinkedGroupPolicyObjects -notcontains $gpo.path) {
    New-GPLink -Name $GPOName -Target $OU -Enforced yes
}
else {
    Write-Host "GpLink $GPOName already linked on $OU. Moving On."
}

$GPOName = 'Workstations Enhanced Auditing Policy'
$OU = "ou=Workstations,dc=lab,dc=aws" 
Write-Host "Importing $GPOName..."
Import-GPO -BackupGpoName $GPOName -Path "c:\GPO\Workstations_Enhanced_Auditing_Policy" -TargetName $GPOName -CreateIfNeeded
$gpLinks = $null
$gPLinks = Get-ADOrganizationalUnit -Identity $OU -Properties name, distinguishedName, gPLink, gPOptions
$GPO = Get-GPO -Name $GPOName
If ($gPLinks.LinkedGroupPolicyObjects -notcontains $gpo.path) {
    New-GPLink -Name $GPOName -Target $OU -Enforced yes
}
else {
    Write-Host "GpLink $GPOName already linked on $OU. Moving On."
}
