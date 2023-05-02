' not quite working

Param(
 [string]$up = "https://electionsapi.cp.org/api/federal2019/Totals_By_Party",
 [string]$csv = "C:\temp\SCRIPTS\canadianelections.csv"
)
 [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
 $jsonResponse = Invoke-RestMethod $up
# $data = $jsonResponse | Out-String | ConvertFrom-Json
 $data= $jsonResponse
 foreach ($obj in $data.items)
 { 
  $line = ( Get-Date -UFormat "%drd %H:%M" )
  $line = $line + ( "," )
  $line = $line + ( $obj.'Name_En', $obj, $obj.Name_En, "," , $obj.abbrev, "," , $obj.name, "," , $obj.partyvotes, "," , $obj.partyseats, "," , $obj.totalseats, "," , $obj.partyvotesp, "," , $obj.candidateseats )
  Write-Host $line
  $line | Out-File -Append $csv -Encoding UTF8
 } 
