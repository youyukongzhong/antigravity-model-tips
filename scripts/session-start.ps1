[Console]::InputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$ErrorActionPreference = "Stop"

try {
  $rawInput = [Console]::In.ReadToEnd()
  $pluginRoot = Split-Path -Parent $PSScriptRoot
  $stateDir = if ($env:PLUGIN_DATA) { $env:PLUGIN_DATA } else { Join-Path $pluginRoot ".cache" }
  if (-not (Test-Path $stateDir)) {
    New-Item -ItemType Directory -Force -Path $stateDir | Out-Null
  }

  $now = [DateTimeOffset]::UtcNow.ToUnixTimeSeconds()

  # 1. Silent background git pull (at most once every 12 hours, non-blocking)
  $syncStampFile = Join-Path $stateDir "last_git_sync.txt"
  $lastSync = 0L
  if (Test-Path $syncStampFile) {
    [void][long]::TryParse((Get-Content $syncStampFile -Raw).Trim(), [ref]$lastSync)
  }
  if (($now - $lastSync) -ge 43200) {
    Set-Content -Path $syncStampFile -Value "$now" -Encoding ASCII -NoNewline
    if (Test-Path (Join-Path $pluginRoot ".git")) {
      try {
        Start-Process -FilePath "git" -ArgumentList @("-C", $pluginRoot, "pull", "--ff-only", "--quiet") -WindowStyle Hidden -ErrorAction SilentlyContinue | Out-Null
      } catch {}
    }
  }

  # 2. Check whether current session's modelName is already in our cheat sheet
  if (-not $rawInput -or -not $rawInput.Trim()) {
    Write-Output "{}"
    exit 0
  }

  $payload = $rawInput | ConvertFrom-Json
  $modelName = if ($null -ne $payload.modelName) { ([string]$payload.modelName).Trim() } else { "" }
  if (-not $modelName) {
    Write-Output "{}"
    exit 0
  }

  $modelLower = $modelName.ToLowerInvariant()
  $isKnown = $false

  foreach ($file in @((Join-Path $pluginRoot "known_models.txt"), (Join-Path $pluginRoot "local_models.txt"))) {
    if (Test-Path $file) {
      foreach ($line in (Get-Content -Path $file -Encoding UTF8)) {
        $kw = $line.Trim().ToLowerInvariant()
        if ($kw -and -not $kw.StartsWith("#")) {
          if ($modelLower.Contains($kw)) {
            $isKnown = $true
            break
          }
        }
      }
    }
    if ($isKnown) { break }
  }

  if ($isKnown) {
    Write-Output "{}"
    exit 0
  }

  # Throttle reminder per unknown model (once every 24 hours) so it never nags
  $safeKey = ($modelLower -replace '[^a-z0-9_-]', '_')
  $remindFile = Join-Path $stateDir "reminded_$safeKey.txt"
  $lastRemind = 0L
  if (Test-Path $remindFile) {
    [void][long]::TryParse((Get-Content $remindFile -Raw).Trim(), [ref]$lastRemind)
  }
  if (($now - $lastRemind) -lt 86400) {
    Write-Output "{}"
    exit 0
  }
  Set-Content -Path $remindFile -Value "$now" -Encoding ASCII -NoNewline

  $tip = "> 💡 **模型小抄发现新面孔**：当前模型 **``$modelName``** 尚未收录进你的 ``/m`` 速查表。随时输入 **``/m-sync``**（也可直接附带模型菜单截图），即可自动联网查清定位并加入本地小抄。"
  $out = @{
    injectSteps = @(
      @{
        systemMessage = @{
          systemMessage = ""
          metadata = @{
            user_markdown = $tip
          }
        }
      }
    )
  } | ConvertTo-Json -Depth 6 -Compress

  Write-Output $out
  exit 0
} catch {
  Write-Output "{}"
  exit 0
}
