package xa3;

class ArrayUtils {
	
	public static function maxIndex( a:Array<Int> ) {
		var max = -1;
		var maxIndex = -1;
		for( i in 0...a.length ) {
			if( a[i] > max ) {
				max = a[i];
				maxIndex = i;
			}
		}

		return maxIndex;
	}
	
	public static function minIndex( a:Array<Int> ) {
		var max = -1;
		var minIndex = -1;
		for( i in 0...a.length ) {
			if( a[i] > max ) {
				max = a[i];
				minIndex = i;
			}
		}

		return minIndex;
	}
}