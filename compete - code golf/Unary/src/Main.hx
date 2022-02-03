using xa3.StringUtils;
using Lambda;

class Main {
	
	static function main() {
		
		CodinGame.print( process( CodinGame.readline()));
	}

	static function process( input:String ) {
		final s1 = input.split( "" ).map( c -> "000000" + c.charCodeAt( 0 ).toString( 2 ));
		final s2 = s1.map( s -> s.substr( -7 )).join( "" );
		final ereg = ~/(1+|0+)/g;
		final s3 = [];
		var m = s2;
		while( ereg.match( m )) {
			s3.push( ereg.matched( 1 ));
			m = ereg.matchedRight();
		};
		final s4 = s3.map( s -> ( s.charAt( 0 ) == "1" ? "0 " : "00 " )  + "0".repeat( s.length )).join( " " );
		
		return s4;
	}
}

