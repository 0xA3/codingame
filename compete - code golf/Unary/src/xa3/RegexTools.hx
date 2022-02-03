package xa3;

function match( s1:String, ereg:EReg ) {
	return ereg.split( s1 );
}

function replace( s1:String, ereg:EReg, s2:String ) {
	return ereg.replace( s1, s2 );
}

function regSplit( s1:String, ereg:EReg ) {
	return ereg.split( s1 );
}
