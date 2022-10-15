[string]$File=$args[0]
[string]$colourToReplace = $args[1]
[string]$colourToReplaceWith = $args[2]
$outputFile = ''
$size = ''
$outstring = ''

#for ($i=1; $i -lt $args.Length; $i++){
#   if (!$args[$i+1] -eq $null -or $args[$i] -ne $args[1]){
#   	$colourToReplace = $colourToReplace + " " + $args[$i]
#   }
#   else{
#   	$colourToReplace = $colourToReplace + $args[$i+1]
#	$colourToReplaceWith = $colourToReplaceWith + $args[$i+2]
#   }
#}
echo "colourToReplace: $colourToReplace"
echo "colourToReplaceWith: $colourToReplaceWith"


#$testarray = Get-Content '..\res\tiles\tile001.txt' | Where { $_ -notmatch "Image" }
foreach($line in Get-Content $File | Where { $_ -notmatch "Image" }) {
$cords = ($line -split ":")[0].substring(0,3)
$colour = ($line -split "#")[1].substring(0,6)

if ($colour -eq $colourToReplace) {
	$thisColour = $colourToReplaceWith
} Else {
	$thisColour = $colour
}

$outstring = $outstring + 'ImageMagick\convert test.png -fill "#' + $thisColour + '" -draw "color ' + $cords + ' point" test.png' + "`n" 
#$outstring = $outstring + 'ImageMagick\convert test.png -fill "#' + $colour + '" -draw "color ' + $cords + ' point" test.png' + "`n" 
}

$st1 = $line[$line.Count-1]
[int]$st1i = [convert]::ToInt32($st1, 10)
$st1 = $st1i+1

$st2 = $line[$line.Count+1]
[int]$st2i = [convert]::ToInt32($st2, 10)
$st2 = $st2i+1

$size = [string]$st1 + "x" + [string]$st2
Write-Output "ImageMagick\convert -size $size xc:white test.png`n$outstring"
#Add-Content ..\src\TilesDef.txt $outstring

#powershell ./ImageMagickTXT2Image.ps1 ..\res\tiles\tile000.txt "FF0000" "4CFF00"