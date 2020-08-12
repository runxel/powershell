#! https://github.com/runxel/powershell
# Powershell script for deleting those pesky, unwanted Apple sidecar/metadata files like ".DS_Store".
# Expected usage is on "infected" USB-sticks.

<# Call the script: `.\apple-crap-destroyer.ps1`
   or call with options: `.\apple-crap-destroyer.ps1 -drive "c" -force`
   Unremovable drives aren't processed without `-force`.
#>
param (
	[string]$drive,
	[switch]$force = $false
)

function IsRemovable {
	param (
		[string]$drive
	)
	$vol_info = Get-Volume $drive
	$ret = ($vol_info.DriveType -eq "removable")
	return $ret
}

function DestroySidecars {
	param (
		[string]$drive
	)
	$file_types = @("._*", ".DS_Store", ".fseventsd", ".TemporaryItems", ".Trashes", ".Spotlight-V100")
	# This get's it done.
	Get-Childitem $drive -Include $file_types -Recurse -Force -ErrorAction SilentlyContinue | Remove-Item -Force -Recurse
	Write-Host "Done!" -ForegroundColor Green
}


if (!$drive) {
	# Let's ask the user for the drive letter, if it wasn't specified as cmd line option.
	Write-Host "Type in the drive Letter (e.g. 'f')" -ForegroundColor Yellow
	$drive_letter = $host.ui.RawUI.ReadKey("IncludeKeyDown")
}
else {
	$drive_letter = $drive
}

# A bit of declaring the necessary strings.
$dlc = $drive_letter.Character.ToString().ToUpper() # without "toString" it would be of type [System.Char]
$dlc_tp = $dlc + ":"
$dlc_src = $dlc_tp + "\"


if (Test-Path $dlc_tp) {
	# The Drive exists.
	if ($(IsRemovable($dlc)) -or ($force)) {
		# The Drive is removable OR the `-force` option was applied.
		# Delete all the sidecar files. We're done!
		DestroySidecars($dlc_src)
	}
	else {
		# The Drive is of DriveType "fixed".
		Write-Host "'$dlc_src' is not an USB-stick. Use the '-force' parameter if you really want to." `
			-ForegroundColor Black -BackgroundColor Yellow
	}
}
else {
	# The Drive doesn't exist.
	Write-Host "'$dlc_src' is not a connected drive. Nothing to do here."
	Exit
}
