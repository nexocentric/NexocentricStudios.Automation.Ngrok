function Get-NgrokBinary
{
	[CmdletBinding()]
	Param()
	try
	{
		if (Test-Path -Path $NGROK_EXECUTABLE) { return $NGROK_EXECUTABLE }

		$url = Get-NgrokBinaryUrl
		$ngrokArchive = Join-Path -Path $ENV:Temp -ChildPath "ngrok.zip"

		(New-Object System.Net.WebClient).DownloadFile($url, $ngrokArchive)

		Add-Type -AssemblyName System.IO.Compression.FileSystem
		[IO.Compression.ZipFile]::ExtractToDirectory($ngrokArchive, $BINARIES_FOLDER)

		return $NGROK_EXECUTABLE
	}
	finally
	{
		$ngrokArchive = Join-Path -Path $ENV:Temp -ChildPath "ngrok.zip"
		if (Test-Path -Path $ngrokArchive) { Remove-Item -LiteralPath $ngrokArchive }
	}
}