package test;

import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Single Digits", Main.process( "00:01:02:3" ).should.be( singleDigitsResult ));
			it( "Double Digits", Main.process( "06:11:12:9" ).should.be( doubleDigitsResult ));
			it( "Tunic - Any% Unrestricted (21:42)", Main.process( "00:21:42:4" ).should.be( tunicResult ));
			it( "Donkey Kong 64 - No Levels Early (02:04:09)", Main.process( "02:04:08:9" ).should.be( donkeyKong64Result ));
		});
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final singleDigitsResult = parseResult(
		"|_____|_____|_____|_____|_____|_____|
		|_____|_____|_____|_____|_____|_____|
		|_____|_____|_____|_____|#####|#####|
		|_____|_____|#####|_____|_____|#####|" );
	
	final doubleDigitsResult = parseResult(
		"|_____|_____|_____|_____|_____|#####|
		|#####|_____|_____|_____|_____|_____|
		|#####|_____|_____|_____|#####|_____|
		|_____|#####|#####|#####|_____|#####|" );
	
	final tunicResult = parseResult(
		"|_____|_____|_____|_____|_____|_____|
		|_____|_____|_____|#####|_____|#####|
		|_____|#####|_____|_____|#####|_____|
		|_____|_____|#####|_____|_____|_____|" );
	
	final donkeyKong64Result = parseResult(
		"|_____|_____|_____|_____|#####|#####|
		|_____|_____|#####|_____|_____|_____|
		|#####|_____|_____|_____|_____|_____|
		|_____|_____|_____|_____|_____|#####|" );
}
