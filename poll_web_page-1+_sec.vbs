dtmStartTime = Timer
dim i
dim TotalTime, LoadTime

Set objIE = CreateObject("InternetExplorer.Application")
objIE.Visible = 0

i = 0

dim filesys, filetxt 
Const ForReading = 1, ForWriting = 2, ForAppending = 8 
Set filesys = CreateObject("Scripting.FileSystemObject") 
Set filetxt = filesys.OpenTextFile("C:\poll_web_page.txt", ForAppending, True) 

filetxt.WriteLine("==Start==")

Do While i < 3000
 PrevTime = Round(Timer - dtmStartTime, 2)
 objIE.Navigate " http://testwebgateway.com/test/"
 Do While objIE.ReadyState <> 4
  WScript.Sleep 10
 Loop
 i = i + 1
 TotalTime = Round(Timer - dtmStartTime, 2)
 LoadTime = Round(TotalTime - PrevTime, 2)
 ' Wscript.Echo "Page Load (s): " & LoadTime
 if LoadTime > 1.0 then
   filetxt.WriteLine(TotalTime & "  :   " & LoadTime) 
 end if

 Wscript.sleep 250
Loop

filetxt.WriteLine("==End==")
filetxt.Close 





