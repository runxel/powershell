# deaspect-dng.ps1
# script to use the exiftool on a whole folder in case you accidentally
# enabled pre-cropping in your (DSLR) camera
# see also
# <https://lucasbecker.de/posts/de-aspect-your-digital-negatives>

$format = "dng"  # change to cr2 or orf, if you have those RAWs instead (only those possible)
$search = "*." + $format
$suffix = "-da"  # suffix for renaming of the de-aspected files


function Deaspect($Filename){
	
	# those are getting the true original sizes
	$CmdWidth = exiftool -ImageWidth $Filename
	$CmdHeight = exiftool -ImageHeight $Filename
	
	$ImgWidth = $CmdWidth -replace '\D+'
	$ImgHeight = $CmdHeight -replace '\D+'

	$NewFilename = $Filename.BaseName + $suffix + $Filename.Extension
	
	&exiftool -AspectRatio="" -AspectFrame="0 0 0 0" `
	-DefaultCropOrigin="" -DefaultCropSize="" `
	-CroppedImageWidth="$ImgWidth" `
	-CroppedImageHeight="$ImgHeight" `
	-o $NewFilename $Filename

	<# note:
	   you can also be explicit in what you set for "AspectRatio"
	   sometimes exiftool will yell at you "can't delete Permanent tag"
	   for me it still worked always, but your mileage may very
	   Find out what the original ratio was and set it: e.g. "4:3"
	#>
}

Get-ChildItem -Filter $search -Recurse | ForEach-Object { Deaspect -Filename $_ }