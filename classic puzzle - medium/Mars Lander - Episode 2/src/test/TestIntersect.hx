package test;

import simGA.data.Vec2;
import xa3.MathUtils.lineIntersect;
import xa3.MathUtils.segmentIntersect;

using Lambda;
using buddy.Should;

class TestIntersect extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test lineIntersect", {
			it( "Test lines cross", {
				final vec:Vec2 = { x: 0, y: 0 };
				final isIntersection = lineIntersect(
					100, 100,
					500, 500,
					600, 50,
					80, 600,
					vec
				);
				isIntersection.should.be( true );
				vec.x.should.beCloseTo( 332.7102803738318 );
				vec.y.should.beCloseTo( 332.7102803738318 );
			});
			it( "Test lander1", {
				final vec:Vec2 = { x: 0, y: 0 };
				final isIntersection = segmentIntersect(
					4020, 228,
					4020, 91,
					4000, 150,
					5000, 150,
					vec
				);
				isIntersection.should.be( true );
				vec.x.should.beCloseTo( 4020 );
				vec.y.should.beCloseTo( 150 );
			});
			it( "Test parallel", {
				final vec:Vec2 = { x: 0, y: 0 };
				final isIntersection = lineIntersect(
					100, 100,
					500, 100,
					100, 200,
					500, 200,
					vec
				);
				isIntersection.should.be( false );
				vec.x.should.be( 0 );
				vec.y.should.be( 0 );
			});
			it( "Test identical", {
				final vec:Vec2 = { x: 0, y: 0 };
				final isIntersection = lineIntersect(
					100, 100,
					500, 100,
					100, 100,
					500, 100,
					vec
				);
				isIntersection.should.be( false );
				vec.x.should.be( 0 );
				vec.y.should.be( 0 );
			});
		});
		
		describe( "Test segmentIntersect", {
			it( "Test lines cross", {
				final vec:Vec2 = { x: 0, y: 0 };
				final isIntersection = segmentIntersect(
					100, 100,
					500, 500,
					600, 50,
					80, 600,
					vec
				);
				isIntersection.should.be( true );
				vec.x.should.beCloseTo( 332.7102803738318 );
				vec.y.should.beCloseTo( 332.7102803738318 );
			});
			it( "Test parallel", {
				final vec:Vec2 = { x: 0, y: 0 };
				final isIntersection = segmentIntersect(
					100, 100,
					500, 100,
					100, 200,
					500, 200,
					vec
				);
				isIntersection.should.be( false );
				vec.x.should.be( 0 );
				vec.y.should.be( 0 );
			});
			it( "Test identical", {
				final vec:Vec2 = { x: 0, y: 0 };
				final isIntersection = segmentIntersect(
					100, 100,
					500, 100,
					100, 100,
					500, 100,
					vec
				);
				isIntersection.should.be( false );
				vec.x.should.be( 0 );
				vec.y.should.be( 0 );
			});
		});
		

	}
}

