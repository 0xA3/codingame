package xa3;

class ERegUtils {
	
	public static function getMatches( eReg:EReg, s:String, index = 1 ) {
		final matched = [];
		var input = s;
		while( eReg.match( input )) {
			matched.push( eReg.matched( index ));
			input = eReg.matchedRight();
		}
		return matched;
	}
}