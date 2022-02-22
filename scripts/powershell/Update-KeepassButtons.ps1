# Version 1.0.8
[CmdletBinding()]
param (
    [Parameter(Mandatory=$true,
    Position=0,
    ValueFromPipelineByPropertyName=$true,
    HelpMessage="Literal path to Keepass installation directory.")]
    [ValidateNotNullOrEmpty()]
    [string[]]
    $KeepassAppdir,

    [Parameter(Mandatory=$false,
    Position=1,
    ValueFromPipelineByPropertyName=$true,
    HelpMessage="Update action add/remove")]
    [ValidateSet('add','remove')]
    [String]
    $UpdateAction='add'
)

$ErrorActionPreference = 'stop'

$kpConfigFile = Join-Path -Path $KeepassAppdir -ChildPath 'KeePass.config.xml'

$myTriggersText = [xml]@'
<Triggers>
<Trigger>
    <Guid>1GT2YIzhBUm7lLOFOkG5Vg==</Guid>
    <Name>Add Buttons</Name>
    <Events>
        <Event>
            <TypeGuid>2PMe6cxpSBuJxfzi6ktqlw==</TypeGuid>
            <Parameters />
        </Event>
    </Events>
    <Conditions />
    <Actions>
        <Action>
            <TypeGuid>lYGPRZlmSYirPoboGpZoNg==</TypeGuid>
            <Parameters>
                <Parameter>101</Parameter>
                <Parameter>[Username]</Parameter>
                <Parameter>Autotype username</Parameter>
            </Parameters>
        </Action>
        <Action>
            <TypeGuid>lYGPRZlmSYirPoboGpZoNg==</TypeGuid>
            <Parameters>
                <Parameter>102</Parameter>
                <Parameter>[Password]</Parameter>
                <Parameter>Autotype Pasword</Parameter>
            </Parameters>
        </Action>
        <Action>
            <TypeGuid>lYGPRZlmSYirPoboGpZoNg==</TypeGuid>
            <Parameters>
                <Parameter>103</Parameter>
                <Parameter>[Username TAB Password]</Parameter>
                <Parameter>Autotype Username tab Password</Parameter>
            </Parameters>
        </Action>
        <Action>
            <TypeGuid>lYGPRZlmSYirPoboGpZoNg==</TypeGuid>
            <Parameters>
                <Parameter>105</Parameter>
                <Parameter>[Password ENTER]</Parameter>
                <Parameter>Autotype Password Enter</Parameter>
            </Parameters>
        </Action>
    </Actions>
</Trigger>
<Trigger>
    <Guid>LdZkL8sH2EyltfNt8pqBpQ==</Guid>
    <Name>101 [Userername]</Name>
    <Events>
        <Event>
            <TypeGuid>R0dZkpenQ6K5aB8fwvebkg==</TypeGuid>
            <Parameters>
                <Parameter>101</Parameter>
            </Parameters>
        </Event>
    </Events>
    <Conditions />
    <Actions>
        <Action>
            <TypeGuid>MXCPrWSTQ/WU7sgaI24yTQ==</TypeGuid>
            <Parameters>
                <Parameter>{USERNAME}</Parameter>
            </Parameters>
        </Action>
    </Actions>
</Trigger>
<Trigger>
    <Guid>UpJK4/v6/EqkucuhzYUhYw==</Guid>
    <Name>102 [Password]</Name>
    <Events>
        <Event>
            <TypeGuid>R0dZkpenQ6K5aB8fwvebkg==</TypeGuid>
            <Parameters>
                <Parameter>102</Parameter>
            </Parameters>
        </Event>
    </Events>
    <Conditions />
    <Actions>
        <Action>
            <TypeGuid>MXCPrWSTQ/WU7sgaI24yTQ==</TypeGuid>
            <Parameters>
                <Parameter>{PASSWORD}</Parameter>
            </Parameters>
        </Action>
    </Actions>
</Trigger>
<Trigger>
    <Guid>hjxcIJ84jkSnm4lB9/a0Og==</Guid>
    <Name>103 [Username TAB Password]</Name>
    <Events>
        <Event>
            <TypeGuid>R0dZkpenQ6K5aB8fwvebkg==</TypeGuid>
            <Parameters>
                <Parameter>103</Parameter>
            </Parameters>
        </Event>
    </Events>
    <Conditions />
    <Actions>
        <Action>
            <TypeGuid>MXCPrWSTQ/WU7sgaI24yTQ==</TypeGuid>
            <Parameters>
                <Parameter>{USERNAME}{TAB}{PASSWORD}</Parameter>
            </Parameters>
        </Action>
    </Actions>
</Trigger>
<Trigger>
    <Guid>76OZD8CemU6vwCAD+9vSsg==</Guid>
    <Name>104 [NewPassword TAB NewPassword]</Name>
    <Events>
        <Event>
            <TypeGuid>R0dZkpenQ6K5aB8fwvebkg==</TypeGuid>
            <Parameters>
                <Parameter>104</Parameter>
            </Parameters>
        </Event>
    </Events>
    <Conditions />
    <Actions>
        <Action>
            <TypeGuid>CfePcyTsT+yItiXVMPQ0bg==</TypeGuid>
            <Parameters>
                <Parameter />
                <Parameter>Confirm you wish to change password</Parameter>
                <Parameter>32</Parameter>
                <Parameter>4</Parameter>
                <Parameter>1</Parameter>
                <Parameter>1</Parameter>
                <Parameter>1</Parameter>
                <Parameter />
            </Parameters>
        </Action>
        <Action>
            <TypeGuid>MXCPrWSTQ/WU7sgaI24yTQ==</TypeGuid>
            <Parameters>
                <Parameter>{NEWPASSWORD}{TAB}{NEWPASSWORD}</Parameter>
            </Parameters>
        </Action>
        <Action>
            <TypeGuid>9VdhS/hMQV2pE3o5zRDwvQ==</TypeGuid>
            <Parameters />
        </Action>
    </Actions>
