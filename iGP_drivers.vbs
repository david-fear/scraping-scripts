theURL = "http://igpmanager.com/play/?url=team-driver/"
'theURL = "http://igpmanager.com/play/?url=team-driver/199755"

dim driver_start, driver_end, driver_study, driver_total

dim r,c
Const ForReading = 1, ForWriting = 2, ForAppending = 8

dumpfile = "\\virdfs04\homedrives\dfear\Desktop\iGP\all_iGP_drivers.csv"
uptofile = "\\virdfs04\homedrives\dfear\Desktop\iGP\driver_up_to.txt"

Set fso = CreateObject("Scripting.FileSystemObject")
If Not fso.FileExists(dumpfile) then
  Set dump = fso.CreateTextFile(dumpfile)
  dump.writeline("Driver ID,Rating,Age,Health,Aggr,Antic,Brav,Charm,Compo,Deci,Feedbk,Focus,Influ,Morale,T/W,Work,Ref,Stam,Exp,Fast,OverT,Slow,Talent,Wet")
  dump.Close
End If
Set dump = fso.OpenTextFile(dumpfile, ForAppending, 0)

If Not fso.FileExists(uptofile) then
  Set upto = fso.CreateTextFile(uptofile)
  upto.write("0")
  upto.Close
End If
Set upto = fso.OpenTextFile(uptofile, ForReading, 0)
  driver_start = trim(upto.ReadLine)
  upto.Close

'----------------------------
driver_end = driver_start + 12948
'----------------------------

driver_study = driver_start - 1
driver_study_write = driver_start - 1
driver_total = 0

do while driver_study < driver_end
  driver_study_write = driver_study_write + 1
  Set upto = fso.OpenTextFile(uptofile, ForWriting, 0)
    upto.write(driver_study_write)
    upto.Close
	driver_study = driver_study + 1
  driver_total = 0
  dump.write(driver_study & ",")
  With CreateObject("InternetExplorer.Application")
    WScript.Sleep 50
    .Visible=False
    .Navigate(theURL & driver_study)
    .Visible=False
    Do until .ReadyState = 4 
      WScript.Sleep 50 
    Loop
    With .document
      WScript.Sleep 50 
      table_no = 0
      set theTables = .all.tags("table")
      nTables = theTables.length
      If (nTables = 4) Then
        For each table in theTables
          table_no = table_no + 1
          if table_no = 1 then
            td_rating = table.rows(0).cells(1).innerText
            td_rating = replace(td_rating, vbCr, "")
            td_rating = replace(td_rating, vbLf, "")
            td_age    = table.rows(3).cells(1).innerText
            td_health = table.rows(6).cells(1).innerText
            dump.write(td_rating & ",")
            dump.write(td_age & ",")
            dump.write(td_health & ",")
          end if
          if table_no = 3 then
            c = 0
            do until c = 12
              td = table.rows(0).cells(c).innerText
              td_attrib = trim(left(td,5))
              td_value = CInt(trim(right(td,2)))
              'wscript.echo ( td_attrib & " : " & td_value )
              dump.write(td_value & ",")
              driver_total = driver_total + td_value
              c = c + 1
            Loop
          c = 0
          do until c = 8
            td = table.rows(1).cells(c).innerText
            td_attrib = trim(left(td,5))
            td_value = CInt(trim(right(td,2)))
            ' wscript.echo ( td_attrib & " : " & td_value )
            dump.write(td_value & ",")
            driver_total = driver_total + td_value
            c = c + 1
          Loop
          End If 
        Next
      End If
    End With
    .quit
  End With

WScript.Sleep 50
dump.WriteLine(driver_total & "")

Randomize
WScript.Sleep (Rnd * 2000)

Loop

WScript.Echo "Done"

dump.Close
