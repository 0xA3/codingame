class ArrayUtils {
	
	public static function max( a:Array<Int> ) {
		if( a.length == 0 ) return 0;
		final toSort = a.copy();
		toSort.sort(( a, b ) -> {
			return a > b ? -1 : a < b ? 1 : 0;
		});
		return toSort[0];
	}

}