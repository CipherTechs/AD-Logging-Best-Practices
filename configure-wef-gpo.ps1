# configure-wef-gpo.ps1
# Purpose: Installs the GPOs needed to specify a Windows Event Collector and makes certain event channels readable by Event Logger

Write-Host "Importing the GPO to specify the WEF collector"
$GPOName = 'Windows Event Forwarding Server'
Import-GPO -BackupGpoName $GPOName -Path "c:\GPO\wef_configuration" -TargetName $GPOName -CreateIfNeeded
$gpLinks = $null
$OU = "OU=Servers,dc=victim,dc=lan"
$gPLinks = Get-ADOrganizationalUnit -Server "dc.victim.lan" -Identity $OU -Properties name, distinguishedName, gPLink, gPOptions
$GPO = Get-GPO -Name $GPOName
If ($gPLinks.LinkedGroupPolicyObjects -notcontains $gpo.path) {
    New-GPLink -Name $GPOName -Target $OU -Enforced yes
}
else {
    Write-Host "GpLink $GPOName already linked on $OU. Moving On."
}
$OU = "ou=Domain Controllers,dc=victim,dc=lan"
$gpLinks = $null
$gPLinks = Get-ADOrganizationalUnit -Server "dc.victim.lan" -Identity $OU -Properties name, distinguishedName, gPLink, gPOptions
$GPO = Get-GPO -Name $GPOName
If ($gPLinks.LinkedGroupPolicyObjects -notcontains $gpo.path) {
    New-GPLink -Name $GPOName -Target $OU -Enforced yes
}
else {
    Write-Host "GpLink $GPOName already linked on $OU. Moving On."
}
$OU = "ou=Workstations,dc=victim,dc=lan"
$gpLinks = $null
$gPLinks = Get-ADOrganizationalUnit -Server "dc.victim.lan" -Identity $OU -Properties name, distinguishedName, gPLink, gPOptions
$GPO = Get-GPO -Name $GPOName
If ($gPLinks.LinkedGroupPolicyObjects -notcontains $gpo.path) {
    New-GPLink -Name $GPOName -Target $OU -Enforced yes
}
else {
    Write-Host "GpLink $GPOName already linked on $OU. Moving On."
}

Write-Host "Importing the GPO to modify ACLs on Custom Event Channels"

$GPOName = 'Custom Event Channel Permissions'
Import-GPO -BackupGpoName $GPOName -Path "c:\GPO\wef_configuration" -TargetName $GPOName -CreateIfNeeded
$gpLinks = $null
$OU = "OU=Servers,dc=victim,dc=lan"
$gPLinks = Get-ADOrganizationalUnit -Server "dc.victim.lan" -Identity $OU -Properties name, distinguishedName, gPLink, gPOptions
$GPO = Get-GPO -Name $GPOName
If ($gPLinks.LinkedGroupPolicyObjects -notcontains $gpo.path) {
    New-GPLink -Name $GPOName -Target $OU -Enforced yes
}
else {
    Write-Host "GpLink $GPOName already linked on $OU. Moving On."
}
$OU = "ou=Domain Controllers,dc=victim,dc=lan"
$gPLinks = Get-ADOrganizationalUnit -Server "dc.victim.lan" -Identity $OU -Properties name, distinguishedName, gPLink, gPOptions
$GPO = Get-GPO -Name $GPOName
If ($gPLinks.LinkedGroupPolicyObjects -notcontains $gpo.path) {
    New-GPLink -Name $GPOName -Target $OU -Enforced yes
}
else {
    Write-Host "GpLink $GPOName already linked on $OU. Moving On."
}
$OU = "ou=Workstations,dc=victim,dc=lan"
$gPLinks = Get-ADOrganizationalUnit -Server "dc.victim.lan" -Identity $OU -Properties name, distinguishedName, gPLink, gPOptions
$GPO = Get-GPO -Name $GPOName
If ($gPLinks.LinkedGroupPolicyObjects -notcontains $gpo.path) {
    New-GPLink -Name $GPOName -Target $OU -Enforced yes
}
else {
    Write-Host "GpLink $GPOName already linked on $OU. Moving On."
}

gpupdate /force
