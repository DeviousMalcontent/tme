'cscript //nologo Tiles2MapDefs.vbs "File name.txt" "A name for the tile..."
On Error Resume Next
Const ForReading = 1
Set objFSO = Createobject("Scripting.FileSystemObject")
Set objStdOut = WScript.StdOut
Set objStdIn = WScript.StdIn
outFile = "..\src\TilesDef.txt"

Select Case WScript.Arguments.Count
Case 0
	objStdOut.Write "Text file input: "
    File = objStdIn.ReadLine
	objStdOut.Write "Title Name: "
    titleName = objStdIn.ReadLine
Case Else
	File = WScript.Arguments(0)
	titleName = WScript.Arguments(1)
End Select

Set objFile = objFSO.OpenTextFile(File,ForReading)

do while not objFile.AtEndOfStream
     LineTemp = objFile.ReadLine()
	 LineTemp = Split(LineTemp,"#")
	 Line = Mid(LineTemp(1), 1, 6)

	 Select case Line
		case "000000"
				LineOut = LineOut & "0"
		case "FF0000"
				LineOut = LineOut & "1"
		case "7F0000"
				LineOut = LineOut & "2"
		case "FF6A00"
				LineOut = LineOut & "3"
		case "7F3300"
				LineOut = LineOut & "4"
		case "0094FF"
				LineOut = LineOut & "5"
		case "0026FF"
				LineOut = LineOut & "6"
		case "4CFF00"
				LineOut = LineOut & "7"
		case "007F0E"
				LineOut = LineOut & "8"
		case "808080"
				LineOut = LineOut & "9"
		case "404040"
				LineOut = LineOut & "A"
		case "FFD800"
				LineOut = LineOut & "B"
		case "7F6A00"
				LineOut = LineOut & "C"
		case "FF00DC"
				LineOut = LineOut & "D"
		case "B200FF"
				LineOut = LineOut & "E"
		case "FFFFFF"
				LineOut = LineOut & "F"
		case else
	 End select
loop
objFile.Close

If objFSO.FileExists(outFile) Then
    Set objFile = objFSO.OpenTextFile(outFile, 8)
Else
    Set objFile = objFSO.CreateTextFile(outFile, True)
End If

Set objFile = objFSO.CreateTextFile(outFile,True)
objFile.Write LineOut & "," & Chr(34) & titleName & Chr(34) & vbCrLf 
objFile.Close