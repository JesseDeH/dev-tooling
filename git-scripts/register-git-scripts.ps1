# Get the directory where this script is located
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# Set git aliases using relative paths from script location
git config --global alias.nb "!git checkout develop && git pull origin develop && git checkout -b"
git config --global alias.merge-to-sprint "!sh '$scriptDir/git-merge-to-sprint.sh'"
git config --global alias.cleanup "!sh '$scriptDir/git-cleanup.sh'"