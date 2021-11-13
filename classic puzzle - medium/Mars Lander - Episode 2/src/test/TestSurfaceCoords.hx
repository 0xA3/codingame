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
				s.landX1.should.be( 50 );
				s.landX2.should.be( 950 );
				s.landY.should.be( 0 );
				s.distanceFractions.length.should.be( 1 );
				s.distanceFractions[0].should.be( 0 );
			});
			it( "Test Constructor 2", {
				final positions = [new Position( 0, 500), new Position( 0, 0), new Position( 1000, 0 ), new Position( 1000, 500 ) ];
				final s = new SurfaceCoords( positions );
				s.totalLength.should.be( 2000 );
				s.landIndex.should.be( 1 );
				s.landX1.should.be( 50 );
				s.landX2.should.be( 950 );
				s.landY.should.be( 0 );
				s.distanceFractions.length.should.be( 3 );
				s.distanceFractions[0].should.be( 0.25 );
			});
		});
		
		@exclude describe( "Test getHitFraction", {
			it( "Test landing area left", {
				final positions = [new Position( 0, 0), new Position( 500, 0), new Position( 1500, 0 ), new Position( 2000, 0 )];
				final s = new SurfaceCoords( positions );
				s.getHitFraction( 550, 0 ).should.be( 1.0 );
			});
			it( "Test landing area center", {
				final positions = [new Position( 0, 0), new Position( 500, 0), new Position( 1500, 0 ), new Position( 2000, 0 )];
				final s = new SurfaceCoords( positions );
				s.getHitFraction( 1000, 0 ).should.be( 1.0 );
			});
			it( "Test landing area right", {
				final positions = [new Position( 0, 0), new Position( 500, 0), new Position( 1500, 0 ), new Position( 2000, 0 )];
				final s = new SurfaceCoords( positions );
				s.getHitFraction( 1450, 0 ).should.be( 1.0 );
			});
			it( "Test above landing area", {
				final positions = [new Position( 0, 0), new Position( 500, 0), new Position( 1500, 0 ), new Position( 2000, 0 )];
				final s = new SurfaceCoords( positions );
				s.getHitFraction( 1450, 100 ).should.be( 1 - ( 100 / 2000 ));
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

