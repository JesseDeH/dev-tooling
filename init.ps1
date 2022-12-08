# Install scoop

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
Try {
    scoop import .\scoop\scoopfile.json
} Catch {
    irm get.scoop.sh | iex
    scoop import .\scoop\scoopfile.json
}

# Install Font as Admin
$test =  Get-Location
Write-Host $test
Start-Process powershell -Verb runAs -ArgumentList "-file '.\scripts\Install-FiraCode.ps1'" -Wait

# Configure Oh-My-Posh Profile
Write-Host "Add the following line to profile:"
Write-Host "oh-my-posh init pwsh --config 'C:\Users\jhde\source\repos\dev-tooling\oh-my-posh\jessedehaan.omp.json' | Invoke-Expression"
code $PROFILE
Read-Host

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

# Configure Clink
Write-Host "Add oh-my-posh.lua to clink scripts folder"
clink info
Read-Host
