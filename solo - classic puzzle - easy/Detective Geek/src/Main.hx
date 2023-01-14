import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using StringTools;
using xa3.NumberConvert;

final months = ["jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec"];

function main() {

	final time = readline();
	final address = readline();
			
	final result = process( time, address );
	print( result );
}

function process( time:String, address:String ) {
	
	final binaryTime = time.replace( "#", "1" ).replace( "*", "0" );
	final decTime = binToInt( binaryTime );
	
	final minutes = decTime % 100;
	final hours = Std.int(( decTime - minutes ) / 100 );
	final stringHours = hours < 10 ? '0$hours' : '$hours';
	final stringMinutes = minutes < 10 ? '0$minutes' : '$minutes';
	final outputTime = '$stringHours:$stringMinutes';

	final addressMonths = address.split(" ").map( s -> [s.substr( 0, 3 ), s.substr( 3, 3 )]);
	final addressBase12s = addressMonths.map( a -> months.indexOf( a[0] ).toBase12() + months.indexOf( a[1] ).toBase12() );
	final addressDecs = addressBase12s.map( s -> base12ToDec( s ));
	final aOutputAddress = addressDecs.map( v -> String.fromCharCode( v ));
	final outputAddress = aOutputAddress.join( "" );

	// trace( address );
	// trace( addressMonths );
	// trace( addressBase12s );
	// trace( addressDecs );
	// trace( aOutputAddress );
	// trace( outputAddress );

	return outputTime + "\n" + outputAddress;
}

function binToInt( s:String ) {
	var v = 0;
	for( i in 0...s.length ) {
		v = ( v << 1 ) + parseInt( s.charAt( i ));
	}
	return v;
}

final base12ToDecMap = [
	"0" => 0,
	"1" => 1,
	"2" => 2,
	"3" => 3,
	"4" => 4,
	"5" => 5,
	"6" => 6,
	"7" => 7,
	"8" => 8,
	"9" => 9,
	"a" => 10,
	"b" => 11,
];

function base12ToDec( base12:String ) {
	var dec = 0;
	for( i in 0...base12.length ) {
		dec *= 12;
		final char = base12.charAt( i ).toLowerCase();
		if( !base12ToDecMap.exists( char )) throw 'Error: illegal char in hex value $base12';
		dec += base12ToDecMap[char];
	}
	return dec;
}

