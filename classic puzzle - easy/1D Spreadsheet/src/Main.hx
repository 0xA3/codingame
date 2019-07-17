using Lambda;

class Main {
	
	static function main() {
		
		final n = Std.parseInt( CodinGame.readline());

		CodinGame.printErr( 'n: $n' );

		final elementsLines = [for( i in 0...n ) CodinGame.readline().split(' ')];
		final results = process( elementsLines );
		for( result in results ) CodinGame.print( Std.string( result ));
	}

	static function process( elementsLines:Array<Array<String>> ) {
		
		final asts = [for( i in 0...elementsLines.length ) createAST( elementsLines, i )];
		final results = asts.map( ast -> eval( ast ));
		return results;
	}

	static function createAST( calculations:Array<Array<String>>, index:Int ):TOperation {
		
		final calculation = calculations[index];
		
		final v1 = calculation[1].charAt( 0 ) == "$" ? createAST( calculations, Std.parseInt( calculation[1].substr( 1 ))) : Value( Std.parseInt( calculation[1] ));
		final v2 = calculation[2].charAt( 0 ) == "$" ? createAST( calculations, Std.parseInt( calculation[2].substr( 1 ))) : Value( Std.parseInt( calculation[2] ));
		
		switch calculation[0] {
			case "VALUE": return v1;
			case "ADD": return Add( v1, v2 );
			case "SUB": return Sub( v1, v2 );
			case "MULT": return Mult( v1, v2 );
			case _: return null;
		}
	}

	static function eval( tree:TOperation ):Int {
		return switch tree {
			case Value( v ): return v;
			case Add( v1, v2 ): return eval( v1 ) + eval( v2 );
			case Sub( v1, v2 ): return eval( v1 ) - eval( v2 );
			case Mult( v1, v2 ): return eval( v1 ) * eval( v2 );
		}	
	}

}

enum TOperation {
	Value( v:Int );
	Add( v1:TOperation, v2:TOperation );
	Sub( v1:TOperation, v2:TOperation );
	Mult( v1:TOperation, v2:TOperation );
}