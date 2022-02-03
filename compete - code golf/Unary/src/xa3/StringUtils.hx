package xa3;

function toString( v:Int, ?radix = 10 ) {
	return radix == 10 ? Std.string( v ) : convertToBase( v, radix );
}

function convertToBase( v:Int, radix:Int ):String {
	var converted = "";
	var number = v;
	while( number > 0 ) {
		converted = ( number % radix ) + converted;
		number = Std.int( number / radix );
	}
	return converted;
}

function repeat( s:String, v:Int ) {
	return [for( _ in 0...v ) s].join( "" );
}