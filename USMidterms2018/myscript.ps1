$source="https://www.theguardian.com/us-news/ng-interactive/2018/nov/06/midterm-elections-2018-live-results-latest-winners-and-seats"
$timestamp=Get-Date -UFormat "%Y%m%d-%H%M"
$destination="C:\users\davidf\Documents\Politics\USMidterms2018\"
$outfile=-join($destination,$timestamp,".html")
curl $source -OutFile $outfile
Exit-PSSession
exit