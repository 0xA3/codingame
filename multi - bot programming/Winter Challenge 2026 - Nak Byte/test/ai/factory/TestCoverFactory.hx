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
				final factory = boxLeft;
				final neighbors = factory.getFreeNeighborPositions( factory.positions[0][0] );
				neighbors.length.should.be( 0 );
			});
			it( "position on the right should get one neighbor", {
				final factory = boxLeft;
				final neighbors = factory.getFreeNeighborPositions( factory.positions[0][2] );
				neighbors.length.should.be( 1 );
			});
		});
		
		describe( "Test createCoverPositionsForBoxNeighbor", {
			it( "on Box left", {
				final factory = boxLeft;
				final positions = factory.positions;
				final damageReducedPositions = factory.createCoverPositionsForBoxNeighbor( positions[0][0], factory.getBoxPositions() );

				damageReducedPositions[positions[0][3]].should.be( 0.5 );
			});
			it( "one Box right", {
				final factory = boxRight;
				final positions = factory.positions;
				final damageReducedPositions = factory.createCoverPositionsForBoxNeighbor( positions[0][3], factory.getBoxPositions() );

				damageReducedPositions[positions[0][0]].should.be( 0.5 );
			});
			it( "one Box top", {
				final factory = boxTop;
				final positions = factory.positions;
				final damageReducedPositions = factory.createCoverPositionsForBoxNeighbor( positions[0][0], factory.getBoxPositions() );

				damageReducedPositions[positions[3][0]].should.be( 0.5 );
			});
			it( "one Box bottom", {
				final factory = boxBottom;
				final positions = factory.positions;
				final damageReducedPositions = factory.createCoverPositionsForBoxNeighbor( positions[3][0], factory.getBoxPositions() );

				damageReducedPositions[positions[0][0]].should.be( 0.5 );
			});
			it( "one Box top left position above", {
				final factory = boxTopLeft;
				final positions = factory.positions;
				final damageReducedPositions = factory.createCoverPositionsForBoxNeighbor( positions[0][1], factory.getBoxPositions() );

				damageReducedPositions[positions[2][3]].should.be( 0.5 );
				damageReducedPositions[positions[3][0]].should.be( 0.5 );
				damageReducedPositions[positions[3][1]].should.be( 0.5 );
				damageReducedPositions[positions[3][2]].should.be( 0.5 );
				damageReducedPositions[positions[3][3]].should.be( 0.5 );
			});
			it( "one Box top left position left", {
				final factory = boxTopLeft;
				final positions = factory.positions;
				final damageReducedPositions = factory.createCoverPositionsForBoxNeighbor( positions[1][0], factory.getBoxPositions() );

				damageReducedPositions[positions[0][3]].should.be( 0.5 );
				damageReducedPositions[positions[1][3]].should.be( 0.5 );
				damageReducedPositions[positions[2][3]].should.be( 0.5 );
				damageReducedPositions[positions[3][2]].should.be( 0.5 );
				damageReducedPositions[positions[3][3]].should.be( 0.5 );
			});
			it( "two Boxes top left position left", {
				final factory = twoboxesTopLeft;
				final positions = factory.positions;
				final damageReducedPositions = factory.createCoverPositionsForBoxNeighbor( positions[1][0], factory.getBoxPositions() );

				damageReducedPositions[positions[0][3]].should.be( 0.5 );
				damageReducedPositions[positions[1][3]].should.be( 0.5 );
				damageReducedPositions[positions[2][3]].should.be( 0.5 );
				damageReducedPositions[positions[3][2]].should.be( 0.75 );
				damageReducedPositions[positions[3][3]].should.be( 0.75 );
				damageReducedPositions[positions[4][0]].should.be( 0.75 );
				damageReducedPositions[positions[4][1]].should.be( 0.75 );
				damageReducedPositions[positions[4][2]].should.be( 0.75 );
				damageReducedPositions[positions[4][3]].should.be( 0.75 );
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
	
	final boxLeft = createFactory(
		".1.."
	);
	
	final boxRight = createFactory(
		"..1."
	);
	
	final boxTop = createFactory(
		".
		1
		.
		."
	);
	
	final boxBottom = createFactory(
		".
		.
		1
		."
	);
	
	final boxTopLeft = createFactory(
		"....
		.1..
		....
		...."
	);

	final twoboxesTopLeft = createFactory(
		"....
		.1..
		2...
		....
		...."
	);

	
}