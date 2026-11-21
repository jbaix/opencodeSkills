# aep-session.ps1 — store/read the Adobe Experience Platform session credentials.
#
# The credentials are kept in a JSON file inside the OS temp folder so they can be
# reused for the rest of the session without re-asking the user. Nothing is printed
# in clear text: -Show masks the access token.
#
# Usage:
#   .\aep-session.ps1 -AccessToken <t> -OrgId <o> -ApiKey <k> -Sandbox <s>
#   .\aep-session.ps1 -Show
#   .\aep-session.ps1 -Clear
[CmdletBinding()]
param(
    [string]$AccessToken,
    [string]$OrgId,
    [string]$ApiKey,
    [string]$Sandbox,
    [switch]$Show,
    [switch]$Clear
)

$ErrorActionPreference = 'Stop'

$dir = Join-Path $env:TEMP 'opencode'
if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
$path = Join-Path $dir 'aep-session.json'

function Mask([string]$v) {
    if ([string]::IsNullOrEmpty($v)) { return '(not set)' }
    if ($v.Length -le 10) { return ('*' * $v.Length) }
    return ($v.Substring(0, 6) + '...' + $v.Substring($v.Length - 4) + " (len=$($v.Length))")
}

if ($Clear) {
    if (Test-Path $path) { Remove-Item $path -Force }
    Write-Output 'AEP session cleared.'
    return
}

# Load current state (hashtable)
$state = @{ ACCESS_TOKEN = ''; ORG_ID = ''; API_KEY = ''; SANDBOX = ''; UPDATED = '' }
if (Test-Path $path) {
    try {
        $existing = Get-Content $path -Raw | ConvertFrom-Json
        foreach ($k in @('ACCESS_TOKEN','ORG_ID','API_KEY','SANDBOX','UPDATED')) {
            if ($existing.PSObject.Properties.Name -contains $k -and $existing.$k) { $state[$k] = $existing.$k }
        }
    } catch { Write-Warning "Could not read existing session file; starting fresh." }
}

if ($Show) {
    if (-not (Test-Path $path)) { Write-Output 'No AEP session file found. Provide credentials first.'; return }
    Write-Output ("ACCESS_TOKEN : {0}" -f (Mask $state.ACCESS_TOKEN))
    Write-Output ("ORG_ID       : {0}" -f $state.ORG_ID)
    Write-Output ("API_KEY      : {0}" -f (Mask $state.API_KEY))
    Write-Output ("SANDBOX      : {0}" -f $state.SANDBOX)
    Write-Output ("UPDATED      : {0}" -f $state.UPDATED)
    return
}

if ($AccessToken) { $state.ACCESS_TOKEN = $AccessToken }
if ($OrgId)       { $state.ORG_ID       = $OrgId }
if ($ApiKey)      { $state.API_KEY      = $ApiKey }
if ($Sandbox)     { $state.SANDBOX      = $Sandbox }
$state.UPDATED = (Get-Date).ToString('s')

$json = $state | ConvertTo-Json
Set-Content -Path $path -Value $json -Encoding UTF8

Write-Output 'AEP session saved.'
Write-Output ("ACCESS_TOKEN : {0}" -f (Mask $state.ACCESS_TOKEN))
Write-Output ("ORG_ID       : {0}" -f $state.ORG_ID)
Write-Output ("API_KEY      : {0}" -f (Mask $state.API_KEY))
Write-Output ("SANDBOX      : {0}" -f $state.SANDBOX)
