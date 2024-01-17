package test;

import CompileTime.readFile;
import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Test 1", {
				final ip = parseInput( readFile( "test/test_01.txt" ));
				Main.process( ip.sideSize, ip.rows ).should.be( parseResult( readFile( "test/result_01.txt" )) );
			});
			it( "Test 2", {
				final ip = parseInput( readFile( "test/test_02.txt" ));
				Main.process( ip.sideSize, ip.rows ).should.be( parseResult( readFile( "test/result_02.txt" )) );
			});
			it( "Test 3", {
				final ip = parseInput( readFile( "test/test_03.txt" ));
				Main.process( ip.sideSize, ip.rows ).should.be( parseResult( readFile( "test/result_03.txt" )) );
			});
			it( "Test 4", {
				final ip = parseInput( readFile( "test/test_04.txt" ));
				Main.process( ip.sideSize, ip.rows ).should.be( parseResult( readFile( "test/result_04.txt" )) );
			});
			it( "Test 5", {
				final ip = parseInput( readFile( "test/test_05.txt" ));
				Main.process( ip.sideSize, ip.rows ).should.be( parseResult( readFile( "test/result_05.txt" )) );
			});
			it( "Test 6", {
				final ip = parseInput( readFile( "test/test_06.txt" ));
				Main.process( ip.sideSize, ip.rows ).should.be( parseResult( readFile( "test/result_06.txt" )) );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );

		final sideSize = parseInt( lines[0] );
		final rows = lines.slice( 1 );
		
		return { sideSize: sideSize, rows: rows }
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}
}
