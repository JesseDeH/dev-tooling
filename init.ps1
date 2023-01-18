# Install scoop
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
Try {
    scoop import .\scoop\scoopfile.json
} Catch {
    Invoke-RestMethod get.scoop.sh | Invoke-Expression
    scoop import .\scoop\scoopfile.json
}

# Install Font as Admin
Start-Process powershell -Verb runAs -ArgumentList "-file '.\scripts\Install-FiraCode.ps1'" -Wait

# Configure Oh-My-Posh Powershell Profile
Write-Host "Add oh-my-posh to Profile:"
Write-Host "oh-my-posh init pwsh --config 'C:\Users\jhde\source\repos\dev-tooling\oh-my-posh\jessedehaan.omp.json' | Invoke-Expression"
mkdir -p "$env:USERPROFILE\oh-my-posh"
Copy-Item -Path ".\oh-my-posh\jessedehaan.omp.json" -Destination "$env:USERPROFILE\oh-my-posh" -Force

$fileContent = Get-Content -Path $profile
if ($fileContent -match "# oh-my-posh profile") {
  Write-Output "Oh-my-posh already configured."
} else {
  $rows = "# oh-my-posh profile", "oh-my-posh init pwsh --config '$env:USERPROFILE\oh-my-posh\jessedehaan.omp.json' | Invoke-Expression"
  $rows | Out-File -FilePath $profile -Append
  Write-Output "Oh-my-posh configured."
}

# Configure Oh-My-Posh Clink
Write-Host "Adding oh-my-posh.lua to clink scripts folder"
Copy-Item -Path ".\oh-my-posh\oh-my-posh.lua" -Destination "$env:localappdata\Clink" -Force

# Configure Font in Windows Terminal
Write-Host "Add the following block to terminal profile (Ctrl-Shift-,)"
Write-Host @"
"profiles": {
    "defaults": {
      "font": {
        "face": "FiraCode NF"
      }
    }
}
"@
Read-Host
