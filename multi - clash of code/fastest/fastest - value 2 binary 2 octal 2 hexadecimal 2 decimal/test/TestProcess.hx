package test;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test Process", {
			it( "1001", { Main.process( 1001 ).should.be( 3 ); });
			it( "54321", { Main.process( 54321 ).should.be( 212 ); });
			it( "777777", { Main.process( 777777 ).should.be( 3038 ); });
			it( "123456789", { Main.process( 123456789 ).should.be( 482253 ); });
			it( "888888444444", { Main.process( 888888444444 ).should.be( 3472220486 ); });
			it( "100000000000", { Main.process( 100000000000 ).should.be( 390625000 ); });
		});
	}
}

