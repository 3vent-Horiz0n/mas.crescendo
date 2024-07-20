function ParseMasVersion {
    param (
        [Parameter(Mandatory)]
        [string]$MasVersion
    )
    New-Object System.Management.Automation.SemanticVersion($MasVersion)
}