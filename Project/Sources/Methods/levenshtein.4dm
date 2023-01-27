//%attributes = {"invisible":true,"preemptive":"capable"}
#DECLARE($src : Text; $tgt : Text) : Integer

If (False:C215)
	C_TEXT:C284(levenshtein; $1)
	C_TEXT:C284(levenshtein; $2)
	C_LONGINT:C283(levenshtein; $0)
End if 

var $i; $j; $min; $srcLength; $tgtLength : Integer

$srcLength:=Length:C16($src)
$tgtLength:=Length:C16($tgt)

ARRAY LONGINT:C221($matrix; $srcLength; $tgtLength)

//%R-
For ($i; 1; $srcLength; 1)
	
	$matrix{$i}{0}:=$i
	
End for 

For ($i; 1; $tgtLength; 1)
	
	$matrix{0}{$i}:=$i
	
End for 

For ($i; 1; $srcLength; 1)
	
	For ($j; 1; $tgtLength; 1)
		
		$min:=$matrix{$i-1}{$j-1}
		$min:=$matrix{$i-1}{$j}<$min ? $matrix{$i-1}{$j} : $min
		$min:=$matrix{$i}{$j-1}<$min ? $matrix{$i}{$j-1} : $min
		
		$matrix{$i}{$j}:=$src[[$i]]=$tgt[[$j]] ? $min : $min+1
		
	End for 
End for 
//%R+

return $matrix{$srcLength}{$tgtLength}