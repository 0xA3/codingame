/**
 * Auto-generated code below aims at helping you parse
 * the standard input according to the problem statement.
 **/

class Main {
	
	static function main() {
		
		final L = Std.parseInt( CodinGame.readline());
		final H = Std.parseInt( CodinGame.readline());
		final T = CodinGame.readline();
		// untyped console.error( 'L $L' );
		// untyped console.error( 'H $H' );
		// untyped console.error( 'T $T' );
		
		final chars = T.toLowerCase().split( "" );
		final charCodes = chars.map( char -> char.charCodeAt( 0 ) - 97 );
		final charCodesWithQuestionmark = charCodes.map( charCode -> charCode >= 0 && charCode < 26 ? charCode : 26 );

		// untyped console.error( 'charCodes $charCodesWithQuestionmark' );
		final inputRows = [for( i in 0...H ) CodinGame.readline()];
		final outputRows = inputRows.map( inputRow -> charCodesWithQuestionmark.map( charCode -> inputRow.substr( charCode * L, L )).join( "" ) );
		
		for( row in outputRows ) CodinGame.print( row);
		
	}
}
