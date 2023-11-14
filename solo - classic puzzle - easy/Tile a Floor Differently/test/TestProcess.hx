package test;

import CompileTime.readFile;
import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Slash and b - Test 1", {
				final ip = parseInput( readFile( "test/test_01.txt" ));
				Main.process( ip.quarterSize, ip.pattern ).should.be( parseResult( readFile( "test/result_01.txt" )) );
			});
			it( "Both slashes and b - Test 2", {
				final ip = parseInput( readFile( "test/test_02.txt" ));
				Main.process( ip.quarterSize, ip.pattern ).should.be( parseResult( readFile( "test/result_02.txt" )) );
			});
			it( "Slash and d - Test 3", {
				final ip = parseInput( readFile( "test/test_03.txt" ));
				Main.process( ip.quarterSize, ip.pattern ).should.be( parseResult( readFile( "test/result_03.txt" )) );
			});
			it( "Slashes and d - Test 4", {
				final ip = parseInput( readFile( "test/test_04.txt" ));
				Main.process( ip.quarterSize, ip.pattern ).should.be( parseResult( readFile( "test/result_04.txt" )) );
			});
			it( "Slashes and p -Test 5", {
				final ip = parseInput( readFile( "test/test_05.txt" ));
				Main.process( ip.quarterSize, ip.pattern ).should.be( parseResult( readFile( "test/result_05.txt" )) );
			});
			it( "Slashes and q - Test 6", {
				final ip = parseInput( readFile( "test/test_06.txt" ));
				Main.process( ip.quarterSize, ip.pattern ).should.be( parseResult( readFile( "test/result_06.txt" )) );
			});
			it( "Letter combos b d - Test 7", {
				final ip = parseInput( readFile( "test/test_07.txt" ));
				Main.process( ip.quarterSize, ip.pattern ).should.be( parseResult( readFile( "test/result_07.txt" )) );
			});
			it( "Letter combos d p - Test 8", {
				final ip = parseInput( readFile( "test/test_08.txt" ));
				Main.process( ip.quarterSize, ip.pattern ).should.be( parseResult( readFile( "test/result_08.txt" )) );
			});
			it( "Letter combos p q Test 9", {
				final ip = parseInput( readFile( "test/test_09.txt" ));
				Main.process( ip.quarterSize, ip.pattern ).should.be( parseResult( readFile( "test/result_09.txt" )) );
			});
			it( "Letter combos b q - Test 10", {
				final ip = parseInput( readFile( "test/test_10.txt" ));
				Main.process( ip.quarterSize, ip.pattern ).should.be( parseResult( readFile( "test/result_10.txt" )) );
			});
			it( "Multiple Letters > 2 - Test 11", {
				final ip = parseInput( readFile( "test/test_11.txt" ));
				Main.process( ip.quarterSize, ip.pattern ).should.be( parseResult( readFile( "test/result_11.txt" )) );
			});
			it( "Extra characters - Test 12", {
				final ip = parseInput( readFile( "test/test_12.txt" ));
				Main.process( ip.quarterSize, ip.pattern ).should.be( parseResult( readFile( "test/result_12.txt" )) );
			});
			it( "Test 13", {
				final ip = parseInput( readFile( "test/test_13.txt" ));
				Main.process( ip.quarterSize, ip.pattern ).should.be( parseResult( readFile( "test/result_13.txt" )) );
			});
			it( "Test 14", {
				final ip = parseInput( readFile( "test/test_14.txt" ));
				Main.process( ip.quarterSize, ip.pattern ).should.be( parseResult( readFile( "test/result_14.txt" )) );
			});
			it( "Test 15", {
				final ip = parseInput( readFile( "test/test_15.txt" ));
				Main.process( ip.quarterSize, ip.pattern ).should.be( parseResult( readFile( "test/result_15.txt" )) );
			});
			it( "Test 16", {
				final ip = parseInput( readFile( "test/test_16.txt" ));
				Main.process( ip.quarterSize, ip.pattern ).should.be( parseResult( readFile( "test/result_16.txt" )) );
			});
			it( "Test 17", {
				final ip = parseInput( readFile( "test/test_17.txt" ));
				Main.process( ip.quarterSize, ip.pattern ).should.be( parseResult( readFile( "test/result_17.txt" )) );
			});
			it( "Test 18", {
				final ip = parseInput( readFile( "test/test_18.txt" ));
				Main.process( ip.quarterSize, ip.pattern ).should.be( parseResult( readFile( "test/result_18.txt" )) );
			});
			it( "Test 19", {
				final ip = parseInput( readFile( "test/test_19.txt" ));
				Main.process( ip.quarterSize, ip.pattern ).should.be( parseResult( readFile( "test/result_19.txt" )) );
			});
			it( "Test 20", {
				final ip = parseInput( readFile( "test/test_20.txt" ));
				Main.process( ip.quarterSize, ip.pattern ).should.be( parseResult( readFile( "test/result_20.txt" )) );
			});
			it( "Test 21", {
				final ip = parseInput( readFile( "test/test_21.txt" ));
				Main.process( ip.quarterSize, ip.pattern ).should.be( parseResult( readFile( "test/result_21.txt" )) );
			});
			it( "Test 22", {
				final ip = parseInput( readFile( "test/test_22.txt" ));
				Main.process( ip.quarterSize, ip.pattern ).should.be( parseResult( readFile( "test/result_22.txt" )) );
			});
			it( "Test 23", {
				final ip = parseInput( readFile( "test/test_23.txt" ));
				Main.process( ip.quarterSize, ip.pattern ).should.be( parseResult( readFile( "test/result_23.txt" )) );
			});
			it( "Test 24", {
				final ip = parseInput( readFile( "test/test_24.txt" ));
				Main.process( ip.quarterSize, ip.pattern ).should.be( parseResult( readFile( "test/result_24.txt" )) );
			});
			it( "Test 25", {
				final ip = parseInput( readFile( "test/test_25.txt" ));
				Main.process( ip.quarterSize, ip.pattern ).should.be( parseResult( readFile( "test/result_25.txt" )) );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );

		return { quarterSize: parseInt( lines[0] ), pattern: lines.slice( 1 ).map( s -> s.split( "" )) }
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}
}
