# GitHub Vibe Kit — Setup Script (Windows PowerShell)
# Run: .\setup.ps1

param(
    [string]$ProjectPath = "."
)

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "================================" -ForegroundColor Cyan
Write-Host "   GitHub Vibe Kit — Setup      " -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan
Write-Host ""

$target = Resolve-Path $ProjectPath

# Step 1: Copy .github/ to project
Write-Host "[1/3] Copying .github/ to $target ..." -ForegroundColor Yellow
$src = Join-Path $PSScriptRoot ".github"
$dst = Join-Path $target ".github"
Copy-Item -Path $src -Destination $dst -Recurse -Force
Write-Host "      Done." -ForegroundColor Green

# Step 2: Copy .agent/ engine
Write-Host "[2/3] Copying .agent/ engine to $target ..." -ForegroundColor Yellow
$agentSrc = Join-Path $PSScriptRoot ".agent"
$agentDst = Join-Path $target ".agent"
Copy-Item -Path $agentSrc -Destination $agentDst -Recurse -Force
Write-Host "      Done." -ForegroundColor Green

# Step 3: Done
Write-Host ""
Write-Host "[3/3] Setup complete!" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "  1. Open $target in VS Code"
Write-Host "  2. Edit .github/copilot-instructions.md → update the 'YOUR PROJECT' section"
Write-Host "  3. Reload VS Code window (Ctrl+Shift+P → 'Reload Window')"
Write-Host "  4. Use 📎 → Prompt... in Copilot Chat to activate workflows and agents"
Write-Host ""
