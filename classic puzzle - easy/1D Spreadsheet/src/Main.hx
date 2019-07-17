using Lambda;

class Main {
	
	static function main() {
		
		final n = Std.parseInt( CodinGame.readline());

		CodinGame.printErr( 'n: $n' );

		final elementsLines = [for( i in 0...n ) CodinGame.readline().split(' ')];
		final resultLines = elementsLines.map( elementLine -> Formula( elementLine ));
		for( i in 0...resultLines.length ) {
			CodinGame.print( Std.string( eval( resultLines, i )));
		}
	}

	static function eval( resultLines:Array<TCell>, i:Int ):Int {
		
		return switch resultLines[i] {
			
			case Formula(a):
				// trace( 'Formula $a' );
				final arg1 = getArg( a[1], resultLines, i );
				final arg2 = getArg( a[2], resultLines, i );
				
				final v = switch a[0] {
					case "ADD": arg1 + arg2;
					case "SUB": arg1 - arg2;
					case "MULT": arg1 * arg2;
					case _: arg1;
				}
				resultLines[i] = Result( v );
				return v;
			case Result(v):
				// trace( 'Result $v' );
				return v;
		}	
	}

	static function getArg( s:String, resultLines:Array<TCell>, cellId:Int ) {
		return if( s.charAt( 0 ) == "$" ) {
			final cellId = Std.parseInt( s.substr( 1 ));
				eval( resultLines, cellId );
		} else {
			Std.parseInt( s );
		}
	}


}

enum TCell {
	Formula( a:Array<String> );
	Result( v:Int );
}