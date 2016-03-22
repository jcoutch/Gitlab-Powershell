$BASE_API_URL = 'api/v3'

#
#	Gitlab module for PowerShell
#

function Set-ConnectionInfo {
	param (
		[Parameter(Mandatory=$true)]
		[string] $ServerName,

		[Parameter(Mandatory=$true)]
		[string] $PrivateToken,

		[Parameter(Mandatory=$false)]
		[string] $ResultsPerPage = 20
	)

	$env:GitlabServerName = $ServerName
	$env:GitlabPrivateToken = $PrivateToken
	$env:GitLabPerPage = $ResultsPerPage
}

function Set-GitlabPageSize {
	param (
		[Parameter(Mandatory=$true)]
		[string] $ServerName,

		[Parameter(Mandatory=$true)]
		[string] $PrivateToken
	)

	$env:GitlabServerName = $ServerName
	$env:GitlabPrivateToken = $PrivateToken
}

function Clear-ConnectionInfo {
	$env:GitlabServerName = $null
	$env:GitlabPrivateToken = $null
	$env:GitLabPerPage = $null
}


function Get-Projects {
	param (
		[string] $ServerName = $env:GitlabServerName,
		[string] $PrivateToken = $env:GitlabPrivateToken,
		[int] $Page = 1,
		[int] $PerPage = $env:GitLabPerPage
	)

	$method = "Get"
	$commandUri = "https://$ServerName/$BASE_API_URL/projects?private_token=$PrivateToken&page=$Page&per_page=$PerPage"
	$body = @{
	}

	Invoke-RestMethod -Method $method -Uri $commandUri -Body $body | %{ $_ }
}

function Get-Events {
	param (
		[Parameter(Mandatory=$true)]
		[string] $ProjectId,

		[string] $ServerName = $env:GitlabServerName,
		[string] $PrivateToken = $env:GitlabPrivateToken,
		[int] $Page = 1,
		[int] $PerPage = $env:GitLabPerPage
	)

	$method = "Get"
	$commandUri = "https://$ServerName/$BASE_API_URL/projects/$ProjectId/events?private_token=$PrivateToken&page=$Page&per_page=$PerPage"
	$body = @{
	}

	Invoke-RestMethod -Method $method -Uri $commandUri -Body $body
}

function Get-GitlabUser {
	param (
		[Parameter(Mandatory=$true)]
		[string] $UserId,

		[string] $ServerName = $env:GitlabServerName,
		[string] $PrivateToken = $env:GitlabPrivateToken,
		[int] $Page = 1,
		[int] $PerPage = $env:GitLabPerPage
	)

	$method = "Get"
	$commandUri = "https://$ServerName/$BASE_API_URL/users?private_token=$PrivateToken&page=$Page&per_page=$PerPage"
	$body = @{
	}

	Invoke-RestMethod -Method $method -Uri $commandUri -Body $body
}

Export-ModuleMember -Function 'Get-*'
Export-ModuleMember -Function 'Set-*'
Export-ModuleMember -Function 'Clear-*'
Export-ModuleMember -Function 'Add-*'
Export-ModuleMember -Function 'Remove-*'