</Trigger>
<Trigger>
    <Guid>iD4ou+GjtkWQRh2RtopGtg==</Guid>
    <Name>105 [Password ENTER]</Name>
    <Events>
        <Event>
            <TypeGuid>R0dZkpenQ6K5aB8fwvebkg==</TypeGuid>
            <Parameters>
                <Parameter>105</Parameter>
            </Parameters>
        </Event>
    </Events>
    <Conditions />
    <Actions>
        <Action>
            <TypeGuid>MXCPrWSTQ/WU7sgaI24yTQ==</TypeGuid>
            <Parameters>
                <Parameter>{PASSWORD}{ENTER}</Parameter>
            </Parameters>
        </Action>
    </Actions>
</Trigger>
</Triggers>
'@

$MyUrlCustomOverridesText = @'
<CustomOverrides>
    <Override>
        <Enabled>true</Enabled>
        <Scheme>edgeguest</Scheme>
        <UrlOverride>cmd://"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" -guest https:{BASE:RMVSCM}</UrlOverride>
    </Override>
    <Override>
        <Enabled>true</Enabled>
        <Scheme>runasnetonly</Scheme>
        <UrlOverride>cmd://runas.exe /netonly /user:{USERNAME} "{T-CONV:/{BASE:PATH}/Uri-Dec/}"</UrlOverride>
    </Override>
    <Override>
        <Enabled>true</Enabled>
        <Scheme>edgepriv</Scheme>
        <UrlOverride>cmd://"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" -inprivate https:{BASE:RMVSCM}</UrlOverride>
    </Override>
</CustomOverrides>
'@

$myTriggers = [xml]$myTriggersText
$MyUrlCustomOverrides = [xml]$MyUrlCustomOverridesText

$DefaultFile = @"
<Configuration xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <Application>
    <Start>
      <CheckForUpdate>false</CheckForUpdate>
      <CheckForUpdateConfigured>true</CheckForUpdateConfigured>
    </Start>
    <TriggerSystem>
      $myTriggersText
    </TriggerSystem>
  </Application>
  <Integration>
    <UrlSchemeOverrides>
      $MyUrlCustomOverridesText
    </UrlSchemeOverrides>
  </Integration>
</Configuration>
"@

if (-Not (Test-Path -Path $kpConfigFile -PathType Leaf) ) {
    if ( $UpdateAction -eq 'add' ) {
        Set-Content -Path $kpConfigFile -Value $DefaultFile
    } else {
        exit 0
    }
} else {
    $kpConfig = [xml](Get-Content -Path $kpConfigFile)

    foreach ( $myTrigger in $myTriggers.SelectNodes('//Trigger') ) {
        $guid = $myTrigger.Guid
        $kpTrigger = $kpConfig.SelectSingleNode("//TriggerSystem/Triggers/Trigger/Guid[text()=""$guid""]")
        if ( $kpTrigger -ne $null) {
            if ($UpdateAction -eq 'add') {
                $null = $kpTrigger.ParentNode.ParentNode.ReplaceChild($kpConfig.ImportNode($myTrigger, $true), $kpTrigger.ParentNode)
            }
            else {
                $null = $kpTrigger.ParentNode.ParentNode.RemoveChild($kpTrigger.ParentNode)
            }
        }
        else {
            if ($UpdateAction -eq 'add') {
                $null = $kpConfig.SelectSingleNode('//TriggerSystem/Triggers').AppendChild($kpConfig.ImportNode($myTrigger, $true))
            }
        }
    }
    foreach ( $MyUrlCustomOverride in $MyUrlCustomOverrides.SelectNodes('//Override') ) {
        $Scheme = $MyUrlCustomOverride.Scheme
        $KpUrlCustomOverride = $kpConfig.SelectSingleNode("//Integration/UrlSchemeOverrides/CustomOverrides/Override/Scheme[text()=""$Scheme""]")
        if ( $KpUrlCustomOverride -ne $null) {
            if ($UpdateAction -eq 'add') {
                $null = $KpUrlCustomOverride.ParentNode.ParentNode.ReplaceChild($kpConfig.ImportNode($KpUrlCustomOverride, $true), $KpUrlCustomOverride.ParentNode)
            }
            else {
                $null = $KpUrlCustomOverride.ParentNode.ParentNode.RemoveChild($KpUrlCustomOverride.ParentNode)
            }
        }
        else {
            if ($UpdateAction -eq 'add') {
                $null = $kpConfig.SelectSingleNode('//Integration/UrlSchemeOverrides/CustomOverrides').AppendChild($kpConfig.ImportNode($MyUrlCustomOverride, $true))
            }
        }
    }

    $kpConfig.Save($kpConfigFile)
}
