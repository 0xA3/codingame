/**
	Compares Array `a1` with `a2` according to the comparison function `cmp` where
	`cmp(x, y`) returns true if all elements of both arrays are equal.
**/
function compare<T>( a1:Array<T>, a2:Array<T>, cmp:( T, T )-> Bool ) {
	if( a1 == null ) throw "Error: a1 is null";
	if( a2 == null ) throw "Error: a2 is null";
	if( a1.length != a2.length ) return false;
	for( i in 0...a1.length ) return cmp( a1[i], a2[i] );
	return true;
}
