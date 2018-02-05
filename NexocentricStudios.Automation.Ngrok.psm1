$publicFunctions = @()
$privateFunctions = @()
$functionFilter = "*.ps1"
$BINARIES_FOLDER = Join-Path -Path $PSScriptRoot -ChildPath "Binaries"
$dataFolder = Join-Path -Path $PSScriptRoot -ChildPath "Data"
$publicFunctionsFolder = Join-Path -Path $PSScriptRoot -ChildPath "Functions\Public"
$privateFunctionsFolder = Join-Path -Path $PSScriptRoot -ChildPath "Functions\Private"

if (Test-Path -Path $publicFunctionsFolder)
{
	$publicFunctions = @(Get-ChildItem -Path $publicFunctionsFolder -File -Filter $functionFilter)
}

if (Test-Path -Path $privateFunctionsFolder)
{
	$privateFunctions = @(Get-ChildItem -Path $privateFunctionsFolder -File -Filter $functionFilter)
}

foreach ($function in @($publicFunctions + $privateFunctions))
{
	try
	{
		. $function.FullName
	}
	catch
	{
		Write-Error -Message ("Failed to import [" + $function.FullName + "] function: $_")
	}
}

$NGROK_DOWNLOAD_URL = "https://ngrok.com/download"
$NGROK_AUTHTOKEN_FILE = Join-Path -Path $dataFolder -ChildPath "token.yml"
$NGROK_CONFIGURATION_FILE = Join-Path -Path $dataFolder -ChildPath "tunnels.yml"
$NGROK_JOB_NAME = "NGROK_TUNNEL_RUNNER"
$NGROK_EXECUTABLE = Join-Path -Path $BINARIES_FOLDER -ChildPath "ngrok.exe"

Export-ModuleMember -Variable $BINARIES_FOLDER
Export-ModuleMember -Variable $NGROK_DOWNLOAD_URL
Export-ModuleMember -Variable $NGROK_AUTHTOKEN_FILE
Export-ModuleMember -Variable $NGROK_CONFIGURATION_FILE
Export-ModuleMember -Variable $NGROK_JOB_NAME
Export-ModuleMember -Variable $NGROK_EXECUTABLE
Export-ModuleMember -Function $publicFunctions.BaseName