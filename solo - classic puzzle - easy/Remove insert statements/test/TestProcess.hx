package test;

import CompileTime.readFile;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "1-1) simple insert statement", Main.process( parseInput( readFile( "test/test_01.sql")) ).should.be( parseResult( readFile( "test/result_01.sql" ))));
			it( "2-1) simple commented statement", Main.process( parseInput( readFile( "test/test_02.sql")) ).should.be( parseResult( readFile( "test/result_02.sql" ))));
			it( "3-1) insert + comment", Main.process( parseInput( readFile( "test/test_03.sql")) ).should.be( parseResult( readFile( "test/result_03.sql" ))));
			it( "4-1) with function", Main.process( parseInput( readFile( "test/test_04.sql")) ).should.be( parseResult( readFile( "test/result_04.sql" ))));
			it( "5-1) many insert statements", Main.process( parseInput( readFile( "test/test_05.sql")) ).should.be( parseResult( readFile( "test/result_05.sql" ))));
			it( "6-1) functions + inserts", Main.process( parseInput( readFile( "test/test_06.sql")) ).should.be( parseResult( readFile( "test/result_06.sql" ))));
			it( "7-1) multi-line INSERT instructions", Main.process( parseInput( readFile( "test/test_07.sql")) ).should.be( parseResult( readFile( "test/result_07.sql" ))));
			it( "8-1) many insert on same line", Main.process( parseInput( readFile( "test/test_08.sql")) ).should.be( parseResult( readFile( "test/result_08.sql" ))));
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\r", "" ).split( "\n" );
		return lines.slice( 1 ).join( "\n" );
	}

	static function parseResult( input:String ) {
		return input.replace( "\r", "" );
	}


}
