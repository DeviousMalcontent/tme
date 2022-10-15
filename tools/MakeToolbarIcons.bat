@ECHO off
ECHO Background Gradient
ImageMagick\magick -size 1x64 -define gradient:angle=74 gradient:"#D8DAEF-#0627E6" BMP3:..\res\bluegrad.bmp

ECHO Toolbar
ImageMagick\convert -size 768x48 xc:rgba(255,0,255,255) -channel Alpha ..\res\toolbar.png

ECHO Toolbar - Open
ImageMagick\convert -font Wingdings -fill black -pointsize 38 -draw "text 0,40 '1'" ..\res\toolbar.png ..\res\toolbar.png
ImageMagick\convert ..\res\toolbar.png -fuzz 1% -fill #FFE97F -draw "color 25,25 floodfill" ..\res\toolbar.png
ImageMagick\convert ..\res\toolbar.png -fuzz 1% -fill #E0E080 -draw "color 10,15 floodfill" ..\res\toolbar.png

ECHO Toolbar - Save
ImageMagick\convert -font Wingdings -fill black -pointsize 38 -draw "text 55,40 '<'"  ..\res\toolbar.png ..\res\toolbar.png
ImageMagick\convert ..\res\toolbar.png -fuzz 1% -fill #00A0C0 -draw "color 64,32 floodfill" ..\res\toolbar.png
ImageMagick\convert ..\res\toolbar.png -fuzz 1% -fill #FFFFFF -draw "color 75,20 floodfill" ..\res\toolbar.png
ImageMagick\convert ..\res\toolbar.png -fuzz 1% -fill #C0C0C0 -draw "color 68,35 floodfill" ..\res\toolbar.png
ECHO Toolbar - Undo
ImageMagick\convert -font Wingdings-3 -fill black -pointsize 38 -draw "text 103,40 'Q'" ..\res\toolbar.png ..\res\toolbar.png
ECHO Toolbar - Redo
ImageMagick\convert -font Wingdings-3 -fill black -pointsize 38 -draw "text 150,40 'P'" ..\res\toolbar.png ..\res\toolbar.png

ECHO Toolbar - Cut
ImageMagick\convert -size 48x48 xc:rgba(255,0,255,255) -channel Alpha -font Wingdings-2 -fill black -pointsize 38 -draw "text 0,38 '&'" -rotate 270 ..\res\toolbarCutIconTemp.png
ImageMagick\convert ..\res\toolbar.png ..\res\toolbarCutIconTemp.png -geometry +193-4 -composite ..\res\toolbar.png
DEL ..\res\toolbarCutIconTemp.png /Q

ImageMagick\convert ..\res\toolbar.png -fuzz 1% -fill #E02040 -draw "color 212,34 floodfill" ..\res\toolbar.png
ImageMagick\convert ..\res\toolbar.png -fuzz 1% -fill #E02040 -draw "color 222,34 floodfill" ..\res\toolbar.png
ImageMagick\convert ..\res\toolbar.png -fuzz 1% -fill #C0C0C0 -draw "color 211,19 floodfill" ..\res\toolbar.png
ImageMagick\convert ..\res\toolbar.png -fuzz 1% -fill #C0C0C0 -draw "color 225,15 floodfill" ..\res\toolbar.png

ECHO Toolbar - Paste
ImageMagick\convert -font Wingdings-2 -fill black -pointsize 42 -draw "text 250,40 '2'" ..\res\toolbar.png ..\res\toolbar.png
ImageMagick\convert ..\res\toolbar.png -fuzz 1% -fill #C08040 -draw "color 264,26 floodfill" ..\res\toolbar.png
ImageMagick\convert ..\res\toolbar.png -fuzz 1% -fill #808080 -draw "color 265,14 floodfill" ..\res\toolbar.png
ECHO Toolbar - Clipboard
ImageMagick\convert -font Wingdings-2 -fill black -pointsize 38 -draw "text 295,35 '1'" ..\res\toolbar.png ..\res\toolbar.png
ImageMagick\convert ..\res\toolbar.png -fuzz 1% -fill #808080 -draw "color 315,10 floodfill" ..\res\toolbar.png
ImageMagick\convert ..\res\toolbar.png -fuzz 1% -fill #C0C0C0 -draw "color 310,14 floodfill" ..\res\toolbar.png
ImageMagick\convert ..\res\toolbar.png -fuzz 1% -fill #FFFFFF -draw "color 305,30 floodfill" ..\res\toolbar.png

