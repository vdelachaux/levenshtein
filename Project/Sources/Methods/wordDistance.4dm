//%attributes = {"invisible":true,"preemptive":"capable"}
#DECLARE($src : Text; $tgt : Text; $deduplication : Boolean; $sorted : Boolean) : Integer

If (False:C215)
	C_TEXT:C284(wordDistance; $1)
	C_TEXT:C284(wordDistance; $2)
	C_BOOLEAN:C305(wordDistance; $3)
	C_BOOLEAN:C305(wordDistance; $4)
	C_LONGINT:C283(wordDistance; $0)
End if 

var $i; $j; $min; $srcCount; $tgtCount : Integer

ARRAY TEXT:C222($srcWords; 0)
ARRAY TEXT:C222($tgtWords; 0)

If ($deduplication)  // Unique words
	
	GET TEXT KEYWORDS:C1141($src; $srcWords; *)
	GET TEXT KEYWORDS:C1141($tgt; $tgtWords; *)
	
Else 
	
	GET TEXT KEYWORDS:C1141($src; $srcWords)
	GET TEXT KEYWORDS:C1141($tgt; $tgtWords)
	
End if 

If ($sorted)  // Sort the words
	
	SORT ARRAY:C229($srcWords; <)
	SORT ARRAY:C229($tgtWords; <)
	
End if 

$srcCount:=Size of array:C274($srcWords)
$tgtCount:=Size of array:C274($tgtWords)

ARRAY LONGINT:C221($matrix; $srcCount; $tgtCount)

//%R-
For ($i; 1; $srcCount; 1)
	
	$matrix{$i}{0}:=$i
	
End for 

For ($i; 1; $tgtCount; 1)
	
	$matrix{0}{$i}:=$i
	
End for 

For ($i; 1; $srcCount; 1)
	
	For ($j; 1; $tgtCount; 1)
		
		$min:=$matrix{$i-1}{$j-1}
		$min:=$matrix{$i-1}{$j}<$min ? $matrix{$i-1}{$j} : $min
		$min:=$matrix{$i}{$j-1}<$min ? $matrix{$i}{$j-1} : $min
		
		$matrix{$i}{$j}:=$srcWords{$i}=$tgtWords{$j} ? $min : $min+1
		
	End for 
End for 
//%R+

return $matrix{$srcCount}{$tgtCount}