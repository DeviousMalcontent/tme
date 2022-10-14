@ECHO off 
ECHO Background Gradient
ImageMagick\magick -size 1x64 -define gradient:angle=74 gradient:"#D8DAEF-#0627E6" BMP3:..\res\bluegrad.bmp

ECHO Toolbar
rem ImageMagick\convert -size 768x48 xc:#FF00FF -channel Alpha ..\res\toolbar.png
ImageMagick\convert -size 768x48 xc:rgba(255,0,255,255) -channel Alpha ..\res\toolbar.png
rem ImageMagick\convert -font Wingdings -fill black -stroke white -strokewidth 1  -pointsize 38 -draw "text 0,40 '1<'" -define bmp3:write-alpha=true ..\res\toolbar.png ..\res\toolbar.png
ECHO Toolbar - Open
ImageMagick\convert -font Wingding -fill black -strokewidth 2 -pointsize 38 -draw "text 0,40 '1'" ..\res\toolbar.png ..\res\toolbar.png
ImageMagick\convert ..\res\toolbar.png -fuzz 75% -fill #FFE97F -draw "color 25,25 floodfill" ..\res\toolbar.png
ImageMagick\convert ..\res\toolbar.png -fuzz 75% -fill #FFE251 -draw "color 10,15 floodfill" ..\res\toolbar.png

ECHO Toolbar - Save
ImageMagick\convert -font Wingding -fill black -pointsize 38 -draw "text 55,40 '<'"  ..\res\toolbar.png ..\res\toolbar.png
ECHO Toolbar - Undo
ImageMagick\convert -font Wingdings-3 -fill black -pointsize 38 -draw "text 103,40 'Q'" ..\res\toolbar.png ..\res\toolbar.png
ECHO Toolbar - Redo
ImageMagick\convert -font Wingdings-3 -fill black -pointsize 38 -draw "text 150,40 'P'" ..\res\toolbar.png ..\res\toolbar.png

ECHO Toolbar - Cut
ImageMagick\convert -size 48x48 xc:rgba(255,0,255,255) -channel Alpha -font Wingdings-2 -fill black -pointsize 38 -draw "text 0,38 '&'" -rotate 270 ..\res\toolbarCutIconTemp.png
ImageMagick\convert ..\res\toolbar.png ..\res\toolbarCutIconTemp.png -geometry +193-4 -composite ..\res\toolbar.png
DEL ..\res\toolbarCutIconTemp.png /Q

ECHO Toolbar - Paste
ImageMagick\convert -font Wingdings-2 -fill black -pointsize 42 -draw "text 250,40 '2'" ..\res\toolbar.png ..\res\toolbar.png
ECHO Toolbar - Clipboard
ImageMagick\convert -font Wingdings-2 -fill black -pointsize 38 -draw "text 295,35 '1'" ..\res\toolbar.png ..\res\toolbar.png


ECHO App Icon
ImageMagick\convert -size 256x256 xc:#00E5E5 -fill white -stroke black -draw "rectangle 0,0 32,32" -draw "rectangle 0,32 32,64" -draw "rectangle 0,96 32,64" -draw "rectangle 0,128 32,96" -draw "rectangle 0,160 32,128" -draw "rectangle 0,192 32,160" -draw "rectangle 0,224 32,192" -draw "rectangle 0,256 32,224" ..\res\appicon.png