ECHO Toolbar - Find
ImageMagick\convert -size 48x48 xc:rgba(255,0,255,255) -channel Alpha -font Wingdings-2 -fill black -pointsize 38 -draw "text 0,38 '$'" -rotate 90 ..\res\toolbarFindIconTemp1.png
ImageMagick\convert ..\res\toolbarFindIconTemp1.png -page +2+7 -background rgba(255,0,255,255) -flatten ..\res\toolbarFindIconTemp1.png
ImageMagick\convert -size 48x48 xc:rgba(0,0,0,0) -channel Alpha -font Wingdings -fill black -pointsize 32 -draw "text 0,38 'm'" -rotate 90 ..\res\toolbarFindIconTemp2.png
ImageMagick\convert ..\res\toolbarFindIconTemp2.png -fuzz 90% -fill #00FFFF -draw "color 20,10 floodfill" ..\res\toolbarFindIconTemp2.png
ImageMagick\convert ..\res\toolbarFindIconTemp1.png ..\res\toolbarFindIconTemp2.png -geometry -6-2 -composite ..\res\toolbarFindIconTemp.png
ImageMagick\convert ..\res\toolbarFindIconTemp.png -fuzz 90% -fill #303030 -draw "color 30,30 floodfill" ..\res\toolbarFindIconTemp.png
ImageMagick\convert ..\res\toolbarFindIconTemp.png -fuzz 90% -fill #303030 -draw "color 35,40 floodfill" ..\res\toolbarFindIconTemp.png
DEL ..\res\toolbarFindIconTemp1.png /Q
DEL ..\res\toolbarFindIconTemp2.png /Q
rem -resize 100x100 ..\res\toolbarFindIconTemp.png
ImageMagick\convert ..\res\toolbar.png ..\res\toolbarFindIconTemp.png -geometry +338+2 -composite ..\res\toolbar.png
DEL ..\res\toolbarFindIconTemp.png /Q

ECHO Toolbar - Export
ImageMagick\convert -size 48x48 xc:rgba(255,0,255,255) -channel Alpha -font Wingdings-2 -fill black -pointsize 48 -draw "text 0,38 '/'" ..\res\toolbarExportIconTemp1.png
ImageMagick\convert ..\res\toolbarExportIconTemp1.png -fuzz 90% -fill #FFFFFF -draw "color 10,20 floodfill" ..\res\toolbarExportIconTemp1.png
ImageMagick\convert ..\res\toolbarExportIconTemp1.png -fuzz 90% -fill #FFFFFF -draw "color 23,10 floodfill" ..\res\toolbarExportIconTemp1.png
ImageMagick\convert -size 48x48 xc:rgba(0,0,0,0) -channel Alpha -font Wingdings-3 -fill black -pointsize 38 -draw "text 0,38 '_'" ..\res\toolbarExportIconTemp2.png
ImageMagick\convert ..\res\toolbarExportIconTemp2.png -fuzz 90% -fill #FF0000 -draw "color 15,25 floodfill" ..\res\toolbarExportIconTemp2.png
ImageMagick\convert ..\res\toolbarExportIconTemp2.png -page +13+0 -background none -flatten ..\res\toolbarExportIconTemp2.png
ImageMagick\convert ..\res\toolbarExportIconTemp1.png ..\res\toolbarExportIconTemp2.png -composite ..\res\toolbarExportIconTemp.png
DEL ..\res\toolbarExportIconTemp1.png /Q
DEL ..\res\toolbarExportIconTemp2.png /Q
ImageMagick\convert ..\res\toolbar.png ..\res\toolbarExportIconTemp.png -geometry +388+2 -composite ..\res\toolbar.png
DEL ..\res\toolbarExportIconTemp.png /Q

REM Export to 256 Bitmap.
iview460\i_view32 ..\res\toolbar.png /bpp=8 /convert=..\res\toolbar.bmp

ECHO App Icon
ImageMagick\convert -size 256x256 xc:#00E5E5 -fill white -stroke black -draw "rectangle 0,0 32,32" -draw "rectangle 0,32 32,64" -draw "rectangle 0,96 32,64" -draw "rectangle 0,128 32,96" -draw "rectangle 0,160 32,128" -draw "rectangle 0,192 32,160" -draw "rectangle 0,224 32,192" -draw "rectangle 0,256 32,224" ..\res\appicon.png
PAUSE
