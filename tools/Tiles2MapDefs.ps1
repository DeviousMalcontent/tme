$File=$args[0]
$titleName = ''
$title = ''

for ($i=1; $i -lt $args.Length; $i++){
   if (!$args[$i+1] -eq $null -or $args[$i] -ne $args[1]){
   	$titleName = $titleName + " " + $args[$i]
   }
   else{
   	$titleName = $titleName + $args[$i]
   }
}

foreach($line in Get-Content $File) {
$line = ($line -split "#")[1].substring(0,6)
	switch ($line) {
		'000000' {$title = $title + "0"; break}
		'FF0000' {$title = $title + "1"; break}
		'7F0000' {$title = $title + "2"; break}
		'FF6A00' {$title = $title + "3"; break}
		'7F3300' {$title = $title + "4"; break}
		'0094FF' {$title = $title + "5"; break}
		'0026FF' {$title = $title + "6"; break}
		'4CFF00' {$title = $title + "7"; break}
		'007F0E' {$title = $title + "8"; break}
		'808080' {$title = $title + "9"; break}
		'404040' {$title = $title + "A"; break}
		'FFD800' {$title = $title + "B"; break}
		'7F6A00' {$title = $title + "C"; break}
		'FF00DC' {$title = $title + "D"; break}
		'B200FF' {$title = $title + "E"; break}
		'FFFFFF' {$title = $title + "F"; break}
		default {break}
	}
}
$outstring = $title + "," + [char]34 + $titleName + [char]34
Add-Content ..\src\TilesDef.txt $outstring
