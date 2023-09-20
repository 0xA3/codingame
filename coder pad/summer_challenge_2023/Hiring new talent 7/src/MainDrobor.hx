import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import haxe.ds.GenericStack;

@:keep function mixWishes( inputWishA:String, inputWishB:String ) {

	final wishA = " " + inputWishA;
	final wishB = " " + inputWishB;

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

	final insertA = [for( _ in 0...wishB.length ) new GenericStack<Int>()];
	final pos = new Vec2I( wishB.length - 1, wishA.length - 1 );

	while( pos.x != 0 && pos.y != 0 ) {
		final replace = dist[pos.y - 1][pos.x - 1];
		final insert = dist[pos.y - 1][pos.x];
		final delete = dist[pos.y][pos.x - 1];

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
	final result = new StringBuf();

	result.add( wishA.substr( 1, pos.y ));
	// trace( '1 result add(1, ${pos.y}): "${wishA.substr( 1, pos.y )}"' );
	for( i in 1...wishB.length ) {
		result.add( wishB.charAt( i ));
		// trace( '2 result add(${wishB.charAt( i )})' );

		for( idx in insertA[i] ) {
			result.add( wishA.charAt( idx ));
			// trace( '3 result add(${wishA.charAt( idx )})' );
		}
	}

	return result.toString();
}

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
}