//%attributes = {"shared":true}
var $src; $t; $tgt : Text
var $distance; $ms : Integer

$src:="“vincent de lachaux 218 ter av du bout du monde 33610 ECHOUBOULAIN"
$tgt:="de lachaux vincent 218, avenue du bt du monde echouboulain 33610"

$ms:=Milliseconds:C459
$distance:=levenshtein($src; $tgt)  // = 36
$t:="levenshtein: "+String:C10($distance)+" ("+String:C10(Milliseconds:C459-$ms)+"ms)"

$ms:=Milliseconds:C459
$distance:=wordDistance($src; $tgt; True:C214)  // = 7
$t+="\n\nwordDistance: "+String:C10($distance)+" ("+String:C10(Milliseconds:C459-$ms)+"ms)"

$ms:=Milliseconds:C459
$distance:=wordDistance($src; $tgt; True:C214; True:C214)  // = 3
$t+="\n\nsortedWordDistance: "+String:C10($distance)+" ("+String:C10(Milliseconds:C459-$ms)+"ms)"

ALERT:C41($t)