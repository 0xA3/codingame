import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import haxe.ds.GenericStack;

@:keep function mixWishes( inputWishA:String, inputWishB:String ) {

	final wishA = " " + inputWishA;
	final wishB = " " + inputWishB;
	
	//
	// Distance calculation
	//
	final dist = [for( _ in 0...wishA.length ) [for( _ in 0...wishB.length ) 0]];

	for( y in 1...wishA.length ) dist[y][0] = y;
	
	for( y in 1...wishA.length ) {
		for( x in 1...wishB.length ) {
			final replaceCost = wishA.charAt( y ) == wishB.charAt( x ) ? 0 : 1;
			dist[y][x] = min(
				dist[y - 1][x] + 1, //Y ~ insert
				dist[y][x - 1], //X ~ deletion
				dist[y - 1][x - 1] + replaceCost );
		}
	}
	
	// trace( dist );

	//
	// inserts calculation
	//
	final insertA = [for( _ in 0...wishB.length ) new GenericStack<Int>()];
	final pos = new Vec2I( wishB.length - 1, wishA.length - 1 );

	while( pos.x != 0 && pos.y != 0 ) {
		final replace = dist[pos.y - 1][pos.x - 1];
		final insert = dist[pos.y - 1][pos.x];
		final delete = dist[pos.y][pos.x - 1];

		trace( '$pos\nreplace: dist[${pos.y - 1}][${pos.x - 1}] $replace\ninsert:  dist[${pos.y - 1}][${pos.x}] $insert\ndelete:  dist[${pos.y}][${pos.x - 1}] $delete' );
		if( replace < delete && replace <= insert ) {
			if( dist[pos.y - 1][pos.x] != dist[pos.y][pos.x] ) {
				insertA[pos.x].add( pos.y );
			}
			pos.y--;
			pos.x--;
		
		} else if( insert < delete && insert < replace ) {
			if( dist[pos.y - 1][pos.x] != dist[pos.y][pos.x] ) {
				insertA[pos.x].add( pos.y );
			}
			pos.y--;
		
		} else {
			pos.x--;
		}
	}
	trace( printStacks( insertA ));
	
	//
	// inserting
	//
	final result = new StringBuf();
	result.add( wishA.substr( 1, pos.y ));
	// trace( 'result add(1, ${pos.y}): "${wishA.substr( 1, pos.y )}"' );
	for( i in 1...wishB.length ) {
		result.add( wishB.charAt( i ));
		// trace( 'result i add($i) of wishB: "${wishB.charAt( i )}"' );

		for( idx in insertA[i] ) {
			result.add( wishA.charAt( idx ));
			// trace( 'result idx add($idx) of wishA: "${wishA.charAt( idx )}"' );
		}
	}

	return result.toString();
}

/**
 * Function to convert an array of GenericStack<Int> into a string representation.
 * Each stack is enclosed in square brackets and separated by commas.
 *
 * @param a The array of GenericStack<Int> to be converted.
 * @return The string representation of the input array of stacks.
 */
function printStacks( a:Array<GenericStack<Int>> ) {
	final output = a.map( s -> '[' +  [for( element in s ) element].join(",") + ']').join( "," );
	return output;
}

/**
 * Returns the minimum value among three integers.
 *
 * @param a The first integer value.
 * @param b The second integer value.
 * @param c The third integer value.
 * @return The minimum value among the three input integers.
 */
function min( a:Int, b:Int, c:Int ) {
    return MathUtils.min( a, MathUtils.min( b, c ));
}

class Vec2I {
	public var x:Int;
	public var y:Int;

	public function new( x:Int, y:Int ) {
		this.x = x;
		this.y = y;
	}

	public function toString() return 'x: $x, y: $y';
}