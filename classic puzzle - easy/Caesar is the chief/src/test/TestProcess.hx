package test;

import Main;
import Std.parseInt;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test decode", {
			it( "Test A 0", { Main.decode( ["A".code], 0 ).should.be( "A" ); });
			it( "Test A 1", { Main.decode( ["A".code], 1 ).should.be( "B" ); });
			it( "Test Z 1", { Main.decode( ["Z".code], 1 ).should.be( "A" ); });
		});

		describe( "Test process", {
			it( "Test 1", { Main.process( "HELLO" ).should.be( "WRONG MESSAGE" ); });
			it( "Test 2", { Main.process( "CHIEF" ).should.be( "CHIEF" ); });
			it( "Test 3", { Main.process( "DIJFG JT XSPOH" ).should.be( "CHIEF IS WRONG" ); });
			it( "Test 4", { Main.process( "CBUUMF JT PWFS" ).should.be( "WRONG MESSAGE" ); });
			it( "Test 5", { Main.process( "WE ARE THE ZORGONS" ).should.be( "WRONG MESSAGE" ); });
			it( "Test 6", { Main.process( "NMFFXQ XAEF OTUQR" ).should.be( "BATTLE LOST CHIEF" ); });
			it( "Test 7", { Main.process( "HDIJFG" ).should.be( "WRONG MESSAGE" ); });
			it( "Test 8", { Main.process( "LADSXGN UE FTQ NQEF OTUQR" ).should.be( "ZORGLUB IS THE BEST CHIEF" ); });
			it( "Test 9", { Main.process( "MPOH MJGF UP UIF DIJFG" ).should.be( "LONG LIFE TO THE CHIEF" ); });
			it( "Test 10", { Main.process( "DIJFG JT DIJFG" ).should.be( "CHIEF IS CHIEF" ); });
			it( "Test 11", { Main.process( "AGD OTUQR UE FTQ NQEF" ).should.be( "OUR CHIEF IS THE BEST" ); });
			it( "Test 12", { Main.process( "ZORGLUG BRINGS MISCHIEF" ).should.be( "WRONG MESSAGE" ); });
		});
			
	}

}

