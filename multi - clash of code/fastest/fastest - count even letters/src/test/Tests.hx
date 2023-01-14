package test;

using StringTools;
using buddy.Should;

@:access(Main)
class Tests extends buddy.BuddySuite{

	public function new() {

		describe( "Test count1", {
			it( "ab", { Main.count1( "ab".split( "" )).should.be( 1 ); });
			it( "a b", { Main.count1( "a b".split( "" )).should.be( 1 ); });
		});

		describe( "Test count2", {
			it( "a", { Main.count2( "a".split( "" )).should.be( 0 ); });
			it( "ab", { Main.count2( "ab".split( "" )).should.be( 1 ); });
			it( "a b", { Main.count2( "a b".split( "" )).should.be( 1 ); });
			it( ".$%&/()!", { Main.count2( ".$%&/()!".split( "" )).should.be( 0 ); });
		});
	}
}
