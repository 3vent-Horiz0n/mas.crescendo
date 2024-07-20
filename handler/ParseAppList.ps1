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
