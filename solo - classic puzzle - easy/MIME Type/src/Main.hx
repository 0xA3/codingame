/**
 * Auto-generated code below aims at helping you parse
 * the standard input according to the problem statement.
 **/

class Main {
	
	static function main() {
		
		final N = Std.parseInt( CodinGame.readline()); // Number of elements which make up the association table.
		final Q = Std.parseInt( CodinGame.readline()); // Number Q of file names to be analyzed.
		
		// untyped console.error( 'N $N' );
		// untyped console.error( 'Q $Q' );
		
		final mimeTypes:Map<String, String> = [];
		
		for( i in 0...N ) {
			var inputs = CodinGame.readline().split(' ');
			final EXT = inputs[0].toLowerCase(); // file extension
			final MT = inputs[1]; // MIME type.

			// untyped console.error( '$i EXT .$EXT  MT $MT' );
			mimeTypes.set( '.$EXT', MT );
		}

		final extReg = ~/\.[0-9a-z]+$/i;

		for( i in 0...Q ) {
			
			final FNAME = CodinGame.readline(); // One file name per line.
			// untyped console.error( 'FNAME $FNAME' );
			
			final hasExtension = extReg.match( FNAME );
			// untyped console.error( 'hasExtension $hasExtension' );
			
			final extension = hasExtension ? extReg.matched( 0 ).toLowerCase() : '';
			// untyped console.error( '$FNAME  extension $extension' );
			
			CodinGame.print( mimeTypes.exists( extension ) ? mimeTypes.get( extension ) : 'UNKNOWN' );
		}

	}

}
