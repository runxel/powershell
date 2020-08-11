# powershell
Battle-tested PowerShell scripts I use.

---

- [apple-crap-destroyer](apple-crap-destroyer.ps1)  
This script is used to clean up infested USB sticks from those pesky Apple-sidecar files (like "`.DS_Store`").

- [deaspect-dng](deaspect-dng.ps1)  
If you accidentally set your camera to pre-crop your files you can revert that on a whole folder of DNGs with the help of this script.  
[Needs [exiftool](https://exiftool.org/) installed and in your PATH.]

- [export-chocolatey-list](export-chocolatey-list.ps1)  
Generates a `packages.config` file which can be used to easily mass install all your choco packages on another PC.

- [sort-files-into-folder](sort-files-into-folder.ps1)  
Used to segregate RAW and jpeg files in a fast manner.

- [stop-vmware-services](stop-vmware-services.ps1)  
VMWare blocks a lot of stuff from happening. You want to start a local server? Yeah, that's commonly not possible anymore if any of their services is running.

---

### PS "de-castration"

Double-clicking for executing PowerShell scripts is deactivated for security reasons in Windows, but can be made working. Inside the registry navigate to
```
HKEY_CLASSES_ROOT\Microsoft.PowerShellScript.1\Shell\open\command
```
and change the value to
```
"C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -noLogo -ExecutionPolicy unrestricted -file "%1"
```

Now you can even reference your Scripts from apps like Notion and clicking on the link will execute the script!

[[source](https://stackoverflow.com/questions/10137146/is-there-a-way-to-make-a-powershell-script-work-by-double-clicking-a-ps1-file#20623597)]
