package test.sim;

import sim.Simulator;

using Lambda;
using StringTools;
using buddy.Should;

@:access(sim.Simulator)
class TestMoveMotorbike extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test moveMotorbike horizontal", {
			it( "speed 1", {
				final simulator = new Simulator( 1, 1, [parseLane( ".." )] );
				final state = simulator.moveMotorbike( 0, 0, 1, 0 );
				state.x.should.be( 1 );
				state.y.should.be( 0 );
				state.a.should.be( true );
			});
			it( "speed 1 hole", {
				final simulator = new Simulator( 1, 1, [parseLane( ".0" )] );
				final state = simulator.moveMotorbike( 0, 0, 1, 0 );
				state.x.should.be( 1 );
				state.y.should.be( 0 );
				state.a.should.be( false );
			});
			it( "speed 2", {
				final simulator = new Simulator( 1, 1, [parseLane( "..." )] );
				final state = simulator.moveMotorbike( 0, 0, 2, 0 );
				state.x.should.be( 2 );
				state.y.should.be( 0 );
				state.a.should.be( true );
			});
			it( "speed 2 hole at 1", {
				final simulator = new Simulator( 1, 1, [parseLane( ".0." )] );
				final state = simulator.moveMotorbike( 0, 0, 2, 0 );
				state.x.should.be( 1 );
				state.y.should.be( 0 );
				state.a.should.be( false );
			});
		});
			
		describe( "Test moveMotorbike up", {
			it( "speed 1", {
				final simulator = new Simulator( 1, 1, parseLanes( ["..", ".."] ));
				final state = simulator.moveMotorbike( 0, 1, 1, -1 );
				state.x.should.be( 1 );
				state.y.should.be( 0 );
				state.a.should.be( true );
			});
			it( "speed 1 hole", {
				final simulator = new Simulator( 1, 1, parseLanes( [".0", ".."] ));
				final state = simulator.moveMotorbike( 0, 1, 1, -1 );
				state.x.should.be( 1 );
				state.y.should.be( 0 );
				state.a.should.be( false );
			});
			it( "speed 1 avoid hole", {
				final simulator = new Simulator( 1, 1, parseLanes( ["..", ".0"] ));
				final state = simulator.moveMotorbike( 0, 1, 1, -1 );
				state.x.should.be( 1 );
				state.y.should.be( 0 );
				state.a.should.be( true );
			});
			it( "speed 2 hole 1", {
				final simulator = new Simulator( 1, 1, parseLanes( [".0.", "..."] ));
				final state = simulator.moveMotorbike( 0, 1, 2, -1 );
				state.x.should.be( 1 );
				state.y.should.be( 0 );
				state.a.should.be( false );
			});
			it( "speed 2 hole 2", {
				final simulator = new Simulator( 1, 1, parseLanes( ["...", ".0."] ));
				final state = simulator.moveMotorbike( 0, 1, 2, -1 );
				state.x.should.be( 1 );
				state.y.should.be( 0 );
				state.a.should.be( false );
			});
			it( "speed 2 avoid hole", {
				final simulator = new Simulator( 1, 1, parseLanes( ["...", "..0"] ));
				final state = simulator.moveMotorbike( 0, 1, 2, -1 );
				state.x.should.be( 2 );
				state.y.should.be( 0 );
				state.a.should.be( true );
			});
			it( "speed 3 hole 1", {
				final simulator = new Simulator( 1, 1, parseLanes( [".0..", "...."] ));
				final state = simulator.moveMotorbike( 0, 1, 3, -1 );
				state.x.should.be( 1 );
				state.y.should.be( 0 );
				state.a.should.be( false );
			});
			it( "speed 3 hole 2", {
				final simulator = new Simulator( 1, 1, parseLanes( ["..0.", "...."] ));
				final state = simulator.moveMotorbike( 0, 1, 3, -1 );
				state.x.should.be( 2 );
				state.y.should.be( 0 );
				state.a.should.be( false );
			});
			it( "speed 3 hole 3", {
				final simulator = new Simulator( 1, 1, parseLanes( ["...0", "...."] ));
				final state = simulator.moveMotorbike( 0, 1, 3, -1 );
				state.x.should.be( 3 );
				state.y.should.be( 0 );
				state.a.should.be( false );
			});
			it( "speed 3 hole 4", {
				final simulator = new Simulator( 1, 1, parseLanes( ["....", ".0.."] ));
				final state = simulator.moveMotorbike( 0, 1, 3, -1 );
				state.x.should.be( 1 );
				state.y.should.be( 0 );
				state.a.should.be( false );
			});
			it( "speed 3 hole 5", {
				final simulator = new Simulator( 1, 1, parseLanes( ["....", "..0."] ));
				final state = simulator.moveMotorbike( 0, 1, 3, -1 );
				state.x.should.be( 2 );
				state.y.should.be( 0 );
				state.a.should.be( false );
			});
			it( "speed 3 avoid hole", {
				final simulator = new Simulator( 1, 1, parseLanes( ["....", "...0"] ));
				final state = simulator.moveMotorbike( 0, 1, 3, -1 );
				state.x.should.be( 3 );
				state.y.should.be( 0 );
				state.a.should.be( true );
			});
		});
		describe( "Test moveMotorbike down", {
			it( "speed 1", {
				final simulator = new Simulator( 1, 1, parseLanes( ["..", ".."] ));
				final state = simulator.moveMotorbike( 0, 0, 1, 1 );
				state.x.should.be( 1 );
				state.y.should.be( 1 );
				state.a.should.be( true );
			});
			it( "speed 1 hole", {
				final simulator = new Simulator( 1, 1, parseLanes( ["..", ".0"] ));
				final state = simulator.moveMotorbike( 0, 0, 1, 1 );
				state.x.should.be( 1 );
				state.y.should.be( 1 );
				state.a.should.be( false );
			});
			it( "speed 1 avoid hole", {
				final simulator = new Simulator( 1, 1, parseLanes( [".0", ".."] ));
				final state = simulator.moveMotorbike( 0, 0, 1, 1 );
				state.x.should.be( 1 );
				state.y.should.be( 1 );
				state.a.should.be( true );
			});
		});
	}

	function parseLanes( a:Array<String> ) return a.map( s -> parseLane( s ));
	function parseLane( s:String ) return s.split( "" ).map( s -> s == "." );

}

