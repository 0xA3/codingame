package test;

import Std.parseInt;

using Lambda;
using StringTools;
using buddy.Should;

class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		describe( "Test process", {
			it( "Horizontal motion", {
				final ip = horizontalMotion;
				Main.process( ip.w, ip.h, ip.t1, ip.t2, ip.t3, ip.firstPictureRows, ip.secondPictureRows ).should.be( horizontalMotionResult );
			});
			
		});

	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final inputs = lines[0].split(' ');
		final w = parseInt( inputs[0] );
		final h = parseInt( inputs[1] );
		final t1 = parseInt( inputs[2] );
		final t2 = parseInt( inputs[3] );
		final t3 = parseInt( inputs[4] );
		final firstPictureRows = [];
		final secondPictureRows = [];
		for( i in 0...h ) {
			var inputs = lines[1 + i].split(' ');
			firstPictureRows.push( inputs[0] );
			secondPictureRows.push( inputs[1] );
		}
			
		return { w: w, h: h, t1: t1, t2: t2, t3: t3, firstPictureRows: firstPictureRows, secondPictureRows: secondPictureRows };
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final horizontalMotion = parseInput(
		"5 5 1 2 3
		A.... .A...
		..... .....
		..... .....
		..... .....
		..... ....."
	);

}

