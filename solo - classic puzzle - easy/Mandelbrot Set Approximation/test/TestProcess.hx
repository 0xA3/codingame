package test;

import CompileTime.readFile;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Test 1", Main.process( 7 ).should.be( parseResult( readFile( "test/result_01.txt" ))));
			it( "Test 2", Main.process( 13 ).should.be( parseResult( readFile( "test/result_02.txt" ))));
			it( "Test 3", Main.process( 19 ).should.be( parseResult( readFile( "test/result_03.txt" ))));
			it( "Test 4", Main.process( 25 ).should.be( parseResult( readFile( "test/result_04.txt" ))));
		});
	}

	static function parseResult( input:String ) {
		return input.replace( "\r", "" );
	}
}
