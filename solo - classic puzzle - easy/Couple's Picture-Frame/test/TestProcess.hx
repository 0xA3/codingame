package test;

import CompileTime.readFile;
import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Same Length - Test 1", {
				final ip = parseInput( readFile( "test/test_01.txt" ));
				Main.process( ip.wife, ip.husband ).should.be( parseResult( readFile( "test/result_01.txt" )) );
			});
			it( "wife is twice husband - Test 2", {
				final ip = parseInput( readFile( "test/test_02.txt" ));
				Main.process( ip.wife, ip.husband ).should.be( parseResult( readFile( "test/result_02.txt" )) );
			});
			it( "husband is twice wife - Test 3", {
				final ip = parseInput( readFile( "test/test_03.txt" ));
				Main.process( ip.wife, ip.husband ).should.be( parseResult( readFile( "test/result_03.txt" )) );
			});
			it( "husband is 3x wife - Test 4", {
				final ip = parseInput( readFile( "test/test_04.txt" ));
				Main.process( ip.wife, ip.husband ).should.be( parseResult( readFile( "test/result_04.txt" )) );
			});
			it( "wife is 3x husband - Test 5", {
				final ip = parseInput( readFile( "test/test_05.txt" ));
				Main.process( ip.wife, ip.husband ).should.be( parseResult( readFile( "test/result_05.txt" )) );
			});
			it( "gcf is 1 - Test 6", {
				final ip = parseInput( readFile( "test/test_06.txt" ));
				Main.process( ip.wife, ip.husband ).should.be( parseResult( readFile( "test/result_06.txt" )) );
			});
			it( "gcf is 2, wife is longer - Test 7", {
				final ip = parseInput( readFile( "test/test_07.txt" ));
				Main.process( ip.wife, ip.husband ).should.be( parseResult( readFile( "test/result_07.txt" )) );
			});
			it( "gcf is 2, wife is shorter - Test 8", {
				final ip = parseInput( readFile( "test/test_08.txt" ));
				Main.process( ip.wife, ip.husband ).should.be( parseResult( readFile( "test/result_08.txt" )) );
			});
			it( "multiples of 3, wife is longer - Test 9", {
				final ip = parseInput( readFile( "test/test_09.txt" ));
				Main.process( ip.wife, ip.husband ).should.be( parseResult( readFile( "test/result_09.txt" )) );
			});
			it( "multiples of 3, wife is shorter - Test 10", {
				final ip = parseInput( readFile( "test/test_10.txt" ));
				Main.process( ip.wife, ip.husband ).should.be( parseResult( readFile( "test/result_10.txt" )) );
			});
			it( "more random cases - Test 11", {
				final ip = parseInput( readFile( "test/test_11.txt" ));
				Main.process( ip.wife, ip.husband ).should.be( parseResult( readFile( "test/result_11.txt" )) );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );

		return { wife: lines[0], husband: lines[1] }
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}
}
