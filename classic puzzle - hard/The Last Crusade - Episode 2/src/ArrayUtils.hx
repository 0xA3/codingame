/**
	Compares Array `a1` with `a2` according to the comparison function `cmp` where
	`cmp(x, y`) returns true if all elements of both arrays are equal.
**/
function compare<T>( a1:Array<T>, a2:Array<T>, cmp:( T, T ) -> Bool ) {
	if( a1 == null ) throw "Error: a1 is null";
	if( a2 == null ) throw "Error: a2 is null";
	if( a1.length != a2.length ) return false;
	for( i in 0...a1.length ) return cmp( a1[i], a2[i] );
	return true;
}
/**
 * Returns the value of the first element in the provided array that satisfies the
 * provided testing function. If no values satisfy the testing function, null
 * is returned.
 */
function find<T>( a:Array<T>, f:( T ) -> Bool ) {
	if( a == null ) return null;
	for( element in a ) {
		if( f( element )) return element;
	}
	return null;
}