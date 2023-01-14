package test;

using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Example", {
				Main.process( "<<>>>" ).should.be( 4 );
			});
			it( "Short string", {
				Main.process( "<>" ).should.be( 2 );
			});
			it( "Not good", {
				Main.process( "><<>>" ).should.be( 0 );
			});
			it( "Well formatted", {
				Main.process( "<<<<>>><<<>><<><>>>>" ).should.be( 20 );
			});
			it( "Long string", {
				Main.process( "<><><><<<<>>>>>>><<<<>>>><><><>><<<<>>>><>>><><<<<>>>><><><>><<<><<<<>>>><><><>><<<><><><><><<<<>>>>" )
				.should.be( 14 );
			});
		});
	}
}
