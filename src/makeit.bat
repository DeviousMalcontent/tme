@echo off

REM Find MASM32 install path.
IF EXIST "A:\masm32\bin\ml.exe" (set masmpath=A:\masm32)
IF EXIST "B:\masm32\bin\ml.exe" (set masmpath=B:\masm32)
IF EXIST "C:\masm32\bin\ml.exe" (set masmpath=C:\masm32)
IF EXIST "D:\masm32\bin\ml.exe" (set masmpath=D:\masm32)
IF EXIST "E:\masm32\bin\ml.exe" (set masmpath=E:\masm32)
IF EXIST "F:\masm32\bin\ml.exe" (set masmpath=F:\masm32)
IF EXIST "G:\masm32\bin\ml.exe" (set masmpath=G:\masm32)
IF EXIST "H:\masm32\bin\ml.exe" (set masmpath=H:\masm32)
IF EXIST "I:\masm32\bin\ml.exe" (set masmpath=I:\masm32)
IF EXIST "J:\masm32\bin\ml.exe" (set masmpath=J:\masm32)
IF EXIST "K:\masm32\bin\ml.exe" (set masmpath=K:\masm32)
IF EXIST "L:\masm32\bin\ml.exe" (set masmpath=L:\masm32)
IF EXIST "M:\masm32\bin\ml.exe" (set masmpath=M:\masm32)
IF EXIST "N:\masm32\bin\ml.exe" (set masmpath=N:\masm32)
IF EXIST "O:\masm32\bin\ml.exe" (set masmpath=O:\masm32)
IF EXIST "P:\masm32\bin\ml.exe" (set masmpath=P:\masm32)
IF EXIST "Q:\masm32\bin\ml.exe" (set masmpath=Q:\masm32)
IF EXIST "R:\masm32\bin\ml.exe" (set masmpath=R:\masm32)
IF EXIST "S:\masm32\bin\ml.exe" (set masmpath=S:\masm32)
IF EXIST "T:\masm32\bin\ml.exe" (set masmpath=T:\masm32)
IF EXIST "U:\masm32\bin\ml.exe" (set masmpath=U:\masm32)
IF EXIST "V:\masm32\bin\ml.exe" (set masmpath=V:\masm32)
IF EXIST "W:\masm32\bin\ml.exe" (set masmpath=W:\masm32)
IF EXIST "X:\masm32\bin\ml.exe" (set masmpath=X:\masm32)
IF EXIST "Y:\masm32\bin\ml.exe" (set masmpath=Y:\masm32)
IF EXIST "Z:\masm32\bin\ml.exe" (set masmpath=Z:\masm32)
IF "%masmpath%"=="" (
	ECHO Masm32 install path was not found.
	ECHO Looking in each drive letter under :\masm32\bin\ml.exe
	ECHO.
	ECHO You might have to edit this script or download and install masm32 SDK from https://www.masm32.com/
	ECHO.
	PAUSE	
	EXIT	
) ELSE (
		ECHO Masm32 install path was found.
)
REM Build resources if they exist.
if not exist rsrc.rc goto over1
%masmpath%\BIN\Rc.exe /v rsrc.rc
%masmpath%\BIN\Cvtres.exe /machine:ix86 rsrc.res
:over1

REM Clean up.
if exist %1.obj del TileMapEditor.obj
if exist %1.exe del TileMapEditor.exe

REM assemble the TileMapEditor.asm into an OBJ file.
%masmpath%\BIN\Ml.exe /c /coff TileMapEditor.asm
if errorlevel 1 goto errasm

if not exist rsrc.obj goto nores

REM link the main OBJ file with the resource OBJ file.
%masmpath%\BIN\Link.exe /SUBSYSTEM:WINDOWS TileMapEditor.obj rsrc.obj
if errorlevel 1 goto errlink
dir TileMapEditor.*
goto TheEnd

:nores
REM link the main OBJ file.
%masmpath%\BIN\Link.exe /SUBSYSTEM:WINDOWS TileMapEditor.obj
if errorlevel 1 goto errlink
dir TileMapEditor.*
goto TheEnd

:errlink
REM display message if there is an error during linking
echo.
echo There has been an error while linking this project.
echo.
goto TheEnd

:errasm
REM display message if there is an error during assembly
echo.
echo There has been an error while assembling this project.
echo.
goto TheEnd

:TheEnd

pause
