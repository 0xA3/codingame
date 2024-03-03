import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

final elements = ["H", "He", "Li", "Be", "B", "C", "N", "O", "F", "Ne", "Na", "Mg", "Al", "Si", "P", "S", "Cl", "Ar", "K", "Ca", "Sc", "Ti", "V", "Cr", "Mn", "Fe", "Co", "Ni", "Cu", "Zn", "Ga", "Ge", "As", "Se", "Br", "Kr", "Rb", "Sr", "Y", "Zr", "Nb", "Mo", "Tc", "Ru", "Rh", "Pd", "Ag", "Cd", "In", "Sn", "Sb", "Te", "I", "Xe", "Cs", "Ba", "La", "Ce", "Pr", "Nd", "Pm", "Sm", "Eu", "Gd", "Tb", "Dy", "Ho", "Er", "Tm", "Yb", "Lu", "Hf", "Ta", "W", "Re", "Os", "Ir", "Pt", "Au", "Hg", "Tl", "Pb", "Bi", "Po", "At", "Rn", "Fr", "Ra", "Ac", "Th", "Pa", "U", "Np", "Pu", "Am", "Cm", "Bk", "Cf", "Es", "Fm", "Md", "No", "Lr", "Rf", "Db", "Sg", "Bh", "Hs", "Mt", "Ds", "Rg", "Cn", "Nh", "Fl", "Mc", "Lv", "Ts", "Og"];

var lowElements:Array<String>;
var solutions:Array<String>;

function main() {

	final word = readline();

	final result = process( word );
	print( result );
}

function process( word:String ) {
	elements.sort(( a, b ) -> a < b ? -1 : 1 );
	lowElements = elements.map( e -> e.toLowerCase());
	
	solutions = [];
	find( word, [] );
	
	return solutions.length == 0 ? "none" : solutions.join( "\n" );
}

function find( wordPart:String, foundElements:Array<String> ) {
	if( wordPart == "" ) solutions.push( foundElements.join( "" ));
	final lowWordPart = wordPart.toLowerCase();
	for( i in 0...elements.length ) {
		// trace( '$wordPart  element: ${lowElements[i]} index: ${lowWordPart.indexOf( lowElements[i] )}' );
		if( lowWordPart.indexOf( lowElements[i] ) == 0 ) {
			final element = elements[i];
			find( wordPart.substr( element.length ), foundElements.concat( [element] ));
		}
	}
}
