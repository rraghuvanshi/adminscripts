$path = import-csv -Path "C:\analysis\iplist01.csv"

$ADCompTable = foreach ($item in $path) {

$ip = $item.ip

$rdns = Resolve-DnsName $ip #| select Name, NameHost | export-csv c:\audit\names.csv -append

$hname = $rdns.NameHost

$hostname = $hname.split(".")[0]

$OUpath = Get-ADComputer $hostname

[PSCustomObject]@{
                   "ip" = $ip
                   "Name" = $hostname
                   "OUPath" = $OUpath.DistinguishedName
               }

}

#Exporting to CSV. 
$ADCompTable | Select-Object -Property "ip", "Name", "OUpath" | Export-csv "C:\analysis\22octfathima.csv" -notypeinformation
