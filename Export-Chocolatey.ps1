# Put this in Export-Chocolatey.ps1 file and run it:
# .\Export-Chocolatey.ps1 > packages.config
# You can install the packages using
# choco install packages.config -y
## origin: https://gist.github.com/alimbada/449ddf65b4ef9752eff3
## see also https://stackoverflow.com/questions/43167087/how-to-get-a-list-of-packages-from-one-machine-and-install-in-another-with-choco

Write-Output "<?xml version=`"1.0`" encoding=`"utf-8`"?>"
Write-Output "<packages>"
choco list -lo -r -y | % { "   <package id=`"$($_.SubString(0, $_.IndexOf("|")))`" version=`"$($_.SubString($_.IndexOf("|") + 1))`" />" }
Write-Output "</packages>"