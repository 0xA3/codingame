import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

@:keep function mixWishes( wishA:String, wishB:String ) {

	final wa = wishA.split( "" );
	final wb = wishB.split( "" );

	final mixA = [];
	for( i in 0...wa.length ) {
		final charA = wa[i];
		final indexB = wb.indexOf( charA );
		// printErr( 'charA $charA  indexB $indexB' );
		if( indexB != -1 ) {
			final partB = wb.splice( 0, indexB + 1 );
			// printErr( 'mixA.push( $partB )' );
			for( i in 0...partB.length ) {
				mixA.push( partB[i] );
			}
		} else {
			mixA.push( charA );
		}
	}
	for( i in 0...wb.length ) {
		mixA.push( wb[i] );
		// printErr( 'mixA.push( ${wb[i]} )' );
	}

	final wa = wishA.split( "" );
	final wb = wishB.split( "" );
	
	final mixB = [];
	for( i in 0...wb.length ) {
		final charB = wb[i];
		final indexA = wa.indexOf( charB );
		// printErr( 'charB $charB     indexA $indexA' );
		if( indexA != -1 ) {
			final partA = wa.splice( 0, indexA + 1 );
			for( i in 0...partA.length ) {
				mixB.push( partA[i] );
			}
			// printErr( 'mixB.push( $partA )  ${mixB.join( "" )}' );
		} else {
			mixB.push( charB );
			// printErr( 'mixB.push( $charB )  ${mixB.join( "" )}' );
		}
	}
	for( i in 0...wa.length ) {
		mixB.push( wa[i] );
		// printErr( 'mixB.push( ${wa[i]} )' );
	}

	printErr( mixA.join( "" ));
	printErr( mixB.join( "" ));

	final mix = mixA.length < mixB.length ? mixA.join( "" ) : mixB.join( "" );
	
	return mix;
}

