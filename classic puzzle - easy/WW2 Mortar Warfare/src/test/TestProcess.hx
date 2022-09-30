package test;

import Std.parseInt;

using buddy.Should;
using StringTools;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Easy Calculation", {
				Main.process( "-+500+--" ).should.be( easyCalculation );
			});
			it( "More Precise", {
				Main.process( "+777+--" ).should.be( morePrecise );
			});
			it( "Too Far", {
				Main.process( "+1850+" ).should.be( "OUT OF RANGE" );
			});
			it( "Too Close", {
				Main.process( "--+300+-" ).should.be( "OUT OF RANGE" );
			});
		});
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final easyCalculation = parseResult(
	"84.3 degrees
	32.1 seconds" );

	final morePrecise = parseResult(
	"81.1 degrees
	31.9 seconds" );
}
