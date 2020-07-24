# myutils

## My setup script

Run in powershell prompt

``` powershell
# Install scoop
iex (new-object net.webclient).downloadstring('https://get.scoop.sh')

# Install git - prerequisite for adding buckets
scoop install git

# Add buckets
scoop bucket add extras
scoop bucket add sriram https://github.com/sriramjiyer/MyScoopBucket.git

# Editors
scoop install vscode-portable vim

# keepass, start keepass to default generate config file, close
scoop install keepass
keepass
Start-Sleep -Seconds 5
keepass --exit-all

# keepass plugins
scoop install keepass-plugin-KPEnhancedEntryView keepass-buttons

# Azure
scoop install azure-cli
az extension add --name resource-graph

# MSSQL
scoop install azuredatastudio linqpad

# Microsoft Teams Mute toggle utility - avoiding because symantec antivirus quaranties the exe
# scoop install toggle_teams_mute_exe

# Microsoft Teams Mute toggle utility - ahk script
scoop install autohotkey toggle_teams_mute_ahk

```
