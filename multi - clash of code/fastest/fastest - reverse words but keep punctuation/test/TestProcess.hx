package test;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test Process", {
			it( "Hello", { Main.process( "Hello, How Are You?" ).should.be( "olleH, woH erA uoY?" ); });
			it( "Haaaaa", { Main.process( "Haaaaa, I’m a muffin" ).should.be( "aaaaaH, I’m a niffum" ); });
			it( "Why", { Main.process( "Why, w__hy__, w_h_y?" ).should.be( "yhW, __yh__w, y_h_w?" ); });
			it( "Is this you", { Main.process( "Is this you? (Yes) Hello! (Hi!)" ).should.be( "sI siht uoy? (seY) olleH! (iH!)" ); });
			it( "H3110", { Main.process( "H3110, h0w 4r3 y0u?" ).should.be( "0113H, w0h 3r4 u0y?" ); });
		});
	}
}

