# aep-get.ps1 — run an authenticated GET against the Adobe Experience Platform REST API.
#
# GET is the ONLY method supported by this skill. The script reads the credentials
# stored by aep-session.ps1 and builds the required headers automatically:
#   Authorization: Bearer <ACCESS_TOKEN>
#   x-api-key: <API_KEY>
#   x-gw-ims-org-id: <ORG_ID>
#   x-sandbox-name: <SANDBOX>      (Platform services only, never for reactor.adobe.io)
#   Accept: <value>                (endpoint specific, defaults to application/json)
#
# Usage:
#   .\aep-get.ps1 -Url "https://platform.adobe.io/data/foundation/catalog/dataSets?limit=5"
#   .\aep-get.ps1 -Url "https://platform.adobe.io/..." -Accept "application/vnd.adobe.xed-full+json"
#   .\aep-get.ps1 -Url "https://platform.adobe.io/..." -NoSandbox
#   .\aep-get.ps1 -Url "https://platform.adobe.io/..." -DryRun        # print the request, do not send it
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)][string]$Url,
    [string]$Accept = 'application/json',
    [string]$Sandbox,
    [switch]$NoSandbox,
    [switch]$IncludeHeaders,
    [switch]$DryRun
)

$ErrorActionPreference = 'Stop'

$dir = Join-Path $env:TEMP 'opencode'
$path = Join-Path $dir 'aep-session.json'
if (-not (Test-Path $path)) {
    Write-Error "No AEP session found. Ask the user for ACCESS_TOKEN, ORG_ID and API_KEY, then run: .\aep-session.ps1 -AccessToken <t> -OrgId <o> -ApiKey <k> -Sandbox <s>"
    exit 2
}
$s = Get-Content $path -Raw | ConvertFrom-Json
if (-not $s.ACCESS_TOKEN -or -not $s.ORG_ID -or -not $s.API_KEY) {
    Write-Error "Incomplete AEP session (missing ACCESS_TOKEN, ORG_ID or API_KEY). Re-run .\aep-session.ps1."
    exit 2
}
if (-not $Sandbox) { $Sandbox = $s.SANDBOX }

if ($Url -notmatch '^https?://') {
    $Url = 'https://platform.adobe.io' + ($Url.TrimStart('/') -replace '^', '/')
}

$host_ = ([System.Uri]$Url).Host
$isPlatform = $host_.EndsWith('adobe.io') -and $host_ -ne 'reactor.adobe.io'

$curlArgs = @('-sS', '-X', 'GET', $Url,
    '-H', "Authorization: Bearer $($s.ACCESS_TOKEN)",
    '-H', "x-api-key: $($s.API_KEY)",
    '-H', "x-gw-ims-org-id: $($s.ORG_ID)",
    '-H', "Accept: $Accept")

if ($isPlatform -and -not $NoSandbox) {
    if (-not $Sandbox) {
        Write-Error "No sandbox selected. Ask the user which sandbox to use (or pass -NoSandbox for sandbox-management endpoints)."
        exit 2
    }
    $curlArgs += @('-H', "x-sandbox-name: $Sandbox")
}
if ($IncludeHeaders) { $curlArgs = @('-i') + $curlArgs }

if ($DryRun) {
    $safe = $curlArgs | ForEach-Object {
        if ($_ -match '^Authorization: Bearer ') { 'Authorization: Bearer <ACCESS_TOKEN>' }
        elseif ($_ -match '^x-api-key: ') { 'x-api-key: <API_KEY>' }
        else { $_ }
    }
    Write-Output ('curl.exe ' + (($safe | ForEach-Object { if ($_ -match '[\s&]') { '"' + $_ + '"' } else { $_ } }) -join ' '))
    return
}

& curl.exe @curlArgs
exit $LASTEXITCODE
