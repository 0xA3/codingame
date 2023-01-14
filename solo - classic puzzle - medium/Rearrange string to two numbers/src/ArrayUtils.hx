using Lambda;

class ArrayUtils {
	
	public static function countNum( digits:Array<Int>, num:Int ) return digits.fold(( d, sum ) -> d == num ? sum + 1 : sum, 0 );
	
	public static function removeNum( digits:Array<Int>, num:Int, times = 1 ) {
		final result = digits.copy();
		for( _ in 0...times ) {
			if( result.indexOf( num ) == -1 ) throw 'Error: $num not found in $result';
			result.remove( num );
		}
		return result;
	}

	public static function createNumberArray( digits:Array<Int> ) {
		if( digits.length == 0 ) throw "Error: digits array is empty";
		if( digits.length == 1 ) return digits;
		for( i in 0...digits.length ) {
			if( digits[i] > 0 ) return digits.slice( i, i + 1 ).concat( digits.slice( 0, i )).concat( digits.slice( i + 1 ));
		}
		throw 'Error: $digits';
		
	}
}