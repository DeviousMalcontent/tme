'cscript PSOutputASCIIHelper.vbs "test.pal"
Set objFSO = Createobject("Scripting.FileSystemObject")
Set objStdOut = WScript.StdOut
Set objStdIn = WScript.StdIn

Select Case WScript.Arguments.Count
Case 0
	objStdOut.Write "Text file output: "
    OutTextFile = objStdIn.ReadLine
Case Else
	OutTextFile = WScript.Arguments(0)
End Select

Set objFile = objFSO.CreateTextFile(OutTextFile,True)
'objFile.Write "test string" & vbCrLf
objFile.Write Chr(&H43) & Chr(&H1C) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&HFF) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H7F) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&HFF) & Chr(&H6A) & Chr(&H00) & Chr(&H00) & Chr(&H7F) & Chr(&H33) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H94) & Chr(&HFF) & Chr(&H00) & Chr(&H00) & Chr(&H26) & Chr(&HFF) & Chr(&H00) & Chr(&H4C) & Chr(&HFF) & Chr(&H00) & Chr(&H00) & Chr(&H00) & Chr(&H7F) & Chr(&H0E) & Chr(&H00) & Chr(&H80) & Chr(&H80) & Chr(&H80) & Chr(&H00) & Chr(&H40) & Chr(&H40) & Chr(&H40) & Chr(&H00) & Chr(&HFF) & Chr(&HD8) & Chr(&H00) & Chr(&H00) & Chr(&H7F) & Chr(&H6A) & Chr(&H00) & Chr(&H00) & Chr(&HFF) & Chr(&H00) & Chr(&HDC) & Chr(&H00) & Chr(&HB2) & Chr(&H00) & Chr(&HFF) & Chr(&H00) & Chr(&HFF) & Chr(&HFF) & Chr(&HFF) & Chr(&H00) & Chr(&HFF) & Chr(&HFF) & Chr(&HFF) & Chr(&H00) & Chr(&HFF) & Chr(&HFF) & Chr(&HFF) & Chr(&H00) & Chr(&HFF) & Chr(&HFF) & Chr(&HFF) & Chr(&H00) & Chr(&HFF) & Chr(&HFF) & Chr(&HFF) & Chr(&H00) & Chr(&HFF) & Chr(&HFF) & Chr(&HFF) & Chr(&H00) & Chr(&HFF) & Chr(&HFF) & Chr(&HFF) & Chr(&H00) & Chr(&HFF) & Chr(&HFF) & Chr(&HFF) & Chr(&H00) & Chr(&HFF) & Chr(&HFF) & Chr(&HFF) & Chr(&H00) & Chr(&HFF) & Chr(&HFF) & Chr(&HFF) & Chr(&H00) & Chr(&HFF) & Chr(&HFF) & Chr(&HFF) & Chr(&H00) & Chr(&HFF) & Chr(&HFF) & Chr(&HFF) & Chr(&H00) & Chr(&HFF) & Chr(&HFF) & Chr(&HFF) & Chr(&H00)
objFile.Close
