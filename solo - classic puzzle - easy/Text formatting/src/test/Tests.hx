package test;

import Main;
import Std.parseInt;

using buddy.Should;
using StringTools;
using Lambda;

@:access(Main)
class Tests extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			
			it( "One sentence without spaces", { Main.process( "one,two,three." ).should.be( "One, two, three." ); });
			it( "Two sentences", { Main.process( "one,two,three.four,five, six." ).should.be( "One, two, three. Four, five, six." ); });
			it( "Extra spaces", { Main.process( "one , two , three . four , five , six ." ).should.be( "One, two, three. Four, five, six." ); });
			it( "More errors", { Main.process( "one , TWO  ,,  three  ..  four,fivE , six ." ).should.be( "One, two, three. Four, five, six." ); });
			it( "One sentence without spaces", { Main.process( "when a father gives to his son,,, Both laugh; When a son gives to his father, , , Both cry...shakespeare" ).should.be( "When a father gives to his son, both laugh; when a son gives to his father, both cry. Shakespeare" ); });
			
		});
			
	}

}

