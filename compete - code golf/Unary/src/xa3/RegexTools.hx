package xa3;

function match( s:String, ereg:EReg ) {
	final matched = [];
	var m = s;
	while( ereg.match( m )) {
		matched.push( ereg.matched( 1 ));
		m = ereg.matchedRight();
	}
	return matched;
}

function replace( s1:String, ereg:EReg, s2:String ) {
	return ereg.replace( s1, s2 );
}

function regSplit( s1:String, ereg:EReg ) {
	return ereg.split( s1 );
}
