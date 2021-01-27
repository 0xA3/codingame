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
		final t2 = t1.charAt( 0 ).toUpperCase() + t1.substr( 1 );
		final t3 = ~/\s+([\.,])/g.replace( t2, "$1" );
		final t4 = ~/\s+/g.replace( t3, " " );
		var   t5 = ~/([\.,])(\w)/g.replace( t4, "$1 $2" );
		final e6 = ~/[\.] [a-z]/g;
		while( e6.match( t5 )) {
			final pos = e6.matchedPos().pos;
			t5 = t5.substr( 0, pos + 2 ) + t5.charAt( pos + 2 ).toUpperCase() + t5.substr( pos + 3 );
		}
		final t7 = ~/(\.+)/g.replace( t5, "." );
		final t8 = ~/(,+)/g.replace( t7, "," );
		
		// trace( '\nt0 $intext\nt1 $t1\nt2 $t2\nt3 $t3\nt4 $t4\nt5 $t5\nt7 $t7\nt8 $t8' );

		return t8;
	}

}
