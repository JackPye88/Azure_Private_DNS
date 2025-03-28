Write-host @"
Starting script to create New Conditional Forwarder zones in On premises Domain Controllers.

"@

$AzureDCs = @("10.0.0.4","10.0.1.4")  # Replace with your actual Azure DNS IPs
$DNSzones = import-csv azure_pdns_zones.csv


foreach($PrivateDNSzone in $DNSzones){
    
    if($PrivateDNSzone.NAME -like "privatelink.*"){
        $PrivateDNSzone.NAME = $PrivateDNSzone.NAME.substring($("privatelink.").Length)
    }

    write-host "Creating new Conditional Forwarder zone for"$PrivateDNSzone.NAME
    Add-DnsServerConditionalForwarderZone -Name $PrivateDNSzone.NAME -MasterServers $AzureDCs

}

write-host @"
    
    Ending script. 

"@
write-host "New Conditional Forwarder zones created for"$DNSzones.count"Zones"