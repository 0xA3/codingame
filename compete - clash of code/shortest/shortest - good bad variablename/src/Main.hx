import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

/*
Test if a string variablename is a good variable name.

Conditions for a good variable name:
- only contains alphanumeric or underscore character "_"
- it starts with a letter or underscore "_"
- it contains no space
- upper or lower case

Return:
"good variable name" if it is a good variable name
else "bad variable name: " + the first character which makes it a bad variable name

*/

class Main {
	
	static final vn = " variable name";

	static function main() {
		
		final variableName = readline();
	
		final s = check( variableName );
		print( s == "" ? "good" + vn : "bad" + vn + ": " + s );
	}

	static function check( variableName:String ) {
		final chars = variableName.split( "" );
		final alphanumeric = ~/[A-Za-z0-9_]/;
		final letterUnderscore = ~/[A-Za-z_]/;

		if( !letterUnderscore.match( chars[0] )) return chars[0];
		else {
			for( c in chars ) if( !alphanumeric.match( c )) return c;
		}
		return "";
	}

}

