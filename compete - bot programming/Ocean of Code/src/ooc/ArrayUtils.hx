package ooc;

class ArrayUtils {
	
	public static function contains<T>( a:Array<T>, element:T ) {
		return a.indexOf( element ) != -1;
	}

	public static function notContains<T>( a:Array<T>, element:T ) {
		return a.indexOf( element ) == -1;
	}
}