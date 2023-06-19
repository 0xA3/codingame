package xa3;

import haxe.ds.Vector;
import haxe.ds.Option;
import Std.int;
import xa3.MathUtils;
import xa3.StringUtils.repeat;

class ArrayUtils {

	extern public static inline function addAll<T>( a:Array<T>, b:Array<T> ) {
		for( x in b ) a.push( x );
	}
	
	extern public static inline function alignRight( a:Array<String> ) {
		final m = maxLength( a );
		return a.map( s -> repeat(" ", m - s.length ) + s );
	}
	
	extern public static inline function alignCenter( a:Array<String> ) {
		final center = int( maxLength( a ) / 2 );
		return a.map( s -> repeat(" ", center - int( s.length / 2 )) + s );
	}

	extern public static inline function anyMatch<T>( a:Array<T>, f:( T ) -> Bool ) {
		var found = false;
		for( x in a ) if( f(x) ) {
			found = true;
			break;
		}
		return found;
	}

	/**
	 * Removes all elements from this Array.
	 */
	extern public static inline function clear<T>( a:Array<T> ) a.splice( 0, a.length );
	 
	/**
	 * Return the first Element of `this` Array
	 */
	extern public static inline function first<T>( a:Array<T> ):T {
		return a[0];
	}
	
	/**
	 * returns the first element in an array that satisfies the provided testing function
	 */
	extern public static inline function find<T>( a:Array<T>, f:(item:T) -> Bool ) {
		var index = -1;
		for( x in 0...a.length ) if( f( a[x] )) {
			index = x;
			break;
		}
		return a[index];
	}
	
	/**
	 * returns the index of the first element in an array that satisfies the provided testing function
	 */
	extern public static inline function findIndex<T>( a:Array<T>, f:(item:T) -> Bool ) {
		var index = -1;
		for( x in 0...a.length ) if( f( a[x] )) {
			index = x;
			break;
		}
		return index;
	}
	
	/**
	 * Returns `True` if Array.length is 0
	 */
	extern public static inline function isEmpty<T>( a:Array<T> ):Bool {
		return a.length == 0;
	}

	extern public static inline function compare<T>( a1:Array<T>, a2:Array<T> ) {
		var minLength = MathUtils.min( a1.length, a2.length );
		var sum = 0;
		for( i in 0...minLength ) {
			if( a1[i] == a2[i] ) sum += 1;
		}
		return sum;
	}

	extern public static inline function count<T>( a:Array<T>, e:T ) {
		var sum = 0;
		for( element in a ) if( element == e ) sum += 1;
		return sum;
	}

	public static function combinations<T>( items:Array<T> ) {
		final result:Array<Array<T>> = [];
		recursiveCombine( [], items, result );
		return result;
	}

	static function recursiveCombine<T>( prefix:Array<T>, items:Array<T>, result:Array<Array<T>> ) {
		for( i in 0...items.length ) {
			result.push( prefix.concat( [items[i]] ));
			recursiveCombine( prefix.concat( [items[i]] ), items.slice( i + 1 ), result );
		}
	}

	extern public static inline function combinationsNum<T>( a:Array<T>, numSubItems:Int ) {
		final result = [];
		final indexes = new Vector<Int>( numSubItems );
		for( i in 0...numSubItems ) indexes[i] = i;

		while( indexes[0] < a.length - numSubItems + 1 ) {
			final v = [];
			for( i in 0...numSubItems ) v.push( a[indexes[i]] );
			result.push( v );
			indexes[numSubItems - 1]++;
			var l = numSubItems - 1; // reference always is the last position at beginning
			while (( indexes[numSubItems - 1] >= a.length )&&( indexes[0] < a.length - numSubItems + 1 )) {
				l--; // the last position is reached
				indexes[l]++;
				for( i in l + 1...numSubItems ) {
					indexes[i] = indexes[l] + ( i - l );
				}
			}
		}

		return result;
	}

