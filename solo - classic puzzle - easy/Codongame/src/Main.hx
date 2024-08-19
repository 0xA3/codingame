import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using StringTools;

final codonTable = [
	"UUU" => "F",
	"CUU" => "L",
	"AUU" => "I",
	"GUU" => "V",
	"UUC" => "F",
	"CUC" => "L",
	"AUC" => "I",
	"GUC" => "V",
	"UUA" => "L",
	"CUA" => "L",
	"AUA" => "I",
	"GUA" => "V",
	"UUG" => "L",
	"CUG" => "L",
	"AUG" => "M",
	"GUG" => "V",
	"UCU" => "S",
	"CCU" => "P",
	"ACU" => "T",
	"GCU" => "A",
	"UCC" => "S",
	"CCC" => "P",
	"ACC" => "T",
	"GCC" => "A",
	"UCA" => "S",
	"CCA" => "P",
	"ACA" => "T",
	"GCA" => "A",
	"UCG" => "S",
	"CCG" => "P",
	"ACG" => "T",
	"GCG" => "A",
	"UAU" => "Y",
	"CAU" => "H",
	"AAU" => "N",
	"GAU" => "D",
	"UAC" => "Y",
	"CAC" => "H",
	"AAC" => "N",
	"GAC" => "D",
	"UAA" => "Stop",
	"CAA" => "Q",
	"AAA" => "K",
	"GAA" => "E",
	"UAG" => "Stop",
	"CAG" => "Q",
	"AAG" => "K",
	"GAG" => "E",
	"UGU" => "C",
	"CGU" => "R",
	"AGU" => "S",
	"GGU" => "G",
	"UGC" => "C",
	"CGC" => "R",
	"AGC" => "S",
	"GGC" => "G",
	"UGA" => "Stop",
	"CGA" => "R",
	"AGA" => "R",
	"GGA" => "G",
	"UGG" => "W",
	"CGG" => "R",
	"AGG" => "R",
	"GGG" => "G"
];

var i = 0;

function main() {

	final n = parseInt( readline() );
	final rnaLines = [for( i in 0...n ) readline().split( "" )];

	final result = process( rnaLines );
	print( result );
}

function process( rnaLines:Array<Array<String>> ) {
	final outputLines = [];
	for( rnaLine in rnaLines ) {
		final aminoAcidSets:Array<String> = [];
		for( offset in 0...3 ) aminoAcidSets.push( getAminoAcidsWithOffset( rnaLine, offset ));
		aminoAcidSets.sort(( a, b ) -> b.replace("-", "").length - a.replace("-", "").length );
		// trace( 'aminoAcidSets:\n' + aminoAcidSets.join( "\n" ));
		outputLines.push( aminoAcidSets[0] );
	}
	return outputLines.join( "\n" );
}

function getAminoAcidsWithOffset( rnaLine:Array<String>, offset:Int ) {
	// trace( '$offset ${rnaLine.slice( offset ).join( "" )}' );
	final outputLine = [];
	i = offset + 2;
	while( i < rnaLine.length ) {
		final triplet = rnaLine[i-2] + rnaLine[i-1] + rnaLine[i];
		// trace( '${i - 2} triplet: $triplet' );
		if( triplet == "AUG" ) {
			// trace( 'startCodon' );
			final aminoAcid = processOpened( rnaLine );
			if( aminoAcid != "" ) outputLine.push( aminoAcid );
		}
		i += 3;
	}
	return outputLine.join( "-" );
}

function processOpened( rnaLine:Array<String> ) {
	final sequences = [];
	while( i < rnaLine.length ) {
		final triplet = rnaLine[i-2] + rnaLine[i-1] + rnaLine[i];
		
		if( !codonTable.exists( triplet )) throw 'Invalid triplet: $triplet';
		
		// trace( '${i - 2} triplet: $triplet  aminoAcid: ${codonTable[triplet]}' );
		
		if( codonTable[triplet] == "Stop" ) return sequences.join( "" );
		sequences.push( codonTable[triplet] );

		i += 3;
	}
	
	return "";
}
