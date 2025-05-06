package test;

import Std.parseInt;
import test.Readline.initReadline;
import test.Readline.readline;

using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			
			it( "Test 1", Main.process( 0, 10 ).should.be( "3141592653" ));
			it( "Test 2", Main.process( 79200, 20 ).should.be( "23071751132961904559" ));
			it( "Test 3", Main.process( 164587, 30 ).should.be( "363064633704503315526375204047" ));
			it( "Test 4", Main.process( 251666, 40 ).should.be( "7165613533509921885956010788152195599298" ));
			it( "Test 5", Main.process( 294641, 50 ).should.be( "86749705669639627505283727439791628764864557681076" ));
		});
	}
}
