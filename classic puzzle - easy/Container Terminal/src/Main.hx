import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import haxe.ds.GenericStack;

using Lambda;

class Main {
	
	static function main() {
		
		final n = parseInt( readline() );
		final lines = [for( i in 0...n ) readline()];
		
		final result = process( lines );
		print( result );
	}

	static function process( lines:Array<String> ) {
		
		final resultLines = lines.map( line -> processLine( line ));
		return resultLines.join( "\n" );
	}

	static function processLine( line:String ) {
		final stacks:Array<GenericStack<String>> = [new GenericStack()];
		stacks[0].add( line.charAt( 0 ));
		
		// trace( 'add ${line.charAt( 0 )} to first stack' );

		for( i in 1...line.length ) {
			final char = line.charAt( i );
			var success = false;
			for( stack in stacks ) {
				final top = stack.first();
				// trace( 'compare top $top with $char' );
				if( char <= top ) {
					// trace( 'stack it' );
					stack.add( char );
					success = true;
					break;
				}
			}
			if( !success ) {
				final nextStack = new GenericStack();
				// trace( 'create new stack for $char' );
				nextStack.add( char );
				stacks.push( nextStack );
			}
		}
		return stacks.length;
	}
}
