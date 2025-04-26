package test;

using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "/$ADD/", Main.process( "/$+-^/" ).should.be( 3 ));
			it( "//SUB/", Main.process( "//+^+-$/" ).should.be( -5 ));
			it( "/$ADD/ /**MULN+1/", Main.process( "/$$//***/" ).should.be( 2 ));
			it( "//SUB/ /**MULN+1/", Main.process( "//..//****/" ).should.be( -6 ));
			it( "/$ADD/ /*/MUL-N/", Main.process( "/$$$$//*/**/" ).should.be( -6 ));
			it( "//SUB/ /*/MUL-N/", Main.process( "//**$//*/**/" ).should.be( 6 ));
			it( "$ADDINSTCOUNT$", Main.process( "$/$$$$///./$" ).should.be( 4 ));
			it( "/*$NOP", Main.process( "/$$//*$" ).should.be( 1 ));
			it( "$ADDINSTCOUNT$ /*$NOP", Main.process( "$/*$/*$/*$$" ).should.be( 3 ));
			it( "$UNEVENADDINSTCOUNT", Main.process( "/$$/$/*$//$$/" ).should.be( -1 ));
			it( "$EMPTY$", Main.process( "$$/*$" ).should.be( 0 ));
			it( "$MUL$TI$PLE$", Main.process( "$/*$/*$$/*/*//*$$/*$$" ).should.be( -1 ));
			it( "/$FINALTEST/", Main.process( "/*$$/$$$$//*/**$//*$$/***/$/*/*/" ).should.be( 12 ));
		});
	}
}
