
param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$Message
)

$ErrorActionPreference = "Stop"

# Always run from the script's directory
Set-Location -LiteralPath $PSScriptRoot

function Run-Git {
    param([string[]]$GitArgs)

    Write-Host "`n> git $($GitArgs -join ' ')" -ForegroundColor Cyan

    & git @GitArgs

    if ($LASTEXITCODE -ne 0) {
        throw "Git command failed: git $($GitArgs -join ' ')"
    }
}

try {
    # 1. Stage changes
    Run-Git @("add", ".")

    # 2. Commit
    Run-Git @("commit", "-m", $Message)

    # 3. Push dev
    Run-Git @("push", "origin", "dev")

    # 4. Switch to main
    Run-Git @("checkout", "main")

    # 5. Merge dev into main
    Run-Git @("merge", "dev")

    # 6. Push main
    Run-Git @("push", "origin", "main")

    # 7. Return to dev
    Run-Git @("checkout", "dev")

    Write-Host "`n--------------------------------" -ForegroundColor Green
    Write-Host "Successfully pushed and merged!" -ForegroundColor Green
    Write-Host "You are back on the dev branch." -ForegroundColor Green
    Write-Host "--------------------------------" -ForegroundColor Green
}
catch {
    Write-Host "`nERROR: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Resolve the issue manually before continuing." -ForegroundColor Yellow
    exit 1
}
