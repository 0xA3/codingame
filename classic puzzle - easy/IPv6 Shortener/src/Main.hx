import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

using RegexTools;

function main() {
	
	final ip = readline();

	final result = process( ip );
	print( result );
}	

function process( ip:String ) {

	final ipParts = ip.split( ":" );
	final ipParts2 = ipParts.map( s -> s.replace( ~/^0+([1-9a-f]+)/, "$1" ));

	final zeroBlocks:Array<ZeroBlockStreak> = [];
	var i = 0;
	while( i < ipParts2.length ) {
		final part = ipParts2[i];
		if( part == "0000" ) {
			final start = i;
			i++;
			var length = 1;
			while( ipParts2[i] == "0000" ) {
				length++;
				i++;
			}
			zeroBlocks.push({ start: start, length: length });
		} else {
			i++;
		}
	}

	zeroBlocks.sort(( a, b ) -> b.length - a.length );
	
	final ipParts3 = ipParts2.copy();
	if( zeroBlocks.length > 0 && zeroBlocks[0].length > 1 ) {
		final longestStreak = zeroBlocks[0];
		ipParts3[longestStreak.start] = "::";
		ipParts3.splice( longestStreak.start + 1, longestStreak.length - 1 );
	}

	final ipParts4 = ipParts3.map( s -> s.replace( ~/0000/, "0" ));
	final joined = ipParts4.join( ":" );

	final result = joined.replace( ~/::+/, "::" );

	// trace( 'ip $ip' );
	// trace( 'ipParts $ipParts' );
	// trace( 'ipParts2 $ipParts2' );
	// trace( 'zeroBlocks $zeroBlocks' );
	// trace( 'ipParts3 $ipParts3' );
	// trace( 'ipParts4 $ipParts4' );
	// trace( result );
	
	return result;
}

typedef ZeroBlockStreak = {
	final start:Int;
	final length:Int;
}