# powershell script for deleting those pesky, unwanted Apple sidecar/metadata files
# expected usage is on "infected" USB-sticks

$theSource = "E:\"       # <<<<< insert drive here
Get-Childitem $theSource -Include @("._*", ".DS_Store", ".fseventsd", ".TemporaryItems", ".Trashes", ".Spotlight-V100") -Recurse -Force -ErrorAction SilentlyContinue | Remove-Item -Force -Recurse