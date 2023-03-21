package xa3;

import haxe.ds.Vector;

class ArrayUtils {
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
}