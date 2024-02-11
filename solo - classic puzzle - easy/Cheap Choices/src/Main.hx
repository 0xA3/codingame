import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using StringTools;

typedef Item = {
	final name:String;
	final price:Int;
}

function main() {

	final c = parseInt( readline() );
	final p = parseInt( readline() );
	final itemLines = [for( _ in 0...c ) readline()];
	final orders = [for( _ in 0...p ) readline()];

	final result = process( itemLines, orders );
	print( result );
}

function process( itemLines:Array<String>, orders:Array<String> ) {
	var items = itemLines.map( parseItemLine );
	items.sort(( a, b ) -> a.price - b.price );
	
	final sellPrices = [];
	for( order in orders ) {
		var isSold = false;
		for( item in items ) {
			if( item.name == order ) {
				sellPrices.push( '${item.price}' );
				items.remove( item );
				isSold = true;
				break;
			}
		}
		if( !isSold ) sellPrices.push( "NONE" );
	}

	return sellPrices.join( "\n" );
}

function parseItemLine( itemLine:String ) {
	final lastSpace = itemLine.lastIndexOf(" ");
	final item:Item = {
		name: itemLine.substring( 0, lastSpace ),
		price: parseInt( itemLine.substring( lastSpace + 1 ))
	}

	return item;
}
