package test;

using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Simple", Main.process( 4, 2 ).should.be( 3 ));
			it( "Higher Score", Main.process( 55, 2 ).should.be( 12 ));
			it( "More Darts", Main.process( 60, 3 ).should.be( 1398 ));
			it( "Max Score", Main.process( 170, 3 ).should.be( 1 ));
			it( "No Darts", Main.process( 170, 0 ).should.be( 0 ));
			it( "Unorthodox Darts", Main.process( 20, 4 ).should.be( 2600 ));
			it( "Unorthodox Darts 2", Main.process( 15, 5 ).should.be( 3905 ));
		});
	}
}
