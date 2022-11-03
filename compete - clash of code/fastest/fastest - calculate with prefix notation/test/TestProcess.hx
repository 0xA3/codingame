package test;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test Process", {
			it( "* - 5 6 7", { Main.process( "* - 5 6 7" ).should.be( "-7" ); });
			it( "+ 2 3", { Main.process( "+ 2 3" ).should.be( "5" ); });
			it( "+ 5 - 9 3	", { Main.process( "+ 5 - 9 3" ).should.be( "11" ); });
			it( "+ / 8 4 2", { Main.process( "+ / 8 4 2" ).should.be( "4" ); });
			it( "- 5 * 6 7", { Main.process( "- 5 * 6 7" ).should.be( "-37" ); });
			it( "+ / 16 4 / 9 3", { Main.process( "+ / 16 4 / 9 3" ).should.be( "7" ); });
			it( "- * + 1 2 3 4", { Main.process( "- * + 1 2 3 4" ).should.be( "5" ); });
			it( "* + 9 1 + 8 12", { Main.process( "* + 9 1 + 8 12" ).should.be( "200" ); });
			it( "+ 9 -1", { Main.process( "+ 9 -1" ).should.be( "8" ); });
			it( "/ 100 0", { Main.process( "/ 100 0" ).should.be( "NaN" ); });
			it( "/ * + 9 1 + 8 12 + - 9 -1 -2", { Main.process( "/ * + 9 1 + 8 12 + - 9 -1 -2" ).should.be( "25" ); });
		});
	}
}

