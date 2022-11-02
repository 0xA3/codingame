import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

using StringTools;

/*
Given a string consisting only of the characters A, T, G and C, do the following:
- double the A-s
- triple the T-s
- remove the G-s
- leave the C-s as is

Input
ATGCAATTGGCC

Output
AATTTCAAAATTTTTTCC
*/

function main() {

	final dna = readline();
	
	print( dna.replace( "A", "AA" ).replace( "T", "TTT" ).replace( "G", "" ) );
}
