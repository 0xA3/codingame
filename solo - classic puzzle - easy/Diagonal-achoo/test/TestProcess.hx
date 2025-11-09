package test;

import CodinGame.printErr;
import CompileTime.readFile;
import Std.parseInt;
import test.Readline.initReadline;
import test.Readline.readline;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Simple", Main.process( simple ).should.be( simpleResult ));
			it( "Easy Comparision", Main.process( parseInput( readFile( "test/Test_01.txt" ))).should.be( easyComparisonResult ));
			it( "Simulation Chamber - I", Main.process( parseInput( readFile( "test/Test_02.txt" ))).should.be( simulationChamberIResult ));
			it( "Simulation Chamber - II", Main.process( parseInput( readFile( "test/Test_03.txt" ))).should.be( simulationChamberIIResult ));
			it( "Large Scale Simulation", Main.process( parseInput( readFile( "test/Test_04.txt" ))).should.be( largeScaleSimulationResult ));
			it( "One Man Chambers", Main.process( parseInput( readFile( "test/Test_05.txt" ))).should.be( oneManChambersResult ));
			it( "Weird Patterns - I", Main.process( parseInput( readFile( "test/Test_06.txt" ))).should.be( weirdPatternsIResult ));
			it( "Weird Patterns - II", Main.process( parseInput( readFile( "test/Test_07.txt" ))).should.be( weirdPatternsIIResult ));
		});
	}

	static function parseInput( input:String ) {
		initReadline( input );
		
		final n = parseInt( readline() );
		final g = parseInt( readline() );

		final grids = [];
		for( index in 0...g ) {
			final content = [for( _ in 0...n ) readline().split( "" )];
			final grid = new Grid( index, content );
			grid.initNumberOfInfected();

			grids.push( grid );
		}
		
		return grids;
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final simple = parseInput(
		"2
		1
		C.
		.."
	);

	final simpleResult = parseResult(
		"0
		C.
		.C"
	);

	final easyComparisonResult = parseResult(
		"1
		.C.C.
		C.C.C
		.C.C.
		C.C.C
		.C.C."
	);

	final simulationChamberIResult = parseResult(
		"0
		CHCH
		.C.C
		C.C.
		.H.C"
	);

	final simulationChamberIIResult = parseResult(
		"5
		.C.C.C
		C.C.C.
		.C.CHC
		CHC.C.
		.CHC.C
		C.C.C."
	);

	final largeScaleSimulationResult = parseResult(
		"3
		.C.C.C.C.C
		C.C.C.C.C.
		.C.C.C.CHC
		C.C.C.C.C.
		.C.C.CHC.C
		C.C.CHC.C.
		.C.CHC.C.C
		C.C.C.C.C.
		.C.C.CHC.C
		C.C.C.C.C."
	);

	final oneManChambersResult = parseResult(
		"1
		C"
	);

	final weirdPatternsIResult = parseResult(
		"0
		CCCCCCCCCC
		CCCCCCCCCC
		CCCCCCCCCC
		CCCCCCCCCC
		CCCCCCCCCC
		CCCCCCCCCC
		CCCCCCCCCC
		CCCCCCCCCC
		CCCCCCCCCC
		CCCCCCCCCC"
	);

	final weirdPatternsIIResult = parseResult(
		"2
		CCCCCCCCCC
		CCCCCCCCCC
		CCCCCCCCCC
		CCCCCCCCCC
		CCCCCCCCCC
		CCCCCCCCCC
		CCCCCCCCCC
		CCCCCCCCCC
		CCCCCCCCCC
		CCCCCCCCCC"
	);
}