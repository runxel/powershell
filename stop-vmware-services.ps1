# stops all VMWare services

if (-not (([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))){   
$arguments = "& '" + $myinvocation.mycommand.definition + "'"
Start-Process powershell -Verb runAs -ArgumentList $arguments
Break
}
Stop-Service -Force VMnetDHCP
Stop-Service -Force VMAuthdService
Stop-Service -Force VMUSBArbService
Stop-Service -Force "VMware NAT Service"
Stop-Service -Force VMUSBArbService
Stop-Service -Force VMwareHostd