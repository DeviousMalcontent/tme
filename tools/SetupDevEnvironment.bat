@echo off

Rem get Git
IF NOT EXIST "git" (
	IF NOT EXIST "installGit.exe" (powershell -Command "(New-Object Net.WebClient).DownloadFile('https://github.com/git-for-windows/git/releases/download/v2.38.0.windows.1/PortableGit-2.38.0-32-bit.7z.exe', 'installGit.exe')")
	echo Installing Git...
	START /B /WAIT installGit.exe
	Del /Q installGit.exe
) else (
	echo Git was found.
	IF NOT EXIST "tme" ( 
		git\bin\git init
		git\bin\git clone https://github.com/DeviousMalcontent/tme.git ../../tme
	)
	else (
		echo The repo was found.
	)
)

Rem get Masm32
IF NOT EXIST "masm32" (
	powershell -Command "(New-Object Net.WebClient).DownloadFile('http://www.masm32.com/download/masm32v11r.zip', 'masm32v11r.zip')"
	powershell -command "Expand-Archive -Force 'masm32v11r.zip' 'masm32v11r'"
	START /B /WAIT masm32v11r\install.exe
	Del /Q masm32v11r.zip
	rmdir /s /q masm32v11r
) else (
	echo A Masm32 install was found.
)

Rem goto tools
CD tme\tools

Rem get Notepad Plus Plus
IF NOT EXIST "tme\tools\npp" (
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.4.6/npp.8.4.6.portable.zip', 'npp.8.4.6.portable.zip')"
powershell -command "Expand-Archive -Force 'npp.8.4.6.portable.zip' 'npp'"
Del /Q npp.8.4.6.portable.zip
) else (
	echo A Notepad Plus Plus install was found.
	)