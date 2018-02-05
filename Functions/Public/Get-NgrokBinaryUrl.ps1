function Get-NgrokBinaryUrl
{
	[CmdletBinding()]
	Param()
	$downloadLinks = (Invoke-WebRequest -Uri $NGROK_DOWNLOAD_URL -UseBasicParsing).Content.Split("`n") | Where-Object { $_ -like "*https*.zip*" }
	$ngrokLinks = ($downloadLinks | ForEach-Object { $_ -match "(https://.*\.zip)" | Out-Null; Write-Output $matches[0] })

	$bitness = "32"
	$operatingSystem = "Windows"
	if ([Environment]::Is64BitProcess) { $bitness = "64" }

	return $ngrokLinks | Where-Object{ $_ -like "*${operatingSystem}*${bitness}*" }
}