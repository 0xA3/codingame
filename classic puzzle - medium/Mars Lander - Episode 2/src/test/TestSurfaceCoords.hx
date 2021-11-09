package test;

import sim.data.Position;
import sim.data.SurfaceCoords;

using Lambda;
using StringTools;
using buddy.Should;

@:access(sim.data.SurfaceCoords)
class TestSurfaceCoords extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test Constructor", {
			it( "Test Constructor 1", {
				final positions = [new Position( 0, 0), new Position( 1000, 0 )];
				final s = new SurfaceCoords( positions );
				s.totalLength.should.be( 1000 );
				s.landIndex.should.be( 0 );
				s.landX1.should.be( 0 );
				s.landX2.should.be( 1000 );
				s.landY.should.be( 0 );
				s.lengthFractions.length.should.be( 1 );
				s.lengthFractions[0].should.be( 1.0 );
			});
			it( "Test Constructor 2", {
				final positions = [new Position( 0, 500), new Position( 0, 0), new Position( 1000, 0 ), new Position( 1000, 500 ) ];
				final s = new SurfaceCoords( positions );
				s.totalLength.should.be( 2000 );
				s.landIndex.should.be( 1 );
				s.landX1.should.be( 0 );
				s.landX2.should.be( 1000 );
				s.landY.should.be( 0 );
				s.lengthFractions.length.should.be( 3 );
				s.lengthFractions[0].should.be( 0.25 );
			});
		});
		
		describe( "Test getOffsetFraction", {
			it( "Test Total Left", {
				final positions = [new Position( 0, 0), new Position( 500, 0), new Position( 1500, 0 ), new Position( 2000, 0 )];
				final s = new SurfaceCoords( positions );
				s.getOffsetFraction( 0, 0 ).should.be( 0.75 );
			});
			it( "Test 50% Left", {
				final positions = [new Position( 0, 0), new Position( 500, 0), new Position( 1500, 0 ), new Position( 2000, 0 )];
				final s = new SurfaceCoords( positions );
				s.getOffsetFraction( 0, 0.5 ).should.be( 0.875 );
			});
			it( "Test Total Right", {
				final positions = [new Position( 0, 0), new Position( 500, 0), new Position( 1500, 0 ), new Position( 2000, 0 )];
				final s = new SurfaceCoords( positions );
				s.getOffsetFraction( 2, 1 ).should.be( 0.75 );
			});
			it( "Test 50% Right", {
				final positions = [new Position( 0, 0), new Position( 500, 0), new Position( 1500, 0 ), new Position( 2000, 0 )];
				final s = new SurfaceCoords( positions );
				s.getOffsetFraction( 2, 0.5 ).should.be( 0.875 );
			});
		});
		
		describe( "Test getHitFraction", {
			it( "Test landing area left", {
				final positions = [new Position( 0, 0), new Position( 500, 0), new Position( 1500, 0 ), new Position( 2000, 0 )];
				final s = new SurfaceCoords( positions );
				s.getHitFraction( 500, 0 ).should.be( 1.0 );
			});
			it( "Test landing area center", {
				final positions = [new Position( 0, 0), new Position( 500, 0), new Position( 1500, 0 ), new Position( 2000, 0 )];
				final s = new SurfaceCoords( positions );
				s.getHitFraction( 1000, 0 ).should.be( 1.0 );
			});
			it( "Test landing area right", {
				final positions = [new Position( 0, 0), new Position( 500, 0), new Position( 1500, 0 ), new Position( 2000, 0 )];
				final s = new SurfaceCoords( positions );
				s.getHitFraction( 1500, 0 ).should.be( 1.0 );
			});
			it( "Test above landing area", {
				final positions = [new Position( 0, 0), new Position( 500, 0), new Position( 1500, 0 ), new Position( 2000, 0 )];
				final s = new SurfaceCoords( positions );
				s.getHitFraction( 1500, 100 ).should.be( 1 - ( 100 / 2000 ));
			});
			it( "Test left of screen", {
				final positions = [new Position( 0, 0), new Position( 500, 0), new Position( 1500, 0 ), new Position( 2000, 0 )];
				final s = new SurfaceCoords( positions );
				s.getHitFraction( 0, 0 ).should.be( 1 - ( 500 / 2000 ));
			});
			it( "Test right of screen", {
				final positions = [new Position( 0, 0), new Position( 500, 0), new Position( 1500, 0 ), new Position( 2000, 0 )];
				final s = new SurfaceCoords( positions );
				s.getHitFraction( 2000, 0 ).should.be( 1 - ( 500 / 2000 ));
			});
			it( "Test diagonal", {
				final positions = [new Position( 0, 0), new Position( 500, 0), new Position( 1500, 0 ), new Position( 2000, 0 )];
				final s = new SurfaceCoords( positions );
				s.getHitFraction( 0, 800 ).should.beCloseTo( 1 - ( Math.sqrt( 500 * 500 + 800 * 800 ) / 2000 ));
			});
		});
	}
}

