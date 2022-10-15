@ECHO off
ECHO Converting Bitmap Tiles to Text-based Tile definitions...

REM Clean Up.
CD ..\res\tiles\
DEL /S *.txt
CD ..\..\tools\
IF EXIST "..\src\TilesDef.txt" (DEL /S "..\src\TilesDef.txt")

REM Walls - 0 to 50
ImageMagick\convert ..\res\tiles\tile000.bmp txt:- >> ..\res\tiles\tile000.txt
powershell ./Tiles2MapDefs.ps1 ..\res\tiles\tile000.txt "Nothing"
REM cscript //nologo Tiles2MapDefs.vbs ..\res\tiles\tile000.txt "Nothing"
ImageMagick\convert ..\res\tiles\tile001.bmp txt:- >> ..\res\tiles\tile001.txt
powershell ./Tiles2MapDefs.ps1 ..\res\tiles\tile001.txt "Red Wall"
REM cscript //nologo Tiles2MapDefs.vbs ..\res\tiles\tile001.txt "Red Wall"
ImageMagick\convert ..\res\tiles\tile002.bmp txt:- >> ..\res\tiles\tile002.txt
powershell ./Tiles2MapDefs.ps1 ..\res\tiles\tile002.txt "Orange Wall"
REM cscript //nologo Tiles2MapDefs.vbs ..\res\tiles\tile002.txt "Orange wall"
ImageMagick\convert ..\res\tiles\tile003.bmp txt:- >> ..\res\tiles\tile003.txt
powershell ./Tiles2MapDefs.ps1 ..\res\tiles\tile003.txt "Blue Wall"
REM cscript //nologo Tiles2MapDefs.vbs ..\res\tiles\tile003.txt "Blue wall"
ImageMagick\convert ..\res\tiles\tile004.bmp txt:- >> ..\res\tiles\tile004.txt
powershell ./Tiles2MapDefs.ps1 ..\res\tiles\tile004.txt "Grey Wall"
REM cscript //nologo Tiles2MapDefs.vbs ..\res\tiles\tile004.txt "Grey wall"

REM Floors - 51 to 100

REM Objects - 101 to 150
ImageMagick\convert ..\res\tiles\tile101.bmp txt:- >> ..\res\tiles\tile101.txt
powershell ./Tiles2MapDefs.ps1 ..\res\tiles\tile101.txt "Player Start East"
REM cscript //nologo Tiles2MapDefs.vbs ..\res\tiles\tile101.txt "Player Start East"
ImageMagick\convert ..\res\tiles\tile102.bmp txt:- >> ..\res\tiles\tile102.txt
powershell ./Tiles2MapDefs.ps1 ..\res\tiles\tile102.txt "Player Start West"
REM cscript //nologo Tiles2MapDefs.vbs ..\res\tiles\tile102.txt "Player Start West"
ImageMagick\convert ..\res\tiles\tile103.bmp txt:- >> ..\res\tiles\tile103.txt
powershell ./Tiles2MapDefs.ps1 ..\res\tiles\tile103.txt "Player Start South"
REM cscript //nologo Tiles2MapDefs.vbs ..\res\tiles\tile103.txt "Player Start South"
ImageMagick\convert ..\res\tiles\tile104.bmp txt:- >> ..\res\tiles\tile104.txt
powershell ./Tiles2MapDefs.ps1 ..\res\tiles\tile104.txt "Player Start North"
REM cscript //nologo Tiles2MapDefs.vbs ..\res\tiles\tile104.txt "Player Start North"
ImageMagick\convert ..\res\tiles\tile105.bmp txt:- >> ..\res\tiles\tile105.txt
powershell ./Tiles2MapDefs.ps1 ..\res\tiles\tile105.txt "Health Pickup"
REM cscript //nologo Tiles2MapDefs.vbs ..\res\tiles\tile105.txt "Health Pickup"
ImageMagick\convert ..\res\tiles\tile106.bmp txt:- >> ..\res\tiles\tile106.txt
powershell ./Tiles2MapDefs.ps1 ..\res\tiles\tile106.txt "Amour Pickup"
REM cscript //nologo Tiles2MapDefs.vbs ..\res\tiles\tile106.txt "Amour Pickup"
ImageMagick\convert ..\res\tiles\tile107.bmp txt:- >> ..\res\tiles\tile107.txt
powershell ./Tiles2MapDefs.ps1 ..\res\tiles\tile107.txt "Sword Pickup"
REM cscript //nologo Tiles2MapDefs.vbs ..\res\tiles\tile107.txt "Sword Pickup"
ImageMagick\convert ..\res\tiles\tile108.bmp txt:- >> ..\res\tiles\tile108.txt
powershell ./Tiles2MapDefs.ps1 ..\res\tiles\tile108.txt "Gold Coins Pickup"
REM cscript //nologo Tiles2MapDefs.vbs ..\res\tiles\tile108.txt "Gold Coins Pickup"
ImageMagick\convert ..\res\tiles\tile109.bmp txt:- >> ..\res\tiles\tile109.txt
powershell ./Tiles2MapDefs.ps1 ..\res\tiles\tile109.txt "Helmet Pickup"
REM cscript //nologo Tiles2MapDefs.vbs ..\res\tiles\tile109.txt "Helmet Pickup"
ImageMagick\convert ..\res\tiles\tile110.bmp txt:- >> ..\res\tiles\tile110.txt
powershell ./Tiles2MapDefs.ps1 ..\res\tiles\tile110.txt "Boots Pickup"
REM cscript //nologo Tiles2MapDefs.vbs ..\res\tiles\tile110.txt "Boots Pickup"
ImageMagick\convert ..\res\tiles\tile111.bmp txt:- >> ..\res\tiles\tile111.txt
powershell ./Tiles2MapDefs.ps1 ..\res\tiles\tile111.txt "Food Pickup"
REM cscript //nologo Tiles2MapDefs.vbs ..\res\tiles\tile111.txt "Food Pickup"
ImageMagick\convert ..\res\tiles\tile112.bmp txt:- >> ..\res\tiles\tile112.txt
powershell ./Tiles2MapDefs.ps1 ..\res\tiles\tile112.txt "Red Gem Pickup"
REM cscript //nologo Tiles2MapDefs.vbs ..\res\tiles\tile112.txt "Red Gem Pickup"
ImageMagick\convert ..\res\tiles\tile113.bmp txt:- >> ..\res\tiles\tile113.txt
powershell ./Tiles2MapDefs.ps1 ..\res\tiles\tile113.txt "Green Gem Pickup"
REM cscript //nologo Tiles2MapDefs.vbs ..\res\tiles\tile113.txt "Green Gem Pickup"

REM Entities - 151 to 200
pause

