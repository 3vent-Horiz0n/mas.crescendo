#region 	Variables
	$version = (Get-ChildItem "/usr/local/Cellar/mas").Name
#endregion 	Variables

#region 	Handler Functions
	. ./handler/ParseAppList.ps1
	. ./handler/ParseMasVersion.ps1
#region 	Handler Functions

# Create an empty configuration object
$NewConfiguration = [ordered]@{
	'$schema' = 'https://aka.ms/PowerShell/Crescendo/Schemas/2021-11'
	Commands  = @()
}

#region 	mas list
	## Create first Crescendo command and set its properties
	$cmdlet = @{
		Verb         = 'Get'
		Noun         = 'MasAppList'
		OriginalName = "/usr/local/Cellar/mas/$version/bin/mas"
	}
	$newCommand = New-CrescendoCommand @cmdlet
	$newCommand.OriginalCommandElements = @('list')
	$newCommand.Description = 'List installed apps via App Store'
	$newCommand.Usage = New-UsageInfo -usage $newCommand.Description
	$newCommand.Platform = @('MacOS')

	### Add an example to the command
	$example = @{
		Command         = 'Get-MasAppList'
		Description     = 'Get the list of installed apps.'
		OriginalCommand = 'mas list'
	}
	$newCommand.Examples += New-ExampleInfo @example

	$newCommand.OriginalText = 'Lists apps from the Mac App Store which are currently installed'

	### Add an Output Handler to the command
	$handler = New-OutputHandler
	$handler.ParameterSetName = 'Default'
	$handler.HandlerType = 'Function'
	$handler.Handler = 'ParseAppList'
	$newCommand.OutputHandlers += $handler

	## Add the command to the Commands collection of the configuration
	$NewConfiguration.Commands += $newCommand
#endregion 	mas list

#region 	mas version
	## Create Crescendo command and set its properties
	$cmdlet = @{
		Verb         = 'Get'
		Noun         = 'MasVersion'
		OriginalName = "/usr/local/Cellar/mas/$version/bin/mas"
	}
	$newCommand = New-CrescendoCommand @cmdlet
	$newCommand.OriginalCommandElements = @('version')
	$newCommand.Description = 'Print version number'
	$newCommand.Usage = New-UsageInfo -usage $newCommand.Description
	$newCommand.Platform = @('MacOS')

	### Add an example to the command
	$example = @{
		Command         = 'Get-MasVersion'
		Description     = 'Gets the installed version of mas'
		OriginalCommand = 'mas version'
	}
	$newCommand.Examples += New-ExampleInfo @example
	$newCommand.OriginalText = 'Print version number'

	### Add parameter to the command
	$parameter = @{
		Name         = 'String'
		OriginalName = '--string'
	}
	$NewCommand.Parameters += New-ParameterInfo @parameter
	$NewCommand.Parameters = "switch"

	### Add an Output Handler to the command
	$handler = New-OutputHandler
	$handler.ParameterSetName = 'Default'
	$handler.HandlerType = 'Function'
	$handler.Handler = 'ParseMasVersion'
	$newCommand.OutputHandlers += $handler

	## Add the command to the Commands collection of the configuration
	$NewConfiguration.Commands += $newCommand
#endregion mas version

#region Generate JSON and PSModule
	# Export the configuration to a JSON file and create the module
	$NewConfiguration | ConvertTo-Json -Depth 5 | Out-File ./PowerMas.crescendo.json
	Export-CrescendoModule -ConfigurationFile ./PowerMas.crescendo.json -ModuleName PowerMas.psm1 -Force
#endregion Generate JSON and PSModule

# Import the newly created module
Import-Module ./PowerMas.psd1 -Force





<# Template
# Create an empty configuration object
$NewConfiguration = [ordered]@{
	'$schema' = 'https://aka.ms/PowerShell/Crescendo/Schemas/2021-11'
	Commands  = @()
}
## Create first Crescendo command and set its properties
$cmdlet = @{
	Verb         = 'Get'
	Noun         = 'MasAppList'
	OriginalName = "/usr/local/Cellar/mas/$version/bin/mas"
}
$newCommand = New-CrescendoCommand @cmdlet
$newCommand.OriginalCommandElements = @('list')
$newCommand.Description = 'List installed apps via App Store'
$newCommand.Usage = New-UsageInfo -usage $newCommand.Description
$newCommand.Platform = @('MacOS')

### Add an example to the command
$example = @{
	Command         = 'Get-MasAppList'
	Description     = 'Get the list of installed apps.'
	OriginalCommand = 'mas list'
}
$newCommand.Examples += New-ExampleInfo @example

$newCommand.OriginalText = 'Lists apps from the Mac App Store which are currently installed'

### Add an Output Handler to the command
$handler = New-OutputHandler
$handler.ParameterSetName = 'Default'
$handler.HandlerType = 'Function'
$handler.Handler = 'ParseAppList'
$newCommand.OutputHandlers += $handler

## Add the command to the Commands collection of the configuration
$NewConfiguration.Commands += $newCommand
#>