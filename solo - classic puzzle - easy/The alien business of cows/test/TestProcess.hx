package test;

import CompileTime.readFile;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "one of test one", Main.process( oneOfTestOne ).should.be( oneOfTestOneResult ) );
			
			it( "United Steak of America", Main.process( parseInput( readFile( "test/test_01.txt" ))).should.be( parseResult( readFile( "test/result_01.txt" ))) );
			it( "Free Tacow !", Main.process( parseInput( readFile( "test/test_02.txt" ))).should.be( parseResult( readFile( "test/result_02.txt" ))) );
			it( "Is that a Mowse ?", Main.process( parseInput( readFile( "test/test_03.txt" ))).should.be( parseResult( readFile( "test/result_03.txt" ))) );
			it( "Those missions are stupid", Main.process( parseInput( readFile( "test/test_04.txt" ))).should.be( parseResult( readFile( "test/result_04.txt" ))) );
			it( "Union of Steak Amateurs", Main.process( parseInput( readFile( "test/test_05.txt" ))).should.be( parseResult( readFile( "test/result_05.txt" ))) );
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
	
		return lines.slice( 1 );
	}

	static function parseResult( input:String ) {
		return input.replace( "\r", "" );
	}

	final oneOfTestOne = parseInput(
	"1
	Boadwine Farms Inc (South Dakota, USA) 43°44'41.7\"N 96°49'37.4\"W 496" );

	final oneOfTestOneResult = parseResult(
	"Boadwine Farms Inc (South Dakota, USA): possible. Send a L4nd MoWer to bring back 8 cows." );
}
