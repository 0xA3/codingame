package test;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test Process", {
			it( "cab 6", { Main.process( "cab", 6 ).should.be( "ca" ); });
			it( "abc 1", { Main.process( "abc", 1 ).should.be( "" ); });
			it( "zerg 10", { Main.process( "zerg", 10 ).should.be( "zg" ); });
			it( "clash 30", { Main.process( "clash", 32 ).should.be( "clash" ); });
			it( "packers 77", { Main.process( "packers", 77 ).should.be( "ckes" ); });
		});
	}
}

