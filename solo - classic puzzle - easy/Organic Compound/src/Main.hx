import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Main;
using StringTools;
using xa3.RegexUtils;

final prefixes = ["","meth","eth","prop","but","pent","hex","hept","oct","non","dec"];

function main() {
	
	final formula = readline();

	final result = process( formula );
	print( result );
}

function process( formula:String ) {
	final carbons = formula.countAtom( "C" );
	final prefix = carbons > 0 && carbons <= 10 ? prefixes[carbons] : "";

	final hydrogens = formula.countAtom( "H" );
	final oxygens = formula.countAtom( "O" );

	if( oxygens == 0 && hydrogens == 2 * carbons + 2 ) return prefix + "ane";
	if( oxygens == 0 && hydrogens == 2 * carbons ) return prefix + "ene";

	if( hydrogens == 2 * carbons + 2 && formula.match( ~/.*OH$/ ) && oxygens == 1 ) return prefix + "anol";
	if( hydrogens == 2 * carbons && formula.match( ~/.*COOH$/ ) && oxygens == 2 ) return prefix + "anoic acid";
	if( hydrogens == 2 * carbons && formula.match( ~/.*CHO$/ ) && oxygens == 1 ) return prefix + "anal";
	if( hydrogens == 2 * carbons && formula.getMatches( ~/.*(CO).*/ ).length == 1 && oxygens == 1  ) return prefix + "anone";

	return "OTHERS";
}

function countAtom( formula:String, atom:String ) {
	var n = 0;
	for( i in 0...formula.length ) {
		if( formula.charAt( i ) == atom ) {
			var count = 1;
			var numString = "";
			while( true ) {
				var charAfter = formula.charAt( i + count );
				if( !charAfter.isDigit() ) break;
				numString += charAfter;
				count++;
			}
			n += numString == "" ? 1 : parseInt( numString );
		}
	}

	return n;
}

function countCombination( formula:String, group:String ) {
	var n = 0;
	var pos = 0;
	while( true ) {
		var nextPos = formula.indexOf( group, pos );
		if( nextPos == -1 ) break;
		
		n += 1;
		pos = nextPos + 1;
	}

	return n;
}

function endsWith( formula:String, group:String ) return formula.substring( formula.length - group.length ) == group;


function isDigit( c:String ) return c >= '0' && c <= '9';