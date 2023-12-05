import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using NumberFormat;
using StringTools;

final items:Map<String, Int> = [];

function main() {
	final numOfLinesOfOfferingStatement = parseInt( readline() );
	final offers = [for( _ in 0...numOfLinesOfOfferingStatement ) readline()];
	
	final gardenHeight = parseInt( readline() );
	final garden = [for( _ in 0...gardenHeight ) readline()].join( "" );
	
	final result = process( offers, garden );
	print( result );
}

function process( offerLines:Array<String>, garden:String ) {
	offerLines.iter( s -> setItems( s ));
	// printErr( items + "\n" + garden );
	final worth = garden.split( "" ).fold(( char, sum ) -> {
		// printErr( 'char $char exists ${items.exists( char )}' );
		items.exists( char ) ? sum + items[char] : sum;
	}, 0);

	return "$" + worth.number();
}

function setItems( s:String ) {
	final parts = s.split( "=" ).map( s -> s.trim());
	final value = parseInt( parts[0].substr( 1 ));
	final emojies = parts[1].split( "" );

	for( emoji in emojies ) items.set( emoji, value );
}
