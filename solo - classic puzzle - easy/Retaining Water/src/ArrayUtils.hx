class ArrayUtils {
	
	public static function min( a:Array<Int> ) {
		if( a.length == 0 ) throw "Error: array is Empty";
		var min = a[0];
		for( i in 1...a.length ) if( a[i] < min ) min = a[i];
		return min;
	}

	public static function max( a:Array<Int> ) {
		if( a.length == 0 ) throw "Error: array is Empty";
		var max = a[0];
		for( i in 1...a.length ) if( a[i] > max ) max = a[i];
		return max;
	}

}