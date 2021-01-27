import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import Std.int;
import Std.string;

using Lambda;
using StringTools;

class Main {
	
	static function main() {
		
		final intext = readline();
		
		final result = process( intext );
		print( result );
	}

	static function process( intext:String ) {
		
		final t1 = intext.toLowerCase();
		final e2 = ~/\s+([\.,])/g;
		final t2 = e2.replace( t1, "$1" );
		final e3 = ~/\s+/g;
		final t3 = e3.replace( t2, " " );
		final e4 = ~/([\.,])(\w)/g;
		final t4 = e4.replace( t3, "$1 $2" );
		var t5 = t4.charAt( 0 ).toUpperCase() + t4.substr( 1 );
		final e6 = ~/[\.] [a-z]/g;
		while( e6.match( t5 )) {
			final pos = e6.matchedPos().pos;
			t5 = t5.substr( 0, pos + 2 ) + t5.charAt( pos + 2 ).toUpperCase() + t5.substr( pos + 3 );
		}
		final e7 = ~/(\.+)/g;
		final t7 = e7.replace( t5, "." );
		final e8 = ~/(,+)/g;
		final t8 = e8.replace( t7, "," );
		
		// trace( '\nt0 $intext\nt1 $t1\nt2 $t2\nt3 $t3\nt4 $t4\nt5 $t5\nt7 $t7\nt8 $t8' );

		return t8;
	}

}
