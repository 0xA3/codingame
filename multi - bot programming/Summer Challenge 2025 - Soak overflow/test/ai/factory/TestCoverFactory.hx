package test.ai.factory;

import ai.factory.CoverFactory;
import xa3.math.Pos;

using StringTools;
using buddy.Should;

@:access( ai.factory.CoverFactory )
class TestCoverFactory extends buddy.BuddySuite {

	public function new() {
		
		describe( "Test getOrthogonalNeighborPositions", {
			it( "position on side should get one neighbor", {
				final factory = oneLine;
				final neighbors = oneLine.getOrthogonalNeighborPositions( factory.positions[0][0] );
				neighbors.length.should.be( 1 );
			});
			it( "position in middle should get two neighbors", {
				final factory = oneLine;
				final neighbors = factory.getOrthogonalNeighborPositions( factory.positions[0][1] );
				neighbors.length.should.be( 2 );
			});
		});
		
		describe( "Test getFreeNeighborPositions", {
			it( "position next to box should get no neighbors", {
				final factory = oneBox;
				final neighbors = factory.getFreeNeighborPositions( factory.positions[0][0] );
				neighbors.length.should.be( 0 );
			});
			it( "position on the right should get two neighbors", {
				final factory = oneBox;
				final neighbors = factory.getFreeNeighborPositions( factory.positions[0][3] );
				neighbors.length.should.be( 2 );
			});
		});
		
		describe( "Test createDamageReducedPositions", {
			@include it( "position on empty line shoud get tow cover positions", {
				final factory = oneBox;
				final positions = factory.positions;
				final damageReducedPositions = factory.createDamageReducedPositions( positions[0][0], factory.getBoxPositions(), factory.tiles );

				damageReducedPositions[positions[0][3]].should.be( 0.75 );
				damageReducedPositions[positions[0][4]].should.be( 0.75 );
			});
		});
	}

	static function createFactory( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final height = lines.length;
		final width = lines[0].length;

		final positions = [];
		final tiles:Map<Pos, Int> = [];
		for( y in 0...lines.length ) {
			positions.push( [] );
			final row = lines[y].split( "" );
			for( x in 0...row.length ) {
				final pos = new Pos( x, y );
				positions[y][x] = pos;
				final cell = row[x];
				final value = cell == "." ? 0 : Std.parseInt( cell );
				tiles.set( pos, value );
			}

		}

		return new CoverFactory( width, height, positions, tiles );
	}
	
	final oneLine = createFactory(
		"...."
	);
	
	final oneBox = createFactory(
		".1..."
	);
	

	
}