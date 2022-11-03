$controllers = @("DC1WLC9800-1","DC1WLC9800-2","DC1WLC9800-3")

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Accept", "application/yang-data+json")
$headers.Add("Authorization", "Basic $($env:DC1WLC9800_TOKEN)")

$capabilies = Invoke-RestMethod `
    "https://$($controllers[2])/restconf/data/netconf-state/capabilities" `
    -Method 'GET' -Headers $headers -SkipCertificateCheck

$myCapabilies= $capabilies.'ietf-netconf-monitoring:capabilities'.capability
$myCapabilies
