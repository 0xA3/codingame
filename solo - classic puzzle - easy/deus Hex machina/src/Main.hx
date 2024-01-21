import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;
using NumberConvert;

final horizontal = [
	"0" => "0",
	"1" => "1",
	"2" => "5",
	"3" => "#",
	"4" => "#",
	"5" => "2",
	"6" => "a",
	"7" => "#",
	"8" => "8",
	"9" => "e",
	"a" => "6",
	"b" => "d",
	"c" => "#",
	"d" => "b",
	"e" => "9",
	"f" => "#",
];

final vertical = [
	"0" => "0",
	"1" => "1",
	"2" => "5",
	"3" => "3",
	"4" => "#",
	"5" => "2",
	"6" => "e",
	"7" => "#",
	"8" => "8",
	"9" => "a",
	"a" => "9",
	"b" => "#",
	"c" => "c",
	"d" => "#",
	"e" => "6",
	"f" => "#",
];

function main() {
	final number = readline();

	final result = process( number );
	print( result );
}

function process( number:String ) {
	final digits = number.split( "" );
	final flipSequence = digits.mapi(( i, s ) -> i == 0
		? s.fromHex().toBin( false )
		: s.fromHex().toBin( true )
	).join("").split("");
	
	// trace( "flipSequence   " + flipSequence.join( "" ));

	// trace( 'isEqual ' + ( flipSequenceBI.join( "" ) == flipSequence.join( "" ) ));

	var numberSequence = number.split( "" );

	final applyH = flipSequence.count( s -> s == "0" ) % 2;
	final applyV = flipSequence.count( s -> s == "1" ) % 2;

	// printErr( 'flipSequence.count 0 ' + flipSequence.count( s -> s == "0" ));
	// printErr( 'flipSequence.count 1 ' + flipSequence.count( s -> s == "1" ));
	// printErr( 'applyH $applyH   applyV $applyV' );

	if( applyH == 1 ) numberSequence = flipHorizontal( numberSequence );
	if( numberSequence.contains( "#" )) return "Not a number";
	if( applyV == 1 ) numberSequence = flipVertical( numberSequence );
	if( numberSequence.contains( "#" )) return "Not a number";


	return numberSequence.slice( 0, 1000 ).join( "" );
}

function flipHorizontal( sequence:Array<String> ) {
	final transformed = sequence.map( s -> {
		if( !horizontal.exists( s )) throw 'Error: horizontal[$s] does not exist';
		return horizontal[s];
	});
	transformed.reverse();

	// trace( "flipHorizontal " + sequence.join( "" ) + " - " + transformed.join( "" ));

	return transformed;
}

function flipVertical( sequence:Array<String> ) {
	final transformed = sequence.map( s -> {
		if( !vertical.exists( s )) throw 'Error: vertical[$s] does not exist';
		return vertical[s];
	});

	// trace( "flipVertical " + sequence.join( "" ) + " - " + transformed.join( "" ));

	return transformed;
}
