function Start-Ngrok
{
	[CmdletBinding()]
	Param()
	try
	{
		while ($true)
		{
			# $newConfigurationFileHash = Get-FileHash -Algorithm SHA256 -Path $tunnelsConfigurationFile

			# if ($newConfigurationFileHash.Hash -eq $oldConfigurationFileHash.Hash)
			# {
			# 	Write-Host "Sleeping"
			# 	Start-Sleep -Seconds 5
			# 	continue
			# }

			# $oldConfigurationFileHash = $newConfigurationFileHash

			Get-Job -Name $NGROK_JOB_NAME -ErrorAction SilentlyContinue | Stop-Job
			Get-Job -Name $NGROK_JOB_NAME -ErrorAction SilentlyContinue | Remove-Job
			
			Write-Verbose "Starting ngrok"
			& $NGROK_EXECUTABLE start --config $NGROK_AUTHTOKEN_FILE --config $NGROK_CONFIGURATION_FILE --all
			Start-Job -Name $NGROK_JOB_NAME -ScriptBlock {  } | Out-Null
		}
	}
	finally
	{

	}
}1