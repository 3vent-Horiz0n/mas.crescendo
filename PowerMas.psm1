# Module created by Microsoft.PowerShell.Crescendo
class PowerShellCustomFunctionAttribute : System.Attribute { 
    [bool]$RequiresElevation
    [string]$Source
    PowerShellCustomFunctionAttribute() { $this.RequiresElevation = $false; $this.Source = "Microsoft.PowerShell.Crescendo" }
    PowerShellCustomFunctionAttribute([bool]$rElevation) {
        $this.RequiresElevation = $rElevation
        $this.Source = "Microsoft.PowerShell.Crescendo"
    }
}

function ParseAppList {
	param (
		[Parameter(Mandatory)]
		[string]$AppList
	)
	for ($i = 0; $i -lt $AppList.Count; $i++) {
		$info = (($AppList[$i]).Split("  ", [System.StringSplitOptions]::RemoveEmptyEntries)).Trim()
		[PSCustomObject]@{
			Id      = $info[0]
			Name    = $info[1]
			Version = $info[2]
		}
	}
}


function Get-MasAppList
{
[PowerShellCustomFunctionAttribute(RequiresElevation=$False)]
[CmdletBinding()]

param(    )

BEGIN {
    $__PARAMETERMAP = @{}
    $__outputHandlers = @{
        Default = @{ StreamOutput = $False; Handler = 'ParseAppList' }
    }
}

PROCESS {
    $__boundParameters = $PSBoundParameters
    $__defaultValueParameters = $PSCmdlet.MyInvocation.MyCommand.Parameters.Values.Where({$_.Attributes.Where({$_.TypeId.Name -eq "PSDefaultValueAttribute"})}).Name
    $__defaultValueParameters.Where({ !$__boundParameters["$_"] }).ForEach({$__boundParameters["$_"] = get-variable -value $_})
    $__commandArgs = @()
    $MyInvocation.MyCommand.Parameters.Values.Where({$_.SwitchParameter -and $_.Name -notmatch "Debug|Whatif|Confirm|Verbose" -and ! $__boundParameters[$_.Name]}).ForEach({$__boundParameters[$_.Name] = [switch]::new($false)})
    if ($__boundParameters["Debug"]){wait-debugger}
    $__commandArgs += 'list'
    foreach ($paramName in $__boundParameters.Keys|
            Where-Object {!$__PARAMETERMAP[$_].ApplyToExecutable}|
            Sort-Object {$__PARAMETERMAP[$_].OriginalPosition}) {
        $value = $__boundParameters[$paramName]
        $param = $__PARAMETERMAP[$paramName]
        if ($param) {
            if ($value -is [switch]) {
                 if ($value.IsPresent) {
                     if ($param.OriginalName) { $__commandArgs += $param.OriginalName }
                 }
                 elseif ($param.DefaultMissingValue) { $__commandArgs += $param.DefaultMissingValue }
            }
            elseif ( $param.NoGap ) {
                $pFmt = "{0}{1}"
                if($value -match "\s") { $pFmt = "{0}""{1}""" }
                $__commandArgs += $pFmt -f $param.OriginalName, $value
            }
            else {
                if($param.OriginalName) { $__commandArgs += $param.OriginalName }
                $__commandArgs += $value | Foreach-Object {$_}
            }
        }
    }
    $__commandArgs = $__commandArgs | Where-Object {$_ -ne $null}
    if ($__boundParameters["Debug"]){wait-debugger}
    if ( $__boundParameters["Verbose"]) {
         Write-Verbose -Verbose -Message /usr/local/Cellar/mas/1.8.6/bin/mas
         $__commandArgs | Write-Verbose -Verbose
    }
    $__handlerInfo = $__outputHandlers[$PSCmdlet.ParameterSetName]
    if (! $__handlerInfo ) {
        $__handlerInfo = $__outputHandlers["Default"] # Guaranteed to be present
    }
    $__handler = $__handlerInfo.Handler
    if ( $PSCmdlet.ShouldProcess("/usr/local/Cellar/mas/1.8.6/bin/mas $__commandArgs")) {
    # check for the application and throw if it cannot be found
        if ( -not (Get-Command -ErrorAction Ignore "/usr/local/Cellar/mas/1.8.6/bin/mas")) {
          throw "Cannot find executable '/usr/local/Cellar/mas/1.8.6/bin/mas'"
        }
        if ( $__handlerInfo.StreamOutput ) {
            & "/usr/local/Cellar/mas/1.8.6/bin/mas" $__commandArgs | & $__handler
        }
        else {
            $result = & "/usr/local/Cellar/mas/1.8.6/bin/mas" $__commandArgs
            & $__handler $result
        }
    }
  } # end PROCESS

<#
.SYNOPSIS
List installed apps via App Store

.DESCRIPTION
List installed apps via App Store

.EXAMPLE
PS> Get-MasAppList

Get the list of installed apps.
Original Command: mas list


#>
}


