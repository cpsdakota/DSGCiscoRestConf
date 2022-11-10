$controllers = @("DC1WLC9800-1","DC1WLC9800-2","DC1WLC9800-3")

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Accept", "application/yang-data+json")
$headers.Add("Authorization", "Basic $($env:DC1WLC9800_TOKEN)")
# $headers.Add("Authorization", "Basic YWRtaW4tY3NjaGFmZjpIaWdoISEh")S

#
# $capabilies = Invoke-RestMethod `
#     "https://$($controllers[2])/restconf/data/netconf-state/capabilities" `
#     -Method 'GET' -Headers $headers -SkipCertificateCheck

# $myCapabilies= $capabilies.'ietf-netconf-monitoring:capabilities'.capability
# $filterWireless = $myCapabilies | select-string wireless
# $filterWirelessAccessPoint = $myCapabilies | select-string wireless-access-point
# Cisco-IOS-XE-wireless-access-point-oper

# $capabiliesCfgRPC = Invoke-RestMethod `
#     "https://$($controllers[2])/restconf/data/Cisco-IOS-XE-wireless-access-point-cfg-rpc" `
#     -Method 'GET' -Headers $headers -SkipCertificateCheck

Remove-Variable macs
$macs = $controllers | Foreach-Object -ThrottleLimit 3 -Parallel {
    #Action that will run in Parallel. Reference the current object via $PSItem and bring in outside variables with $USING:varname
    $uri = "https://$($_)/restconf/data/Cisco-IOS-XE-wireless-access-point-oper:access-point-oper-data/ap-name-mac-map"

    try{
        $response = Invoke-RestMethod -Uri $uri -Method 'GET' -Headers $USING:headers -SkipCertificateCheck
    }
    catch {$response = $null}


    if ($response){
        Remove-Variable apNameMacMap
        $apNameMacMap = $response.'Cisco-IOS-XE-wireless-access-point-oper:ap-name-mac-map'
        $apNameMacMap | Add-Member -Name "controller" -MemberType NoteProperty -Value $($_) -Force
        $apNameMacMap
    }
}
$macs | Select-Object -First 5
