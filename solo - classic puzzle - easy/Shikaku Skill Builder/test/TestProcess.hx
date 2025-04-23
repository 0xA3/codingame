package test;

import Std.parseInt;
import test.Readline.initReadline;
import test.Readline.readline;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			
			it( "Single Shape", Main.process( singleShape ).should.be( singleShapeResult ));
			it( "Multi-Shape", Main.process( multiShape ).should.be( multiShapeResult ));
			it( "Two Numbers", Main.process( twoNumbers ).should.be( twoNumbersResult ));
			it( "Not All Can Be Covered", Main.process( notAllCanBeCovered ).should.be( notAllCanBeCoveredResult ));
			it( "One Number, Many Option", Main.process( oneNumberManyOption ).should.be( oneNumberManyOptionResult ));
			it( "Large Grid", Main.process( largeGrid ).should.be( largeGridResult ));
			it( "Chaos - Wide", Main.process( chaosWide ).should.be( chaosWideResult ));
			it( "Chaos - Tall", Main.process( chaosTall ).should.be( chaosTallResult ));
			it( "10 x 10 from Shikaku Solver", Main.process( _10X_10FromShikakuSolver ).should.be( _10X_10FromShikakuSolverResult ));
		});
	}

	static function parseInput( input:String ) {
		initReadline( input );
		final inputs = readline().split(' ');
		final w = parseInt( inputs[0] );
		final h = parseInt( inputs[1] );
		final grid = [for( i in 0...h ) readline().split(' ')];
				
		return grid;
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final singleShape = parseInput(
		"3 2
		0 0 0
		0 4 0"
	);

	final singleShapeResult = parseResult(
		"1 1 4
		0 0 2 2
		0 1 2 2"
	);

	final multiShape = parseInput(
		"3 2
		0 0 0
		0 2 0"
	);

	final multiShapeResult = parseResult(
		"1 1 2
		0 1 1 2
		1 0 2 1
		1 1 2 1"
	);

	final twoNumbers = parseInput(
		"4 3
		0 0 0 0
		0 2 4 0
		0 0 0 0"
	);

	final twoNumbersResult = parseResult(
		"1 1 2
		0 1 1 2
		1 0 2 1
		1 1 1 2
		1 2 4
		0 2 2 2
		1 2 2 2"
	);

	final notAllCanBeCovered = parseInput(
		"5 5
		6 0 0 0 0
		0 2 0 4 0
		0 0 9 0 0
		0 0 0 0 0
		0 0 0 0 0"
	);

	final notAllCanBeCoveredResult = parseResult(
		"1 1 2
		0 1 1 2
		1 0 2 1
		1 1 1 2
		1 1 2 1
		1 3 4
		0 2 2 2
		0 3 1 4
		0 3 2 2
		1 3 1 4
		1 3 2 2
		2 2 9
		2 0 3 3
		2 1 3 3
		2 2 3 3"
	);

	final oneNumberManyOption = parseInput(
		"15 15
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 12 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0"
	);

	final oneNumberManyOptionResult = parseResult(
		"9 6 12
		0 6 1 12
		1 6 1 12
		2 6 1 12
		3 6 1 12
		4 5 2 6
		4 6 2 6
		5 5 2 6
		5 6 2 6
		6 4 3 4
		6 5 2 6
		6 5 3 4
		6 6 2 6
		6 6 3 4
		7 3 4 3
		7 4 3 4
		7 4 4 3
		7 5 2 6
		7 5 3 4
		7 5 4 3
		7 6 2 6
		7 6 3 4
		7 6 4 3
		8 1 6 2
		8 2 6 2
		8 3 4 3
		8 3 6 2
		8 4 3 4
		8 4 4 3
		8 4 6 2
		8 5 2 6
		8 5 3 4
		8 5 4 3
		8 5 6 2
		8 6 2 6
		8 6 3 4
		8 6 4 3
		8 6 6 2
		9 0 12 1
		9 1 6 2
		9 1 12 1
		9 2 6 2
		9 2 12 1
		9 3 4 3
		9 3 6 2
		9 3 12 1
		9 4 3 4
		9 4 4 3
		9 4 6 2
		9 5 2 6
		9 5 3 4
		9 5 4 3
		9 5 6 2
		9 6 2 6
		9 6 3 4
		9 6 4 3
		9 6 6 2"
	);

	final largeGrid = parseInput(
		"30 30
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 27 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0"
	);

	final largeGridResult = parseResult(
		"16 5 27
		0 5 1 27
		1 5 1 27
		2 5 1 27
		3 5 1 27
		8 3 3 9
		8 4 3 9
		8 5 3 9
		9 3 3 9
		9 4 3 9
		9 5 3 9
		10 3 3 9
		10 4 3 9
		10 5 3 9
		11 3 3 9
		11 4 3 9
		11 5 3 9
		12 3 3 9
		12 4 3 9
		12 5 3 9
		13 3 3 9
		13 4 3 9
		13 5 3 9
		14 0 9 3
		14 1 9 3
		14 2 9 3
		14 3 3 9
		14 3 9 3
		14 4 3 9
		14 4 9 3
		14 5 3 9
		14 5 9 3
		15 0 9 3
		15 1 9 3
		15 2 9 3
		15 3 3 9
		15 3 9 3
		15 4 3 9
		15 4 9 3
		15 5 3 9
		15 5 9 3
		16 0 9 3
		16 0 27 1
		16 1 9 3
		16 1 27 1
		16 2 9 3
		16 2 27 1
		16 3 3 9
		16 3 9 3
		16 3 27 1
		16 4 3 9
		16 4 9 3
		16 5 3 9
		16 5 9 3"
	);

	final chaosWide = parseInput(
		"8 4
		4 0 3 0 0 0 0 2
		0 8 0 0 0 12 0 2
		0 0 6 0 4 0 4 2
		2 0 0 5 0 0 0 2"
	);

	final chaosWideResult = parseResult(
		"0 2 3
		0 1 3 1
		0 2 3 1
		0 7 2
		0 6 2 1
		1 7 2
		1 6 2 1
		2 4 4
		0 4 1 4
		1 3 2 2
		2 4 2 2
		2 6 4
		0 6 1 4
		2 5 2 2
		3 0 2
		2 0 1 2
		3 0 2 1
		3 3 5
		3 1 5 1
		3 2 5 1
		3 7 2
		3 6 2 1"
	);

	final chaosTall = parseInput(
		"4 8
		4 0 3 0
		0 8 0 0
		0 0 6 0
		2 0 0 5
		0 0 0 0
		6 0 0 2
		0 3 0 4
		2 2 2 2"
	);

	final chaosTallResult = parseResult(
		"0 2 3
		0 1 3 1
		2 2 6
		1 2 1 6
		2 1 2 3
		3 0 2
		2 0 1 2
		3 0 1 2
		3 0 2 1
		3 3 5
		0 3 1 5
		5 0 6
		4 0 3 2
		5 3 2
		4 3 1 2
		5 2 2 1
		6 1 3
		4 1 1 3
		6 0 3 1
		7 0 2
		6 0 1 2
		7 2 2
		6 2 1 2"
	);

	final _10X_10FromShikakuSolver = parseInput(
		"10 10
		0 0 0 0 0 0 0 0 9 0
		0 0 0 0 0 0 9 0 0 0
		0 0 0 0 0 0 0 0 0 0
		0 20 0 0 8 0 0 0 6 0
		0 0 0 0 0 0 0 0 0 0
		0 0 0 6 0 0 6 0 0 0
		10 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0
		0 0 6 0 6 0 0 0 8 0
		0 0 0 0 0 0 6 0 0 0"
	);

	final _10X_10FromShikakuSolverResult = parseResult(
		"0 8 9
		0 0 9 1
		0 1 9 1
		0 7 3 3
		1 6 9
		0 4 3 3
		0 5 3 3
		1 0 9 1
		1 1 9 1
		1 5 3 3
		3 1 20
		0 0 4 5
		3 4 8
		0 3 2 4
		0 4 1 8
		0 4 2 4
		1 3 2 4
		1 4 2 4
		2 2 4 2
		2 3 4 2
		2 4 2 4
		2 4 4 2
		3 2 4 2
		3 3 4 2
		3 4 2 4
		3 4 4 2
		3 8 6
		1 7 2 3
		1 8 1 6
		1 8 2 3
		2 6 3 2
		2 7 2 3
		2 7 3 2
		2 8 1 6
		2 8 2 3
		3 6 3 2
		3 7 2 3
		3 7 3 2
		3 8 2 3
		5 3 6
		0 3 1 6
		1 3 1 6
		2 3 1 6
		3 2 2 3
		3 3 1 6
		4 1 3 2
		4 2 2 3
		4 2 3 2
		4 3 1 6
		4 3 2 3
		4 3 3 2
		5 0 6 1
		5 1 3 2
		5 2 2 3
		5 2 3 2
		5 3 2 3
		5 3 3 2
		5 6 6
		2 6 1 6
		3 5 2 3
		3 6 1 6
		3 6 2 3
		4 4 3 2
		4 5 2 3
		4 5 3 2
		4 6 2 3
		4 6 3 2
		5 4 3 2
		5 4 6 1
		5 5 2 3
		5 5 3 2
		5 6 2 3
		5 6 3 2
		6 0 10
		0 0 1 10
		4 0 2 5
		5 0 2 5
		6 0 5 2
		6 0 10 1
		8 2 6
		3 2 1 6
		4 2 1 6
		6 1 2 3
		6 2 2 3
		7 0 3 2
		7 1 2 3
		7 1 3 2
		7 2 2 3
		8 0 3 2
		8 1 3 2
		8 4 6
		4 4 1 6
		6 3 2 3
		6 4 2 3
		7 3 2 3
		7 3 3 2
		7 4 2 3
		7 4 3 2
		8 3 3 2
		8 8 8
		5 7 2 4
		5 8 2 4
		6 7 2 4
		6 8 2 4
		7 5 4 2
		7 6 4 2
		9 6 6
		7 5 2 3
		7 6 2 3
		8 5 3 2
		9 1 6 1
		9 2 6 1
		9 3 6 1
		9 4 6 1"
	);
}