function ParseMasVersion {
    param (
        [Parameter(Mandatory)]
        [string]$MasVersion
    )
    New-Object System.Management.Automation.SemanticVersion($MasVersion)
}


function Get-MasVersion
{
[PowerShellCustomFunctionAttribute(RequiresElevation=$False)]
[CmdletBinding()]

param(
[Parameter()]
[object]$String
    )

BEGIN {
    $__PARAMETERMAP = @{
         String = @{
               OriginalName = '--string'
               OriginalPosition = '0'
               Position = '2147483647'
               ParameterType = 'object'
               ApplyToExecutable = $False
               NoGap = $False
               }
    }

    $__outputHandlers = @{
        Default = @{ StreamOutput = $False; Handler = 'ParseMasVersion' }
    }
}

PROCESS {
    $__boundParameters = $PSBoundParameters
    $__defaultValueParameters = $PSCmdlet.MyInvocation.MyCommand.Parameters.Values.Where({$_.Attributes.Where({$_.TypeId.Name -eq "PSDefaultValueAttribute"})}).Name
    $__defaultValueParameters.Where({ !$__boundParameters["$_"] }).ForEach({$__boundParameters["$_"] = get-variable -value $_})
    $__commandArgs = @()
    $MyInvocation.MyCommand.Parameters.Values.Where({$_.SwitchParameter -and $_.Name -notmatch "Debug|Whatif|Confirm|Verbose" -and ! $__boundParameters[$_.Name]}).ForEach({$__boundParameters[$_.Name] = [switch]::new($false)})
    if ($__boundParameters["Debug"]){wait-debugger}
    $__commandArgs += 'version'
    foreach ($paramName in $__boundParameters.Keys|
            Where-Object {!$__PARAMETERMAP[$_].ApplyToExecutable}|
            Sort-Object {$__PARAMETERMAP[$_].OriginalPosition}) {
        $value = $__boundParameters[$paramName]
        $param = $__PARAMETERMAP[$paramName]
        if ($param) {
            if ($value -is [switch]) {
                 if ($value.IsPresent) {
                     if ($param.OriginalName) { $__commandArgs += $param.OriginalName }
                 }
                 elseif ($param.DefaultMissingValue) { $__commandArgs += $param.DefaultMissingValue }
            }
            elseif ( $param.NoGap ) {
                $pFmt = "{0}{1}"
                if($value -match "\s") { $pFmt = "{0}""{1}""" }
                $__commandArgs += $pFmt -f $param.OriginalName, $value
            }
            else {
                if($param.OriginalName) { $__commandArgs += $param.OriginalName }
                $__commandArgs += $value | Foreach-Object {$_}
            }
        }
    }
    $__commandArgs = $__commandArgs | Where-Object {$_ -ne $null}
    if ($__boundParameters["Debug"]){wait-debugger}
    if ( $__boundParameters["Verbose"]) {
         Write-Verbose -Verbose -Message /usr/local/Cellar/mas/1.8.6/bin/mas
         $__commandArgs | Write-Verbose -Verbose
    }
    $__handlerInfo = $__outputHandlers[$PSCmdlet.ParameterSetName]
    if (! $__handlerInfo ) {
        $__handlerInfo = $__outputHandlers["Default"] # Guaranteed to be present
    }
    $__handler = $__handlerInfo.Handler
    if ( $PSCmdlet.ShouldProcess("/usr/local/Cellar/mas/1.8.6/bin/mas $__commandArgs")) {
    # check for the application and throw if it cannot be found
        if ( -not (Get-Command -ErrorAction Ignore "/usr/local/Cellar/mas/1.8.6/bin/mas")) {
          throw "Cannot find executable '/usr/local/Cellar/mas/1.8.6/bin/mas'"
        }
        if ( $__handlerInfo.StreamOutput ) {
            & "/usr/local/Cellar/mas/1.8.6/bin/mas" $__commandArgs | & $__handler
        }
        else {
            $result = & "/usr/local/Cellar/mas/1.8.6/bin/mas" $__commandArgs
            & $__handler $result
        }
    }
  } # end PROCESS

<#
.SYNOPSIS
Print version number

.DESCRIPTION
Print version number

.PARAMETER String




.EXAMPLE
PS> Get-MasVersion

Gets the installed version of mas
Original Command: mas version


#>
}


