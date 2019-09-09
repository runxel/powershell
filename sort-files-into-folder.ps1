# script for putting certain files into their own folder
# to be called from anywhere


$DirectoryToCreate =  read-host "Please enter a directory name"
$format =  read-host "Please enter a file ending"
$search = "*." + $format  # making the final wildcard (comma seperated entries are possible too)


if (-not (Test-Path -LiteralPath $DirectoryToCreate)) {  # test if directory already exists
    
    try {
        mkdir $DirectoryToCreate
    }
    catch {
        Write-Error -Message "Unable to create directory '$DirectoryToCreate'. Error was: $_" -ErrorAction Stop
    }
    "Successfully created directory '$DirectoryToCreate'."
}
else {
    "Directory already existed"
}

Get-ChildItem -Filter $search -Recurse | Move-Item -Destination $DirectoryToCreate
