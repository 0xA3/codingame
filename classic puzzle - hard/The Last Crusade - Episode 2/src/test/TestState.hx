package test;

import test.ParseInput;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestState extends buddy.BuddySuite {

	static final colLeft = 0;
	static final colCenter = 1;
	static final colRight = 2;

	static final TOP = 0;
	static final LEFT = 1;
	static final RIGHT = 2;

	public function new() {
		
		describe( "Test getNextCellLocation", {
			it( "Simple", {
				final input = simple;
				final state = new State( input.start, [], input.cells, input.locked, input.width );
				final n = state.getNextCellLocation();
				'${n.index} ${n.pos}'.should.be( '4 0' );
			});	
			
			it( "turnLeft", {
				final input = turnLeft;
				final state = new State( input.start, [], input.cells, input.locked, input.width );
				final n = state.getNextCellLocation();
				'${n.index} ${n.pos}'.should.be( '0 2' );
			});	
			
			it( "turnRight", {
				final input = turnRight;
				final state = new State( input.start, [], input.cells, input.locked, input.width );
				final n = state.getNextCellLocation();
				'${n.index} ${n.pos}'.should.be( '2 1' );
			});	
			
			it( "Tile 0", {
				final input = allTiles;
				final indy = Main.parseLocation( "1 0 TOP", input.width );
				final state = new State( indy, [], input.cells, input.locked, input.width );
				final n = state.getNextCellLocation();
				'${n.index} ${n.pos}'.should.be( '-1 -1' );
			});	
			
			it( "Tile 1", {
				final input = allTiles;
				final indy = Main.parseLocation( "1 1 TOP", input.width );
				final state = new State( indy, [], input.cells, input.locked, input.width );
				final n = state.getNextCellLocation();
				'${n.index} ${n.pos}'.should.be( '${2 * 3 + colCenter} $TOP' );
			});	
			
			it( "Tile 2", {
				final input = allTiles;
				final indy = Main.parseLocation( "1 2 LEFT", input.width );
				final state = new State( indy, [], input.cells, input.locked, input.width );
				final n = state.getNextCellLocation();
				'${n.index} ${n.pos}'.should.be( '${2 * 3 + colRight} $LEFT' );
			});	
			
			it( "Tile 3", {
				final input = allTiles;
				final indy = Main.parseLocation( "1 3 TOP", input.width );
				final state = new State( indy, [], input.cells, input.locked, input.width );
				final n = state.getNextCellLocation();
				'${n.index} ${n.pos}'.should.be( '${4 * 3 + colCenter} $TOP' );
			});	
			
			it( "Tile 4", {
				final input = allTiles;
				final indy = Main.parseLocation( "1 4 TOP", input.width );
				final state = new State( indy, [], input.cells, input.locked, input.width );
				final n = state.getNextCellLocation();
				'${n.index} ${n.pos}'.should.be( '${4 * 3 + colLeft} $RIGHT' );
			});	
			
			it( "Tile 5", {
				final input = allTiles;
				final indy = Main.parseLocation( "1 5 TOP", input.width );
				final state = new State( indy, [], input.cells, input.locked, input.width );
				final n = state.getNextCellLocation();
				'${n.index} ${n.pos}'.should.be( '${5 * 3 + colRight} $LEFT' );
			});	
			
			it( "Tile 6", {
				final input = allTiles;
				final indy = Main.parseLocation( "1 6 LEFT", input.width );
				final state = new State( indy, [], input.cells, input.locked, input.width );
				final n = state.getNextCellLocation();
				'${n.index} ${n.pos}'.should.be( '${6 * 3 + colRight} $LEFT' );
			});	
			
			it( "Tile 7", {
				final input = allTiles;
				final indy = Main.parseLocation( "1 7 TOP", input.width );
				final state = new State( indy, [], input.cells, input.locked, input.width );
				final n = state.getNextCellLocation();
				'${n.index} ${n.pos}'.should.be( '${8 * 3 + colCenter} $TOP' );
			});	
			
			it( "Tile 8", {
				final input = allTiles;
				final indy = Main.parseLocation( "1 8 LEFT", input.width );
				final state = new State( indy, [], input.cells, input.locked, input.width );
				final n = state.getNextCellLocation();
				'${n.index} ${n.pos}'.should.be( '${9 * 3 + colCenter} $TOP' );
			});	
			
			it( "Tile 9", {
				final input = allTiles;
				final indy = Main.parseLocation( "1 9 TOP", input.width );
				final state = new State( indy, [], input.cells, input.locked, input.width );
				final n = state.getNextCellLocation();
				'${n.index} ${n.pos}'.should.be( '${10 * 3 + colCenter} $TOP' );
			});	
			
			it( "Tile 10", {
				final input = allTiles;
				final indy = Main.parseLocation( "1 10 TOP", input.width );
				final state = new State( indy, [], input.cells, input.locked, input.width );
				final n = state.getNextCellLocation();
				'${n.index} ${n.pos}'.should.be( '${10 * 3 + colLeft} $RIGHT' );
			});	
			
			it( "Tile 11", {
				final input = allTiles;
				final indy = Main.parseLocation( "1 11 TOP", input.width );
				final state = new State( indy, [], input.cells, input.locked, input.width );
				final n = state.getNextCellLocation();
				'${n.index} ${n.pos}'.should.be( '${11 * 3 + colRight} $LEFT' );
			});	
			
			it( "Tile 12", {
				final input = allTiles;
				final indy = Main.parseLocation( "1 12 RIGHT", input.width );
				final state = new State( indy, [], input.cells, input.locked, input.width );
				final n = state.getNextCellLocation();
				'${n.index} ${n.pos}'.should.be( '${13 * 3 + colCenter} $TOP' );
			});	
			
			it( "Tile 13", {
				final input = allTiles;
				final indy = Main.parseLocation( "1 13 LEFT", input.width );
				final state = new State( indy, [], input.cells, input.locked, input.width );
				final n = state.getNextCellLocation();
				'${n.index} ${n.pos}'.should.be( '${14 * 3 + colCenter} $TOP' );
			});	
			
		});
		
		describe( "Test getNextCellRotations", {
			
			it( "Rotation 1", {
				final input = rotation1;
				final state = new State( input.start, [], input.cells, input.locked, input.width );
				state.getNextCellRotations( state.getNextCellLocation())
					.join(" ").should.be( '1' );
			});

			it( "Rotation 2", {
				final input = rotation2;
				final state = new State( input.start, [], input.cells, input.locked, input.width );
				state.getNextCellRotations( state.getNextCellLocation())
					.join(" ").should.be( '3' );
			});

			it( "Rotation 3", {
				final input = rotation3;
				final state = new State( input.start, [], input.cells, input.locked, input.width );
				state.getNextCellRotations( state.getNextCellLocation())
					.join(" ").should.be( '3' );
			});

			it( "Rotation 4", {
				final input = rotation4;
				final state = new State( input.start, [], input.cells, input.locked, input.width );
				state.getNextCellRotations( state.getNextCellLocation())
					.join(" ").should.be( '4 5' );
			});

			it( "Rotation 5", {
				final input = rotation5;
				final state = new State( input.start, [], input.cells, input.locked, input.width );
				state.getNextCellRotations( state.getNextCellLocation())
					.join(" ").should.be( '5 4' );
			});

			it( "Rotation 6", {
				final input = rotation6;
				final state = new State( input.start, [], input.cells, input.locked, input.width );
				state.getNextCellRotations( state.getNextCellLocation())
					.join(" ").should.be( '7 9' );
			});

			it( "Rotation 7", {
				final input = rotation7;
				final state = new State( input.start, [], input.cells, input.locked, input.width );
				state.getNextCellRotations( state.getNextCellLocation())
					.join(" ").should.be( '7 9' );
			});

			it( "Rotation 8", {
				final input = rotation8;
				final state = new State( input.start, [], input.cells, input.locked, input.width );
				state.getNextCellRotations( state.getNextCellLocation())
					.join(" ").should.be( '9 7' );
			});

			it( "Rotation 9", {
				final input = rotation9;
				final state = new State( input.start, [], input.cells, input.locked, input.width );
				state.getNextCellRotations( state.getNextCellLocation())
					.join(" ").should.be( '9 7' );
			});

			it( "Rotation 10", {
				final input = rotation10;
				final state = new State( input.start, [], input.cells, input.locked, input.width );
				state.getNextCellRotations( state.getNextCellLocation())
					.join(" ").should.be( '10 11' );
			});

			it( "Rotation 11", {
				final input = rotation11;
				final state = new State( input.start, [], input.cells, input.locked, input.width );
				state.getNextCellRotations( state.getNextCellLocation())
					.join(" ").should.be( '11 10' );
			});

			it( "Rotation 12", {
				final input = rotation12;
				final state = new State( input.start, [], input.cells, input.locked, input.width );
				state.getNextCellRotations( state.getNextCellLocation())
					.join(" ").should.be( '10 11' );
			});

			it( "Rotation 13", {
				final input = rotation13;
				final state = new State( input.start, [], input.cells, input.locked, input.width );
				state.getNextCellRotations( state.getNextCellLocation())
					.join(" ").should.be( '10 11' );
			});

			it( "Locked rotation 11", {
				final input = lockedRotation11;
				final state = new State( input.start, [], input.cells, input.locked, input.width );
				state.getNextCellRotations( state.getNextCellLocation())
					.join(" ").should.be( '11' );
			});

			it( "Locked rotation 13", {
				final input = lockedRotation13;
				final state = new State( input.start, [], input.cells, input.locked, input.width );
				state.getNextCellRotations( state.getNextCellLocation())
					.join(" ").should.be( '' );
			});

		});
			
	}

	final simple = parseInput(
	"3 2
	0 3 0
	0 3 0
	1
	1 0 TOP" );
	
	final turnLeft = parseInput(
	"3 1
	2 10 0
	1
	1 0 TOP" );
	
	final turnRight = parseInput(
	"3 1
	0 11 2
	1
	1 0 TOP" );
	
	final allTiles = parseInput(
	"3 15
	0 0 0
	0 1 0
	0 2 0
	0 3 0
	0 4 0
	0 5 0
	0 6 0
	0 7 0
	0 8 0
	0 9 0
	0 10 0
	0 11 0
	0 12 0
	0 13 0
	0 3 0
	1
	1 0 TOP" );
	
	final rotation1 = parseInput(
	"3 2
	0 3 0
	0 1 0
	1
	1 0 TOP" );
	
	final rotation2 = parseInput(
	"3 2
	0 3 0
	0 2 0
	1
	1 0 TOP" );
	
	final rotation3 = parseInput(
	"3 2
	0 3 0
	0 3 0
	1
	1 0 TOP" );
	
	final rotation4 = parseInput(
	"3 2
	0 3 0
	0 4 0
	1
	1 0 TOP" );
	
	final rotation5 = parseInput(
	"3 2
	0 3 0
	0 5 0
	1
	1 0 TOP" );
	
	final rotation6 = parseInput(
	"3 2
	0 3 0
	0 6 0
	1
	1 0 TOP" );
	
	final rotation7 = parseInput(
	"3 2
	0 3 0
	0 7 0
	1
	1 0 TOP" );
	
	final rotation8 = parseInput(
	"3 2
	0 3 0
	0 8 0
	1
	1 0 TOP" );
	
	final rotation9 = parseInput(
	"3 2
	0 3 0
	0 9 0
	1
	1 0 TOP" );
	
	final rotation10 = parseInput(
	"3 2
	0 3 0
	0 10 0
	1
	1 0 TOP" );
	
	final rotation11 = parseInput(
	"3 2
	0 3 0
	0 11 0
	1
	1 0 TOP" );
	
	final rotation12 = parseInput(
	"3 2
	0 3 0
	0 12 0
	1
	1 0 TOP" );
	
	final rotation13 = parseInput(
	"3 2
	0 3 0
	0 13 0
	1
	1 0 TOP" );
	
	final lockedRotation11 = parseInput(
	"3 2
	0 3 0
	0 -11 0
	1
	1 0 TOP" );
	
	final lockedRotation13 = parseInput(
	"3 2
	0 3 0
	0 -13 0
	1
	1 0 TOP" );
	
}

