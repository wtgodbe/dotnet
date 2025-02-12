[CmdletBinding()]
param(
  [Parameter(Mandatory=$true)]
  [String]$filePath,

  [Parameter(Mandatory=$true)]
  [String]$outputPath
)

$jsonContent = Get-Content -Path $filePath -Raw | ConvertFrom-Json

foreach ($repo in $jsonContent.repositories) {
    $remoteUri = $repo.remoteUri
    $commitSha = $repo.commitSha
    $path = "$outputPath$($repo.path)"
    $darcCommand = "darc gather-drop -c $commitSha -r $remoteUri --non-shipping --skip-existing --continue-on-error -o $path"
    Write-Output "Executing command: $darcCommand"
    Invoke-Expression $darcCommand
}