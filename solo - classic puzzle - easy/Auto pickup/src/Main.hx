import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.abs;
import Math.min;
import Std.parseInt;
import Std.int;

using Lambda;
using StringTools;

class Main {
	
	static function main() {
		
		final n = parseInt( readline() );
		final packet = readline();
		

		final result = process( n, packet );
		print( result );
	}

	static function process( n:Int, packet:String ) {
		
		final pickupInstructions = [];
		var packetInfo = packet;
		var i = 0;
		while( i < n ) {
			final id = packet.substr( i, 3 );
			final l = packet.substr( i + 3, 4 );
			packetInfo = packet.substr( i + 7 );
			
			final packetLength = binToInt( l );
			
			final itemId = packetInfo.substr( 0, packetLength );

			// trace( '$id $l $packetInfo' );

			// trace( 'instructionId $i  packetLength $packetLength itemId $itemId  packetInfo ${packetInfo}' );

			if( id == "101" ) pickupInstructions.push( '001${l}${itemId}' );

			i += 7 + packetLength;
		}
		
		return pickupInstructions.join("");
	}

	static function binToInt( s:String ) {
		var v = 0;
		for( i in 0...s.length ) {
			v = ( v << 1 ) + parseInt( s.charAt( i ));
		}
		return v;
	}
}
