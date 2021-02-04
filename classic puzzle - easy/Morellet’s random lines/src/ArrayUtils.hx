class ArrayUtils {
	
	public static function min( a:Array<Int> ) {
		if( a.length == 0 ) throw "Error: array is Empty";
		final toSort = a.copy();
		toSort.sort(( a, b ) -> {
			return a > b ? 1 : a < b ? -1 : 0;
		});
		return toSort[0];
	}

	public static function minf( a:Array<Float> ) {
		if( a.length == 0 ) throw "Error: array is Empty";
		final toSort = a.copy();
		toSort.sort(( a, b ) -> {
			return a > b ? 1 : a < b ? -1 : 0;
		});
		return toSort[0];
	}

	public static function every<T>( a:Array<T>, f:( T ) -> Bool ) {
		for( i in 0...a.length ) {
			if( !f( a[i] )) return false;
		}
		return true;
	}

	public static function unique( a:Array<String> ) {
		
		final map:Map<String, Bool> = [];
		for( element in a ) map.set( element, true );
		
		final u:Array<String> = [];
		for( key in map.keys() ) u.push( key );
		
		return u;
	}
}