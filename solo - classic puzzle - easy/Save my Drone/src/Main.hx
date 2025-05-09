import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

typedef Entry = { type:String, amount:Int }

var input:haxe.io.Input;
final entries:Array<Entry> = [];
function main() {

	final x = parseInt( readline() );
	final y = parseInt( readline() );
	final r = parseInt( readline() );
	final rows = [for( i in 0...y ) readline()];

	final result = process( r, rows );
	print( result );
}

function process( r:Int, rows:Array<String> ):String {
	entries.splice( 0, entries.length );

	final program = r == 0 ? rows.join( "" ) : reverseGrid( rows ).join( "" );
	input = new haxe.io.StringInput( program );

	while( true ) {
		final char = readChar();

		switch char {
			case 0: return outputEntries( entries );
			case "#".code: add( "Block" );
			case "^".code: add( "Thruster" );
			case "@".code: add( "Gyroscope" );
			case "+".code: add( "Fuel" );
			case "§".code: add( "Core" );
			default: // no-op
		}
	}
	
	return "Nothing";
}

function add( type:String ) {
	if( entries.length == 0 ) {
		entries.push( { type: type, amount: 1 } );
		return;
	}

	final lastEntry = entries[ entries.length - 1 ];
	if( lastEntry.type == type ) lastEntry.amount++;
	else entries.push( { type: type, amount: 1 } );
}

function outputEntries( entries:Array<Entry> ) {
	if( entries.length == 0 ) return "Nothing";
	return entries.map( e -> {
		final type = e.amount == 1 ? e.type : e.type + "s";
		return '${e.amount} $type';
	}).join( ", " );
}

function reverseGrid( rows:Array<String> ) {
	final reversed = [];
	for( y in -rows.length + 1...1 ) {
		final row = rows[-y];
		final reversedRow = [for( i in -row.length + 1...1 ) row.charAt( -i )];
		reversed.push( reversedRow.join( "" ) );
	}
	return reversed;
}

function readChar() return try input.readByte() catch( e : Dynamic ) 0;