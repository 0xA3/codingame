import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

class Main {
	
	static function main() {
		
		final n = parseInt( readline());
		
		final result = process( n );
		print( result );
	}

	//      1/n = 1/x + 1/y
	//      1/n = 1/(a+n) + 1/(b+n)         | let x := a+n and y := b+n
	//      1/n = (b+n+a+n)/(a+n)(b+n)
	//      (a+n)(b+n) = n(b+n+a+n)
	//      ab+an+bn+n² =  bn+n²+an+n²
	//      ab = n²

	//      if a is divisor of n² then 1/n = 1/(a+n) + 1/(b+n) with b = n²/a

	static function process( n:Int ) {

		final results:Array<String> = [];
		for( i in 1...n + 1 ) {
			if(( n * n ) % i == 0) results.push ( '1/$n = 1/${ n * n / i + n } + 1/${ i + n}' );
		}
		return results.join( "\n" );
		
	}

}
