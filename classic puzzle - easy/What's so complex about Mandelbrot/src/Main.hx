import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.ceil;
import Std.parseInt;
import Std.int;
import Std.string;

using Lambda;
using StringTools;

class Main {
	
	static final weights10 = [for( i in 0...10 ) 10 - i];
	static final weights13 = [for( i in 0...13 ) i % 2 == 0 ? 1 : 3];

	static function main() {
		
		final c = readline();
		final m = parseInt( readline() );
		
		final result = process( c, m );
		print( result );
	}

	static function process( c:String, m:Int ) {
	
		final ereg = ~/([-+]?[0-9]*\.?[0-9]+)/g;

		var matches = [];
  		while( ereg.match( c )) {
    		matches.push(ereg.matched( 0 ));
    		c = ereg.matchedRight();
		}
  
		final re = Std.parseFloat( matches[0] );
		final im = Std.parseFloat( matches[1] );

		for( i in 0...m ) {
			if( abs( f( i, re, im )) > 2 ) return i;
		}

		return m;
	}

	static function plus( c1:Complex, c2:Complex ) {
		return new Complex( c1.re + c2.re, c1.im + c2.im );
	}

	static function multiply ( c1:Complex ) {
		return new Complex( c1.re * c1.re - c1.im * c1.im, 2 * c1.re * c1.im );
	}

	static function abs ( c1:Complex ) {
		return Math.sqrt( c1.re * c1.re + c1.im * c1.im );
	}

	static function f( n:Int, re:Float, im:Float ) {
		return n <= 0 ? new Complex( 0, 0 ) : plus( multiply( f( n - 1, re, im )),  new Complex( re, im ));
	}

}

class Complex {
	public final re:Float;
	public final im:Float;
	public function new( re:Float, im:Float ) {
		this.re = re;
		this.im = im;
	}
}