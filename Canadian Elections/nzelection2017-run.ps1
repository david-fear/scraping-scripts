Param(
 [string]$up = "https://cdn.mediaworks.nz/aem/news/electionfeed/fetchParties.json",
 [string]$csv = "C:\temp\parties.csv"
)
 $jsonResponse = Invoke-WebRequest $up
 $data = $jsonResponse | ConvertFrom-Json
 foreach ($obj in $data.items)
 { 
  $line = ( Get-Date -UFormat "%drd %H:%M" )
  $line = $line + ( "," )
  $line = $line + ( $obj.partyid, "," , $obj.abbrev, "," , $obj.name, "," , $obj.partyvotes, "," , $obj.partyseats, "," , $obj.totalseats, "," , $obj.partyvotesp, "," , $obj.candidateseats )
  Write-Host $line
  $line | Out-File -Append $csv -Encoding UTF8
 } 
