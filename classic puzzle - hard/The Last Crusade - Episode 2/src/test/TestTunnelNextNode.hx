package test;

import test.ParseLevel;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestTunnelNextNode extends buddy.BuddySuite {

	static final colLeft = 0;
	static final colCenter = 1;
	static final colRight = 2;

	static final TOP = 0;
	static final LEFT = 1;
	static final RIGHT = 2;

	public function new() {
		
		describe( "Test Tunnel getNextNode", {
			it( "Simple", {
				final input = simple;
				final tunnel = new Tunnel( input.locked, input.width );
				final currentNode:Node = { cells: input.cells, indy: input.indy, rocks: [], index: input.indy.index, tile: input.cells[input.indy.index], diff: 0 };
				final node = tunnel.getNextNode( currentNode );
				final i = node.indy;
				'${i.index} ${i.pos}'.should.be( '4 0' );
			});	
			
			it( "turnLeft", {
				final input = turnLeft;
				final tunnel = new Tunnel( input.locked, input.width );
				final currentNode:Node = { cells: input.cells, indy: input.indy, rocks: [], index: input.indy.index, tile: input.cells[input.indy.index], diff: 0 };
				final node = tunnel.getNextNode( currentNode );
				final i = node.indy;
				'${i.index} ${i.pos}'.should.be( '0 2' );
			});	
			
			it( "turnRight", {
				final input = turnRight;
				final tunnel = new Tunnel( input.locked, input.width );
				final currentNode:Node = { cells: input.cells, indy: input.indy, rocks: [], index: input.indy.index, tile: input.cells[input.indy.index], diff: 0 };
				final node = tunnel.getNextNode( currentNode );
				final i = node.indy;
				'${i.index} ${i.pos}'.should.be( '2 1' );
			});	
			
			it( "Tile 0", {
				final input = allTiles;
				final indy = Main.parseLocation( "1 0 TOP", input.width );
				final tunnel = new Tunnel( input.locked, input.width );
				final currentNode:Node = { cells: input.cells, indy: indy, rocks: [], index: indy.index, tile: input.cells[indy.index], diff: 0 };
				final node = tunnel.getNextNode( currentNode );
				final i = node.indy;
				'${i.index} ${i.pos}'.should.be( '-1 -1' );
			});	
			
			it( "Tile 1", {
				final input = allTiles;
				final indy = Main.parseLocation( "1 1 TOP", input.width );
				final tunnel = new Tunnel( input.locked, input.width );
				final currentNode:Node = { cells: input.cells, indy: indy, rocks: [], index: indy.index, tile: input.cells[indy.index], diff: 0 };
				final node = tunnel.getNextNode( currentNode );
				final i = node.indy;
				'${i.index} ${i.pos}'.should.be( '${2 * 3 + colCenter} $TOP' );
			});	
			
			it( "Tile 2", {
				final input = allTiles;
				final indy = Main.parseLocation( "1 2 LEFT", input.width );
				final tunnel = new Tunnel( input.locked, input.width );
				final currentNode:Node = { cells: input.cells, indy: indy, rocks: [], index: indy.index, tile: input.cells[indy.index], diff: 0 };
				final node = tunnel.getNextNode( currentNode );
				final i = node.indy;
				'${i.index} ${i.pos}'.should.be( '${2 * 3 + colRight} $LEFT' );
			});	
			
			it( "Tile 3", {
				final input = allTiles;
				final indy = Main.parseLocation( "1 3 TOP", input.width );
				final tunnel = new Tunnel( input.locked, input.width );
				final currentNode:Node = { cells: input.cells, indy: indy, rocks: [], index: indy.index, tile: input.cells[indy.index], diff: 0 };
				final node = tunnel.getNextNode( currentNode );
				final i = node.indy;
				'${i.index} ${i.pos}'.should.be( '${4 * 3 + colCenter} $TOP' );
			});	
			
			it( "Tile 4", {
				final input = allTiles;
				final indy = Main.parseLocation( "1 4 TOP", input.width );
				final tunnel = new Tunnel( input.locked, input.width );
				final currentNode:Node = { cells: input.cells, indy: indy, rocks: [], index: indy.index, tile: input.cells[indy.index], diff: 0 };
				final node = tunnel.getNextNode( currentNode );
				final i = node.indy;
				'${i.index} ${i.pos}'.should.be( '${4 * 3 + colLeft} $RIGHT' );
			});	
			
			it( "Tile 5", {
				final input = allTiles;
				final indy = Main.parseLocation( "1 5 TOP", input.width );
				final tunnel = new Tunnel( input.locked, input.width );
				final currentNode:Node = { cells: input.cells, indy: indy, rocks: [], index: indy.index, tile: input.cells[indy.index], diff: 0 };
				final node = tunnel.getNextNode( currentNode );
				final i = node.indy;
				'${i.index} ${i.pos}'.should.be( '${5 * 3 + colRight} $LEFT' );
			});	
			
			it( "Tile 6", {
				final input = allTiles;
				final indy = Main.parseLocation( "1 6 LEFT", input.width );
				final tunnel = new Tunnel( input.locked, input.width );
				final currentNode:Node = { cells: input.cells, indy: indy, rocks: [], index: indy.index, tile: input.cells[indy.index], diff: 0 };
				final node = tunnel.getNextNode( currentNode );
				final i = node.indy;
				'${i.index} ${i.pos}'.should.be( '${6 * 3 + colRight} $LEFT' );
			});	
			
			it( "Tile 7", {
				final input = allTiles;
				final indy = Main.parseLocation( "1 7 TOP", input.width );
				final tunnel = new Tunnel( input.locked, input.width );
				final currentNode:Node = { cells: input.cells, indy: indy, rocks: [], index: indy.index, tile: input.cells[indy.index], diff: 0 };
				final node = tunnel.getNextNode( currentNode );
				final i = node.indy;
				'${i.index} ${i.pos}'.should.be( '${8 * 3 + colCenter} $TOP' );
			});	
			
			it( "Tile 8", {
				final input = allTiles;
				final indy = Main.parseLocation( "1 8 LEFT", input.width );
				final tunnel = new Tunnel( input.locked, input.width );
				final currentNode:Node = { cells: input.cells, indy: indy, rocks: [], index: indy.index, tile: input.cells[indy.index], diff: 0 };
				final node = tunnel.getNextNode( currentNode );
				final i = node.indy;
				'${i.index} ${i.pos}'.should.be( '${9 * 3 + colCenter} $TOP' );
			});	
			
			it( "Tile 9", {
				final input = allTiles;
				final indy = Main.parseLocation( "1 9 TOP", input.width );
				final tunnel = new Tunnel( input.locked, input.width );
				final currentNode:Node = { cells: input.cells, indy: indy, rocks: [], index: indy.index, tile: input.cells[indy.index], diff: 0 };
				final node = tunnel.getNextNode( currentNode );
				final i = node.indy;
				'${i.index} ${i.pos}'.should.be( '${10 * 3 + colCenter} $TOP' );
			});	
			
			it( "Tile 10", {
				final input = allTiles;
				final indy = Main.parseLocation( "1 10 TOP", input.width );
				final tunnel = new Tunnel( input.locked, input.width );
				final currentNode:Node = { cells: input.cells, indy: indy, rocks: [], index: indy.index, tile: input.cells[indy.index], diff: 0 };
				final node = tunnel.getNextNode( currentNode );
				final i = node.indy;
				'${i.index} ${i.pos}'.should.be( '${10 * 3 + colLeft} $RIGHT' );
			});	
			
			it( "Tile 11", {
				final input = allTiles;
				final indy = Main.parseLocation( "1 11 TOP", input.width );
				final tunnel = new Tunnel( input.locked, input.width );
				final currentNode:Node = { cells: input.cells, indy: indy, rocks: [], index: indy.index, tile: input.cells[indy.index], diff: 0 };
				final node = tunnel.getNextNode( currentNode );
				final i = node.indy;
				'${i.index} ${i.pos}'.should.be( '${11 * 3 + colRight} $LEFT' );
			});	
			
			it( "Tile 12", {
				final input = allTiles;
				final indy = Main.parseLocation( "1 12 RIGHT", input.width );
				final tunnel = new Tunnel( input.locked, input.width );
				final currentNode:Node = { cells: input.cells, indy: indy, rocks: [], index: indy.index, tile: input.cells[indy.index], diff: 0 };
				final node = tunnel.getNextNode( currentNode );
				final i = node.indy;
				'${i.index} ${i.pos}'.should.be( '${13 * 3 + colCenter} $TOP' );
			});	
			
			it( "Tile 13", {
				final input = allTiles;
				final indy = Main.parseLocation( "1 13 LEFT", input.width );
				final tunnel = new Tunnel( input.locked, input.width );
				final currentNode:Node = { cells: input.cells, indy: indy, rocks: [], index: indy.index, tile: input.cells[indy.index], diff: 0 };
				final node = tunnel.getNextNode( currentNode );
				final i = node.indy;
				'${i.index} ${i.pos}'.should.be( '${14 * 3 + colCenter} $TOP' );
			});	
			
		});
		
	}

	final simple = parseLevel(
	"3 2
	0 3 0
	0 3 0
	1
	1 0 TOP" );
	
	final turnLeft = parseLevel(
	"3 1
	2 10 0
	1
	1 0 TOP" );
	
	final turnRight = parseLevel(
	"3 1
	0 11 2
	1
	1 0 TOP" );
	
	final allTiles = parseLevel(
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
	
	final rotation1 = parseLevel(
	"3 2
	0 3 0
	0 1 0
	1
	1 0 TOP" );
	
	final rotation2 = parseLevel(
	"3 2
	0 3 0
	0 2 0
	1
	1 0 TOP" );
	
	final rotation3 = parseLevel(
	"3 2
	0 3 0
	0 3 0
	1
	1 0 TOP" );
	
	final rotation4 = parseLevel(
	"3 2
	0 3 0
	0 4 0
	1
	1 0 TOP" );
	
	final rotation5 = parseLevel(
	"3 2
	0 3 0
	0 5 0
	1
	1 0 TOP" );
	
	final rotation6 = parseLevel(
	"3 2
	0 3 0
	0 6 0
	1
	1 0 TOP" );
	
	final rotation7 = parseLevel(
	"3 2
	0 3 0
	0 7 0
	1
	1 0 TOP" );
	
	final rotation8 = parseLevel(
	"3 2
	0 3 0
	0 8 0
	1
	1 0 TOP" );
	
	final rotation9 = parseLevel(
	"3 2
	0 3 0
	0 9 0
	1
	1 0 TOP" );
	
	final rotation10 = parseLevel(
	"3 2
	0 3 0
	0 10 0
	1
	1 0 TOP" );
	
	final rotation11 = parseLevel(
	"3 2
	0 3 0
	0 11 0
	1
	1 0 TOP" );
	
	final rotation12 = parseLevel(
	"3 2
	0 3 0
	0 12 0
	1
	1 0 TOP" );
	
	final rotation13 = parseLevel(
	"3 2
	0 3 0
	0 13 0
	1
	1 0 TOP" );
	
	final lockedRotation11 = parseLevel(
	"3 2
	0 3 0
	0 -11 0
	1
	1 0 TOP" );
	
	final lockedRotation13 = parseLevel(
	"3 2
	0 3 0
	0 -13 0
	1
	1 0 TOP" );
	
}

