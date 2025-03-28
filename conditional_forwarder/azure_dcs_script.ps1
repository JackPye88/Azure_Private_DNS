Write-host @"
Starting script to create New Conditional Forwarder zones on Azure Domain Controllers.
"@


$DNSzones = Import-Csv azure_pdns_zones.csv

foreach ($PrivateDNSzone in $DNSzones) {
    
    if ($PrivateDNSzone.NAME -like "privatelink.*") {
        $PrivateDNSzone.NAME = $PrivateDNSzone.NAME.Substring($("privatelink.").Length)
    }

    Write-Host "Creating new Conditional Forwarder zone for $($PrivateDNSzone.NAME)"

    Add-DnsServerConditionalForwarderZone -Name $PrivateDNSzone.NAME -MasterServers "168.63.129.16"  # Azure-provided DNS IP
}

Write-Host @"
Ending script. 
"@

Write-Host "New Conditional Forwarder zones created for $($DNSzones.Count) zones"