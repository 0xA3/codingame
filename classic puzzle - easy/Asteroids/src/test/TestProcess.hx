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
			it( "Vertical motion", {
				final ip = verticalMotion;
				Main.process( ip.w, ip.h, ip.t1, ip.t2, ip.t3, ip.firstPictureRows, ip.secondPictureRows ).should.be( verticalMotionResult );
			});
			it( "Combined motion", {
				final ip = combinedMotion;
				Main.process( ip.w, ip.h, ip.t1, ip.t2, ip.t3, ip.firstPictureRows, ip.secondPictureRows ).should.be( combinedMotionResult );
			});
			it( "Negative motion", {
				final ip = negativeMotion;
				Main.process( ip.w, ip.h, ip.t1, ip.t2, ip.t3, ip.firstPictureRows, ip.secondPictureRows ).should.be( negativeMotionResult );
			});
			it( "Greater delta", {
				final ip = greaterDelta;
				Main.process( ip.w, ip.h, ip.t1, ip.t2, ip.t3, ip.firstPictureRows, ip.secondPictureRows ).should.be( greaterDeltaResult );
			});
			it( "Multiple asteroids", {
				final ip = multipleAsteroids;
				Main.process( ip.w, ip.h, ip.t1, ip.t2, ip.t3, ip.firstPictureRows, ip.secondPictureRows ).should.be( multipleAsteroidsResult );
			});
			it( "Depth", {
				final ip = depth;
				Main.process( ip.w, ip.h, ip.t1, ip.t2, ip.t3, ip.firstPictureRows, ip.secondPictureRows ).should.be( depthResult );
			});
			it( "No motion", {
				final ip = noMotion;
				Main.process( ip.w, ip.h, ip.t1, ip.t2, ip.t3, ip.firstPictureRows, ip.secondPictureRows ).should.be( noMotionResult );
			});
			it( "Out of bounds", {
				final ip = outOfBounds;
				Main.process( ip.w, ip.h, ip.t1, ip.t2, ip.t3, ip.firstPictureRows, ip.secondPictureRows ).should.be( outOfBoundsResult );
			});
			it( "Armageddon", {
				final ip = armageddon;
				Main.process( ip.w, ip.h, ip.t1, ip.t2, ip.t3, ip.firstPictureRows, ip.secondPictureRows ).should.be( armageddonResult );
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

	final horizontalMotionResult = parseResult(
		"..A..
		.....
		.....
		.....
		....."
	);

	final verticalMotion = parseInput(
		"5 5 1 2 3
		A.... .....
		..... A....
		..... .....
		..... .....
		..... ....."
	);

	final verticalMotionResult = parseResult(
		".....
		.....
		A....
		.....
		....."
	);

	final combinedMotion = parseInput(
		"5 5 1 2 3
		A.... .....
		..... .A...
		..... .....
		..... .....
		..... ....."
	);

	final combinedMotionResult = parseResult(
		".....
		.....
		..A..
		.....
		....."
	);

	final negativeMotion = parseInput(
		"5 5 1 2 3
		..... .....
		..... .A...
		..A.. .....
		..... .....
		..... ....."
	);

	final negativeMotionResult = parseResult(
		"A....
		.....
		.....
		.....
		....."
	);

	final greaterDelta = parseInput(
		"6 6 1 5 6
		A..... ....A.
		...... ......
		...... ......
		...... ......
		...... ......
		...... ......"
	);

	final greaterDeltaResult = parseResult(
		".....A
		......
		......
		......
		......
		......"
	);

	final multipleAsteroids = parseInput(
		"6 6 1 3 5
		A..... .A....
		...... B.....
		B..... ......
		...... ......
		...... ......
		...... ......"
	);

	final multipleAsteroidsResult = parseResult(
		"B.A...
		......
		......
		......
		......
		......"
	);

	final depth = parseInput(
		"6 6 1 6 11
		..H... ......
		...... ..H...
		E...G. .E.G..
		...... ..F...
		..F... ......
		...... ......"
	);

	final depthResult = parseResult(
		"......
		......
		..E...
		......
		......
		......"
	);

	final noMotion = parseInput(
		"5 5 0 1255 9999
		..... .....
		.C... .C...
		..... .....
		...D. ...D.
		..... ....."
	);

	final noMotionResult = parseResult(
		".....
		.C...
		.....
		...D.
		....."
	);

	final outOfBounds = parseInput(
		"10 10 100 200 300
		A......... .A........
		B......... ..B.......
		C......... ...C......
		D......... ....D.....
		E......... .....E....
		.........F ........F.
		.........G .......G..
		.........H ......H...
		.........I .....I....
		.........J ....J....."
	);

	final outOfBoundsResult = parseResult(
		"..A.......
		....B.....
		......C...
		........D.
		..........
		.......F..
		.....G....
		...H......
		.I........
		.........."
	);

	final armageddon = parseInput(
		"20 20 25 75 100
		.................O.. G...................
		.....N...........U.. ...............W....
		.............L.R.... ...................C
		.............V...... ...E................
		..........Q....H.... ..............K.....
		................X... ...........T........
		.............P...... ............A.......
		.............A...... .....P...FLI......N.
		.Z.............T.... ....................
		..................F. ........D...........
		.................... ......S.......Y....M
		......K............W .........B....Q.....
		..............Y..... ....V...............
		..............S..... ..................J.
		...........JE......D .........O..........
		...M................ ..X...........U.....
		......B..G...C....I. ....................
		.................... ....................
		.................... ..Z................R
		.................... .......H............"
	);

	final armageddonResult = parseResult(
		"..................K.
		....................
		.......I............
		.........T..........
		....................
		...........A........
		..D.F...............
		.P..................
		..S.......B.........
		........L.....Y.....
		....................
		....................
		....................
		....................
		................Q...
		....................
		....................
		....................
		....................
		...................."
	);

}
