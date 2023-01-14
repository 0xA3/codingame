package test;

import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			
			it( "Tree4", {
				final ip = tree4;
				Main.process( ip.size, ip.decorator ).should.be( tree4Result );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final size = parseInt( lines[0] );
		final decorator = lines[1];

		return { size: size, decorator: decorator }
	}

	static function parseResult( s:String ) return s.replace( "\t", "" ).replace( "\r", "" );

	final tree4 = parseInput(
	"4
	*" );
	
	final tree4Result = parseResult(
	"   *
	  * *
	 * * *
	* * * *
	   |" );
}
