package test;

using buddy.Should;
using StringTools;

@:access(Main)
class Tests extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "132", { Main.process( [1, 3, 2] ).should.be( "123" ); });
			it( "005", { Main.process( [0, 0, 5] ).should.be( "500" ); });
		});
	}
}
