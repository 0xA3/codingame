package xa3;

import haxe.ds.Vector;

class ArrayUtils {

	/**
	 * Removes all elements from this Array.
	 */
	public static function clear<T>( a:Array<T> ) a.splice( 0, a.length );

	/**
	 * Return the first Element of `this` Array
	 */
	public static function first<T>( a:Array<T> ):T {
		return a[0];
	}
	
	/**
	 * Returns `True` if Array.length is 0
	 */
	public static function isEmpty<T>( a:Array<T> ):Bool {
		return a.length == 0;
	}


	/**
	 * Return the first Element of `this` Array
	 */
	public static function last<T>( a:Array<T> ):T {
		return a[a.length - 1];
	}

	/**
	 * Returns a copy of `this` Array with double Elements removed
	 *
	 * The Array must be sorted
	 */
	public static function uniquify<T>( sortedArray:Array<T> ):Array<T> {
       
		if( sortedArray.length == 0 ) return [];

        // Create a vector with unique elements.
        var vec = new Vector( sortedArray.length );
        vec[0] = sortedArray[0];
        var len = 0;
       
		// Can have trailing elements.
        for( item in sortedArray ) {
        	
			if( item != vec[len] ) {
            	len++;
            	vec[len] = item;
        	} // else {
				// if( len > 0 ) trace( 'duplicateTimestamp for $pair ${item.timestamp} at ${Date.fromTime( item.timestamp )}' );
			// }
        }
    	// Remove trailing elements.
    	var out = new Vector( len + 1 );
    	while( len > -1 ) {
            out[len] = vec[len];
            len--;
        }
        // Convert to array and return.
        return out.toArray();
	}

	/**
	 * Return copy of Array with double Elements removed according to the comparison function `f`
	 * Returns a copy of `this` Array with double Elements removed
	 *
	 * The Array must be sorted
	 */
	public static function uniquifyBy<T>( sortedArray:Array<T>, f:( T, T )->Int ):Array<T> {
       
		if( sortedArray.length == 0 ) return [];

        // Create a vector with unique elements.
        var vec = new Vector( sortedArray.length );
        vec[0] = sortedArray[0];
        var len = 0;
       
		// Can have trailing elements.
        for( item in sortedArray ) {
        	
			if( f( item, vec[len] ) != 0 ) {
            	len++;
            	vec[len] = item;
        	}
        }
    	// Remove trailing elements.
    	var out = new Vector( len + 1 );
    	while( len > -1 ) {
            out[len] = vec[len];
            len--;
        }
        // Convert to array and return.
        return out.toArray();
	}

	/**
	 * Merges two Int arrays.
	 * Sorts the new array
	 * Returns a new array with double elements removed
	 */
	public static function intMergeAndUniquify( a:Array<Int>, b:Array<Int> ) {
		final c = a.concat( b );
		c.sort(( a, b ) -> a - b );
		return uniquify( c );
	}

	/**
	 * Merges two arrays.
	 * Sorts the new array according to the comparison function `f`
	 * Returns a new array with double elements removed the comparison function `f`
	 */
	public static function mergeAndUniquify<T>( a:Array<T>, b:Array<T>, f:( T, T )->Int ):Array<T> {
		final c = a.concat( b );
		c.sort( f );
		return uniquifyBy( c, f );
	}

	public static function maxIndex( a:Array<Float> ) {
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
	
	public static function minIndex( a:Array<Float> ) {
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

	public static function shuffle<T>( a:Array<T>, ?random:MTRandom ) {
		final rand = random == null ? Std.random : random.nextInt;
		for( i in -a.length + 1...0 ) {
			final j = rand( -i );
			final temp = a[j];
			a[j] = a[-i];
			a[-i] = temp;
		}
	}
	
}