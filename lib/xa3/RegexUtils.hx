package xa3;

class RegexUtils {
	#if !lua
	public static function getMatches( s:String, eReg:EReg, index = 1 ) {
		final matched = [];
		var input = s;
		while( eReg.match( input )) {
			matched.push( eReg.matched( index ));
			input = eReg.matchedRight();
		}
		return matched;
	}
	
	public static function regReplace( s1:String, ereg:EReg, s2:String ) {
		return ereg.replace( s1, s2 );
	}
	
	public static function regSplit( s1:String, ereg:EReg ) {
		return ereg.split( s1 );
	}
	#end
}