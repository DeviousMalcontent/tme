@ECHO off
REM goto root
CD /

REM get 7-Zip
IF NOT EXIST "tme\tools\7zr.exe" (
MKDIR "tme\tools\"
CD "tme\tools\"
ECHO Installing 7-Zip console executable...
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://www.7-zip.org/a/7zr.exe', '7zr.exe')"
) ELSE (
	ECHO The 7-Zip console executable install was found.
)

REM goto root
CD /

REM get 7-Zip
IF NOT EXIST "tme\tools\7z\7zG.exe" (
CD "tme\tools\"
ECHO Installing 7-Zip GUI executable...
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://www.7-zip.org/a/7z2201.exe', '7z2201.exe')"
7zr.exe x 7z2201.exe -o\tme\tools\7z
DEL /Q 7z2201.exe
) ELSE (
	ECHO The 7-Zip GUI executable install was found.
)

REM goto root
CD /

REM get Git
IF NOT EXIST "git" (
	IF NOT EXIST "installGit.exe" (powershell -Command "(New-Object Net.WebClient).DownloadFile('https://github.com/git-for-windows/git/releases/download/v2.38.0.windows.1/PortableGit-2.38.0-32-bit.7z.exe', 'installGit.exe')")
	ECHO Installing Git...
	rem START /B /WAIT installGit.exe
	tme\tools\7zr.exe x installGit.exe -o\git
	DEL /Q installGit.exe
	
	rem Rename tme to tmeTMP
	IF EXIST "tme" (REN tme tmeTMP)
	git\bin\git init
	git\bin\git clone https://github.com/DeviousMalcontent/tme.git ../../tme
	
	rem Move contents of tmeTMP to tme
	IF EXIST "tme" (xcopy /E tmeTMP tme)
	rem Delete tmeTMP
	IF EXIST "tmeTMP" (RMDIR /Q /S tmeTMP)
	
) ELSE (
	ECHO Git was found.
	IF NOT EXIST "tme" (
		git\bin\git init
		git\bin\git clone https://github.com/DeviousMalcontent/tme.git ../../tme
	)
	ELSE (
		ECHO The repo was found.
	)
)

REM goto root
CD /

REM get Masm32
IF NOT EXIST "masm32" (
    ECHO Installing MASM32...
	powershell -Command "(New-Object Net.WebClient).DownloadFile('http://www.masm32.com/download/masm32v11r.zip', 'masm32v11r.zip')"
	powershell -command "Expand-Archive -Force 'masm32v11r.zip' 'masm32v11r'"
	rem START /B /WAIT masm32v11r\install.exe
	tme\tools\7zr.exe x ../../masm32v11r/install.exe -o\masm32
	CD \masm32\
	CD include
	CALL bldlibs.bat
	CD ..

	CD tools\makecimp
	CALL makevcrt.bat
	CD ..\..

	CD m32lib
	powershell -Command "((Get-Content -path make.bat -Raw) -replace 'DEL masm32.lib','DEL /Q masm32.lib') | Set-Content -Path make.bat"
	ECHO exit >> make.bat
	START /B /WAIT make.bat
	rem pause
	CD ..

	CD fpulib
	CALL make.bat
	CD ..

	CD DateTime
	powershell -Command "((Get-Content -path make.bat -Raw) -replace 'DEL DateTime.lib','DEL /Q DateTime.lib') | Set-Content -Path make.bat"
	ECHO exit >> make.bat
	START /B /WAIT make.bat
	CD ..

	CD vkdebug
	CALL setup.bat
	CD /
	DEL /Q masm32v11r.zip
	RMDIR /s /q masm32v11r
) ELSE (
	ECHO A Masm32 install was found.
)

REM goto root
CD /

REM get Notepad Plus Plus
IF NOT EXIST "tme\tools\npp" (
CD "tme\tools\"
ECHO Installing Notepad Plus Plus...
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.4.6/npp.8.4.6.portable.zip', 'npp.8.4.6.portable.zip')"
powershell -command "Expand-Archive -Force 'npp.8.4.6.portable.zip' 'npp'"
DEL /Q npp.8.4.6.portable.zip
) ELSE (
	ECHO A Notepad Plus Plus install was found.
)

REM goto root
CD /

REM get ImageMagick
IF NOT EXIST "tme\tools\ImageMagick" (
CD "tme\tools\"
ECHO Installing ImageMagick...
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://imagemagick.org/archive/binaries/ImageMagick-7.1.0-portable-Q16-x86.zip, 'ImageMagick-7.1.0-portable-Q16-x86.zip')"
powershell -command "Expand-Archive -Force 'ImageMagick-7.1.0-portable-Q16-x86.zip' 'ImageMagick'"
DEL /Q ImageMagick-7.1.0-portable-Q16-x86.zip
) ELSE (
	ECHO A ImageMagick install was found.
)

REM goto root
CD /

IF NOT EXIST "%windir%\Fonts\wingding.ttf" (
ECHO Installing fonts...
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://archive.org/download/windows-3.1-live-cd/windows%%203.1%%20live%%20cd.iso/Win31%%2FSYSTEM%%2FWINGDING.TTF', 'wingding.ttf')"
MOVE wingding.ttf %windir%\Fonts\wingding.ttf
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" /v "Wingdings (TrueType)" /t REG_SZ /d wingding.ttf /f
) ELSE (
	ECHO Wingding TrueType Font was found.
)

IF NOT EXIST "%windir%\Fonts\wingdings2.ttf" (
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://archive.org/download/microsoft-office-97-professional_202112/Microsoft%%20Office%%2097%%20Professional.iso/ValuPack%%2FMSFonts%%2FWINGDNG2.TTF', 'wingdings2.ttf')"
MOVE wingdings2.ttf %windir%\Fonts\wingdings2.ttf
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" /v "Wingdings 2 (TrueType)" /t REG_SZ /d wingdings2.ttf /f
) ELSE (
	ECHO Wingdings 2 TrueType Font was found.
)

IF NOT EXIST "%windir%\Fonts\wingdings3.ttf" (
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://archive.org/download/microsoft-office-97-professional_202112/Microsoft%%20Office%%2097%%20Professional.iso/ValuPack%%2FMSFonts%%2FWINGDNG3.TTF', 'wingdings3.ttf')"
MOVE wingdings3.ttf %windir%\Fonts\wingdings3.ttf
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" /v "Wingdings 3 (TrueType)" /t REG_SZ /d wingdings3.ttf /f
) ELSE (
	ECHO Wingdings 3 TrueType Font was found.
)

REM goto root
CD /

IF EXIST "tme\tools\" (
CD "tme\tools\"

REM Make .gitignore
ECHO npp/*.* >> .gitignore
ECHO npp/ >> .gitignore
ECHO ImageMagick/ >> .gitignore
ECHO ImageMagick/*.* >> .gitignore
ECHO 7zr.exe >> .gitignore
ECHO 7z/*.* >> .gitignore

)

ECHO.
ECHO Environment has never been set up.

PAUSE