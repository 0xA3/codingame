import haxe.ds.GenericStack;

/**
 * Auto-generated code below aims at helping you parse
 * the standard input according to the problem statement.
 **/

class Main {
	
	static function main() {
		
		final expression = CodinGame.readline();
		CodinGame.printErr( expression );
		
		final result = evaluate( expression );
		CodinGame.print( result );
	}

	static function evaluate( expression:String ):Bool {
		
		final map = [ ")" => "(", "]" => "[", "}" => "{" ]; 
		final stack = new GenericStack<String>();
		for( i in 0...expression.length ) {
			final char = expression.charAt(i);
			if( char == "(" || char == "[" || char == "{" ) stack.add( char );
			if( char == ")" || char == "]" || char == "}" ) {
				if( stack.pop() != map.get( char )) return false;
			}
		}
		return stack.isEmpty() ? true : false;
	}

}
