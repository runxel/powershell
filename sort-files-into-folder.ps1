# script for putting certain files into their own folder


$DirectoryToCreate = "RAW"    #<<< name of folder
    #(alt) $DirectoryToCreate =  read-host "Please enter a directory name"
$format = "RW2"     #<<< file ending to put into the folder
    #(alt) $format =  read-host "Please enter a file ending"
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

Get-ChildItem -Filter $search -Recurse | Move-Item -Destination $dirname
