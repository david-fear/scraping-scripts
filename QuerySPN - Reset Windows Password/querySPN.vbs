' Copyright (c) Microsoft Corporation 2004 -
' File:        querySpn.vbs
' Contents:   Query a given SPN in a given forest to find the owners
' History:     7/7/2004   Craig Wiand   Created    
Option Explicit     
Const DUMP_SPNs = True
Dim oConnection, oCmd, oRecordSet
Dim oGC, oNSP
Dim strGCPath, strClass, strSPN, strADOQuery
Dim vObjClass, vSPNs, vName
Dim strOutput

FindSPN()

'--- Set up the connection ---
Set oConnection = CreateObject("ADODB.Connection")
Set oCmd = CReateObject("ADODB.Command")
oConnection.Provider = "ADsDSOObject"
oConnection.Open "ADs Provider"
Set oCmd.ActiveConnection = oConnection
oCmd.Properties("Page Size") = 1000

'--- Build the query string ---
strADOQuery = "<" + strGCPath + ">;(servicePrincipalName=" + strSPN + ");" & _
    "dnsHostName,distinguishedName,servicePrincipalName,objectClass," & _
        "samAccountName;subtree"
oCmd.CommandText = strADOQuery

'--- Execute the query for the object in the directory ---
Set oRecordSet = oCmd.Execute
If oRecordSet.EOF and oRecordSet.Bof Then
  MsgBox("No SPNs found!")
Else
 While Not oRecordset.Eof
   strOutput = strOutput & oRecordset.Fields("distinguishedName") & vbcrlf
   vObjClass = oRecordset.Fields("objectClass")
   strClass = vObjClass( UBound(vObjClass) )
   strOutput = strOutput & "Class: " & strClass
   If UCase(strClass) = "COMPUTER" Then
      strOutput = stroutput & "Computer DNS: " & oRecordset.Fields("dnsHostName") & vbcrlf
   Else
      strOutput = stroutput & "User Logon: " & oRecordset.Fields("samAccountName") & vbcrlf
   End If
   
   If DUMP_SPNs Then
      '--- Display the SPNs on the object --- 
      vSPNs = oRecordset.Fields("servicePrincipalName")
      For Each vName in vSPNs
         strOutput = stroutput &  "-- " + vName & vbcrlf
      Next
   End If
   strOutput = strOutput & vbcrlf
   oRecordset.MoveNext
 Wend
 MsgBox(strOutput)
End If


oRecordset.Close
oConnection.Close


Sub FindSPN()
    strSPN = InputBox( "Enter SPN: eg HTTP/test.mydomain.local" )
    '--- Get GC -- 
    Set oNSP = GetObject("GC:")
    For Each oGC in oNSP
      strGCPath = oGC.ADsPath
    Next
End Sub