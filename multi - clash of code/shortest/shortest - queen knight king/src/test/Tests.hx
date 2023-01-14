package test;

using buddy.Should;
using StringTools;

@:access(Main)
class Tests extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "65 16:9", { Main.process( 65, "16:9" ).should.be( "56.65 x 31.87" ); });
		});
	}
}
