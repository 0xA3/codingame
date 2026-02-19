package test;

import CodinGame.printErr;
import Std.parseInt;
import test.Readline.initReadline;
import test.Readline.readline;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Triangle", Main.process( triangle ).should.be( triangleResult ));
			it( "Two Intersects", Main.process( twoIntersects ).should.be( twoIntersectsResult ));
			it( "Two Parallel", Main.process( twoParallel ).should.be( twoParallelResult ));
			it( "Square", Main.process( square ).should.be( squareResult ));
			it( "Square Crossed", Main.process( squareCrossed ).should.be( squareCrossedResult ));
			it( "One Line", Main.process( oneLine ).should.be( oneLineResult ));
			it( "Zero", Main.process( zero ).should.be( zeroResult ));
			it( "10 Lines", Main.process( tenLines ).should.be( tenLinesResult ));
			it( "10 Lines with Maximum Intersections", Main.process( tenLinesMaxIntersections ).should.be( tenLinesMaxIntersectionsResult ));
			it( "10 Coincident Lines", Main.process( tenCoincidentLines ).should.be( tenCoincidentLinesResult ));
			it( "All Cases", Main.process( allCases ).should.be( allCasesResult ));
			it( "Star", Main.process( star ).should.be( starResult ));
		});
	}

	static function parseInput( input:String ) {
		initReadline( input );
		
		final n = parseInt(readline());
		final lines = [for( i in 0...n ) {
			var inputs = readline().split(' ');
			final x1 = parseInt(inputs[0]);
			final y1 = parseInt(inputs[1]);
			final x2 = parseInt(inputs[2]);
			final y2 = parseInt(inputs[3]);
			new Line( x1, y1, x2, y2 );
		}];
					
		return lines;
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final triangle = parseInput(
		"3
		-6 -5 12 12
		4 -44 9 19
		4 -44 50 19"
	);
	
	final triangleResult = parseResult(
		"3
		4.000 -44.000
		8.156 8.370
		117.955 112.068"
	);

	final twoIntersects = parseInput(
		"2
		4 20 20 4
		0 0 0 50"
	);

	final twoIntersectsResult = parseResult(
		"1
		0.000 24.000"
	);

	final twoParallel = parseInput(
		"2
		1 1 20 20
		16 0 20 4"
	);

	final twoParallelResult = parseResult(
		"0"
	);

	final square = parseInput(
		"4
		0 0 4 0
		4 0 4 4
		4 4 0 4
		0 4 0 0"
	);

	final squareResult = parseResult(
		"4
		0.000 0.000
		0.000 4.000
		4.000 0.000
		4.000 4.000"
	);

	final squareCrossed = parseInput(
		"6
		2 3 12 3
		2 13 12 13
		2 3 2 13
		12 3 12 13
		2 3 12 13
		2 13 12 3"
	);

	final squareCrossedResult = parseResult(
		"5
		2.000 3.000
		2.000 13.000
		7.000 8.000
		12.000 3.000
		12.000 13.000"
	);

	final oneLine = parseInput(
		"1
		45 23 12 -9"
	);

	final oneLineResult = parseResult(
		"0"
	);

	final zero = parseInput(
		"0"
	);

	final zeroResult = parseResult(
		"0"
	);

	final tenLines = parseInput(
		"10
		0 0 20 20
		0 20 10 40
		100 60 10 20
		0 10 20 10
		0 1 20 21
		0 2 20 22
		0 19 20 -1
		5 0 5 20
		0 11 20 11
		15 0 15 20"
	);

	final tenLinesResult = parseResult(
		"38
		-20.000 -20.000
		-19.000 -18.000
		-18.000 -16.000
		-12.500 10.000
		-10.250 11.000
		-5.000 10.000
		-4.500 11.000
		-2.857 14.286
		-0.333 19.333
		2.385 16.615
		5.000 5.000
		5.000 6.000
		5.000 7.000
		5.000 10.000
		5.000 11.000
		5.000 14.000
		5.000 17.778
		5.000 30.000
		8.000 10.000
		8.000 11.000
		8.500 10.500
		9.000 10.000
		9.000 11.000
		9.500 9.500
		10.000 10.000
		10.000 11.000
		11.000 11.000
		15.000 4.000
		15.000 10.000
		15.000 11.000
		15.000 15.000
		15.000 16.000
		15.000 17.000
		15.000 22.222
		15.000 50.000
		24.400 26.400
		26.200 27.200
		28.000 28.000"
	);

	final tenLinesMaxIntersections = parseInput(
		"10
		-9 -80 -70 -65
		-80 10 -60 85
		-50 -9 -30 -75
		-40 60 -2 45
		-30 -5 -15 -30
		10 7 30 55
		20 -6 40 -45
		30 95 5 70
		60 -85 8 -60
		70 4 90 25"
	);

	final tenLinesMaxIntersectionsResult = parseResult(
		"45
		-1166.588 504.706
		-242.222 -598.333
		-153.333 332.000
		-140.556 -217.083
		-118.158 -53.158
		-98.154 -58.077
		-89.091 -24.091
		-86.545 -14.545
		-81.818 -16.818
		-78.000 75.000
		-75.109 73.859
		-72.857 66.429
		-68.652 52.553
		-67.385 57.308
		-64.127 69.524
		-55.581 9.419
		-48.596 127.763
		-45.000 20.000
		-41.801 -36.057
		-38.889 -110.333
		-30.054 -74.823
		-27.544 -83.105
		-24.647 -76.152
		-24.023 -94.724
		-14.906 50.094
		-13.591 -49.619
		-10.847 54.153
		-9.810 -79.801
		-9.344 -39.426
		-7.208 47.056
		0.973 -56.622
		5.337 -63.896
		8.719 -60.345
		11.494 10.586
		19.154 -86.923
		21.902 35.565
		34.167 -33.625
		58.571 123.571
		60.681 -85.327
		67.609 -98.838
		78.707 13.142
		110.953 -109.497
		310.588 -572.647
		849.420 -291.087
		2690.000 2755.000"
	);

	final tenCoincidentLines = parseInput(
		"10
		-6 -8 -1 2
		-5 -6 2 8
		0 4 -4 -4
		-10 -16 10 24
		-24 -44 -22 -40
		38 80 39 82
		48 100 -52 -100
		-40 -76 -52 -100
		-1 2 48 100
		0 4 -2 0"
	);

	final tenCoincidentLinesResult = parseResult(
		"0"
	);

	final allCases = parseInput(
		"10
		-3 0 -3 5
		-3 -8 -3 -9
		-2 2 2 3
		-3 -2 1 -1
		-8 7 12 -1
		-18 11 27 -7
		0 0 0 1
		0 -1 0 -2
		0 0 1 0
		-1 0 -2 0"
	);

	final allCasesResult = parseResult(
		"13
		-10.000 0.000
		-3.000 -2.000
		-3.000 0.000
		-3.000 1.750
		-3.000 5.000
		0.000 -1.250
		0.000 0.000
		0.000 2.500
		0.000 3.800
		2.000 3.000
		5.000 0.000
		7.769 0.692
		9.500 0.000"
	);

	final star = parseInput(
		"8
		0 1 0 -1
		-1 0 1 0
		2 2 -2 -2
		-2 2 2 -2
		-3 1 3 -1
		-3 -1 3 1
		-1 3 1 -3
		-1 -3 1 3"
	);

	final starResult = parseResult(
		"1
		0.000 0.000"
	);
}