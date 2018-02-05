function Update-NgrokBinary
{
	[CmdletBinding()]
	Param()

	if (!(Test-Path -Path $NGROK_EXECUTABLE)) { Get-NgrokBinary | Out-Null }
	if (!(Test-Path -Path $NGROK_EXECUTABLE)) { return $false }
	
	Write-Information (& $NGROK_EXECUTABLE update --channel "stable")

	return $true
}