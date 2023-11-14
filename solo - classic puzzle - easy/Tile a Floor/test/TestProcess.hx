package test;

import CompileTime.readFile;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "No special mirrors Test 1", Main.process( parseInput( readFile( "test/test_01.txt" )) ).should.be( parseResult( readFile( "test/result_01.txt" )) ));
			it( "WM Test 2", Main.process( parseInput( readFile( "test/test_02.txt" )) ).should.be( parseResult( readFile( "test/result_02.txt" )) ));
			it( "<> Test 3", Main.process( parseInput( readFile( "test/test_03.txt" )) ).should.be( parseResult( readFile( "test/result_03.txt" )) ));
			it( "Diags Test 4", Main.process( parseInput( readFile( "test/test_04.txt" )) ).should.be( parseResult( readFile( "test/result_04.txt" )) ));
			it( "nu and ][ Test 5", Main.process( parseInput( readFile( "test/test_05.txt" )) ).should.be( parseResult( readFile( "test/result_05.txt" )) ));
			it( "AV and slashes Test 6", Main.process( parseInput( readFile( "test/test_06.txt" )) ).should.be( parseResult( readFile( "test/result_06.txt" )) ));
			it( "(()) and slashes Test 7", Main.process( parseInput( readFile( "test/test_07.txt" )) ).should.be( parseResult( readFile( "test/result_07.txt" )) ));
			it( "Everything Test 8", Main.process( parseInput( readFile( "test/test_08.txt" )) ).should.be( parseResult( readFile( "test/result_08.txt" )) ));
			it( "Test 9", Main.process( parseInput( readFile( "test/test_09.txt" )) ).should.be( parseResult( readFile( "test/result_09.txt" )) ));
			it( "Test 10", Main.process( parseInput( readFile( "test/test_10.txt" )) ).should.be( parseResult( readFile( "test/result_10.txt" )) ));
			it( "Test 11", Main.process( parseInput( readFile( "test/test_11.txt" )) ).should.be( parseResult( readFile( "test/result_11.txt" )) ));
			it( "Test 12", Main.process( parseInput( readFile( "test/test_12.txt" )) ).should.be( parseResult( readFile( "test/result_12.txt" )) ));
			it( "Test 13", Main.process( parseInput( readFile( "test/test_13.txt" )) ).should.be( parseResult( readFile( "test/result_13.txt" )) ));
			it( "Test 14", Main.process( parseInput( readFile( "test/test_14.txt" )) ).should.be( parseResult( readFile( "test/result_14.txt" )) ));
			it( "Test 15", Main.process( parseInput( readFile( "test/test_15.txt" )) ).should.be( parseResult( readFile( "test/result_15.txt" )) ));
			it( "Test 16", Main.process( parseInput( readFile( "test/test_16.txt" )) ).should.be( parseResult( readFile( "test/result_16.txt" )) ));
			it( "Test 17", Main.process( parseInput( readFile( "test/test_17.txt" )) ).should.be( parseResult( readFile( "test/result_17.txt" )) ));
			it( "Test 18", Main.process( parseInput( readFile( "test/test_18.txt" )) ).should.be( parseResult( readFile( "test/result_18.txt" )) ));
			it( "Test 19", Main.process( parseInput( readFile( "test/test_19.txt" )) ).should.be( parseResult( readFile( "test/result_19.txt" )) ));
			it( "Test 20", Main.process( parseInput( readFile( "test/test_20.txt" )) ).should.be( parseResult( readFile( "test/result_20.txt" )) ));
			it( "Test 21", Main.process( parseInput( readFile( "test/test_21.txt" )) ).should.be( parseResult( readFile( "test/result_21.txt" )) ));
			it( "Test 22", Main.process( parseInput( readFile( "test/test_22.txt" )) ).should.be( parseResult( readFile( "test/result_22.txt" )) ));
			it( "Test 23", Main.process( parseInput( readFile( "test/test_23.txt" )) ).should.be( parseResult( readFile( "test/result_23.txt" )) ));
			it( "Test 24", Main.process( parseInput( readFile( "test/test_24.txt" )) ).should.be( parseResult( readFile( "test/result_24.txt" )) ));
			it( "Test 25", Main.process( parseInput( readFile( "test/test_25.txt" )) ).should.be( parseResult( readFile( "test/result_25.txt" )) ));
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );

		return lines.slice( 1 ).map( s -> s.split( "" ));
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}
}