	extern public static inline function shuffle<T>( a:Array<T>, ?mtRandom:MTRandom ) {
		final rnd = mtRandom == null ? Std.random : mtRandom.nextInt;
		for( i in -a.length + 1...0 ) {
			final j = rnd( -i + 1 );
			final temp = a[-i];
			a[-i] = a[j];
			a[j] = temp;
		}
	}
	
	extern public static inline function findAny<T>( a:Array<T> ) {
		if( a.length == 0 ) return None;
		return Some( a[0] );
	}

	extern public static inline function fact( a:Array<Int> ) {
		var fact = 1;
		for( v in a ) fact *= v;
		return fact;
	}
	
	extern public static inline function ffact( a:Array<Float> ) {
		var fact = 1.0;
		for( v in a ) fact *= v;
		return fact;
	}
	
	extern public static inline function max( a:Array<Int> ) {
		var m = 0;
		for( v in a ) m = MathUtils.max( m, v );
		return m;
	}
	
	extern public static inline function fmax( a:Array<Float> ) {
		var m = 0.0;
		for( v in a ) m = Math.max( m, v );
		return m;
	}

	extern public static inline function last<T>( a:Array<T> ) {
		if( a == null || a.length == 0 ) return null;
		return a[a.length - 1];
	}

	extern public static inline function maxIndex( a:Array<Float> ) {
		var max = 0.0;
		var maxIndex = -1;
		for( i in 0...a.length ) {
			final v = a[i];
			if( v > max ) {
				max = v;
				maxIndex = i;
			}
		}
		return maxIndex;
	}
	
	extern public static inline function minIndex( a:Array<Float> ) {
		var min = Math.POSITIVE_INFINITY;
		var minIndex = -1;
		for( i in 0...a.length ) {
			final v = a[i];
			if( v < min ) {
				min = v;
				minIndex = i;
			}
		}
		return minIndex;
	}
	
	extern public static inline function maxLength( a:Array<String> ) {
		var m = 0;
		for( s in a ) m = MathUtils.max( m, s.length );
		return m;		
	}

	extern public static inline function min( a:Array<Int> ) {
		var m = 0;
		for( v in a ) m = MathUtils.min( m, v );
		return m;
	}
	
	extern public static inline function fmin( a:Array<Int> ) {
		var m = 0.0;
		for( v in a ) m = Math.min( m, v );
		return m;
	}

	extern public static inline function removeIf<T>( a:Array<T>, f:(item:T) -> Bool ) {
		for( i in -a.length + 1...1 ) {
			if( f( a[-i] )) a.remove( a[-i] );
		}
	}

	extern public static inline function repeatArray<T>( v:T, n:Int ) {
		return [for( _ in 0...n ) v];
	}
	
	extern public static inline function sum( a:Array<Int> ) {
		var sum = 0;
		for( v in a ) sum += v;
		return sum;
	}
	
	extern public static inline function fsum( a:Array<Float> ) {
		var sum = 0.0;
		for( v in a ) sum += v;
		return sum;
	}
	
	public static function sort( a:Int, b:Int ) {
		if( a < b ) return -1;
		if( a > b ) return 1;
		return 0;
	}
	
	public static function sortInverse( a:Int, b:Int ) {
		if( a < b ) return 1;
		if( a > b ) return -1;
		return 0;
	}
	
	public static inline function sortStrings( a:String, b:String ) {
		if( a < b ) return -1;
		if( a > b ) return 1;
		return 0;
	}
	
	public static function sortStringsInverse( a:String, b:String ) {
		if( a < b ) return 1;
		if( a > b ) return -1;
		return 0;
	}
	
	public static function fsort( a:Float, b:Float ) {
		if( a < b ) return -1;
		if( a > b ) return 1;
		return 0;
	}
	
	public static function fsortInverse( a:Float, b:Float ) {
		if( a < b ) return 1;
		if( a > b ) return -1;
		return 0;
	}
}