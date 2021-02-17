package test;

import BreadthFirstSearch;
import test.ParseInput;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Tunnel)
class TestTunnel extends buddy.BuddySuite {

	static final colLeft = 0;
	static final colCenter = 1;
	static final colRight = 2;

	static final TOP = 0;
	static final LEFT = 1;
	static final RIGHT = 2;

	public function new() {
		
		describe( "Test Tunnel incrementLocation", {
			
			it( "Simple", {
				final input = simple;
				final tunnel = new Tunnel( input.cells, input.locked, input.width );
				final resultLocation = tunnel.incrementLocation( input.indy );
				resultLocation.index.should.be( 4 );
				resultLocation.pos.should.be( 0 );
			});
			
			it( "Turn Left", {
				final input = turnLeft;
				final tunnel = new Tunnel( input.cells, input.locked, input.width );
				final location:Location = { index: 7, pos: 0 };
				final resultLocation = tunnel.incrementLocation( location );
				resultLocation.index.should.be( 6 );
				resultLocation.pos.should.be( 2 );
			});
			
			it( "Turn Right", {
				final input = turnRight;
				final tunnel = new Tunnel( input.cells, input.locked, input.width );
				final location:Location = { index: 7, pos: 0 };
				final resultLocation = tunnel.incrementLocation( location );
				resultLocation.index.should.be( 8 );
				resultLocation.pos.should.be( 1 );
			});
			
		});
		
		describe( "Test Tunnel removeRockRockCollision", {
			
			it( "No collision", {
				final input = simple;
				final tunnel = new Tunnel( input.cells, input.locked, input.width );
				final rocks = [for( i in 0...4 ) {
					final rock:Location = { index: i, pos: 1 };
					rock;
				}];
				tunnel.removeRockRockCollision( rocks );
				rocks.length.should.be( 4 );
			});
			
			it( "1 collision", {
				final input = simple;
				final tunnel = new Tunnel( input.cells, input.locked, input.width );
				final indices = [1, 2, 1, 4, 3];
				final rocks = indices.map( i -> {
					final rock:Location = { index: i, pos: 1 };
					rock;
				});
				tunnel.removeRockRockCollision( rocks );
				rocks.length.should.be( 3 );
			});
			
			it( "2 collisions", {
				final input = simple;
				final tunnel = new Tunnel( input.cells, input.locked, input.width );
				final indices = [1, 2, 1, 4, 1];
				final rocks = indices.map( i -> {
					final rock:Location = { index: i, pos: 1 };
					rock;
				});
				tunnel.removeRockRockCollision( rocks );
				rocks.length.should.be( 2 );
			});
			
			it( "3 collisions", {
				final input = simple;
				final tunnel = new Tunnel( input.cells, input.locked, input.width );
				final indices = [1, 2, 1, 1, 1];
				final rocks = indices.map( i -> {
					final rock:Location = { index: i, pos: 1 };
					rock;
				});
				tunnel.removeRockRockCollision( rocks );
				rocks.length.should.be( 1 );
			});
			
		});
		
		describe( "Test Tunnel checkIndyRockCollision", {
			
			it( "No collision", {
				final input = simple;
				final tunnel = new Tunnel( input.cells, input.locked, input.width );
				final indy:Location = { index: 0, pos: 1 };
				final indices = [1, 2, 3];
				final rocks = indices.map( i -> {
					final rock:Location = { index: i, pos: 1 };
					rock;
				});
				tunnel.checkIndyRockCollision( indy, rocks ).should.be( false );
			});
			
			it( "Collision", {
				final input = simple;
				final tunnel = new Tunnel( input.cells, input.locked, input.width );
				final indy:Location = { index: 1, pos: 1 };
				final indices = [1, 2, 3];
				final rocks = indices.map( i -> {
					final rock:Location = { index: i, pos: 1 };
					rock;
				});
				tunnel.checkIndyRockCollision( indy, rocks ).should.be( true );
			});

		});
		@include
		describe( "Test Tunnel getChildNodes", {
			
			it( "Simple", {
				final input = simple;
				final tunnel = new Tunnel( input.cells, input.locked, input.width );
				final currentNode:Node = { indy: input.indy, rocks: [], index: input.indy.index, tile: tunnel.cells[input.indy.index], diff: 0 };
				final nextNode = tunnel.getNextNode( currentNode );
				final childNodes = tunnel.getChildNodes( currentNode, nextNode );
				childNodes.length.should.be( 1 );
				childNodes[0].index.should.be( 4 );
			});
			
			it( "Turn left", {
				final input = turnLeft;
				final tunnel = new Tunnel( input.cells, input.locked, input.width );
				final currentNode:Node = { indy: input.indy, rocks: [], index: input.indy.index, tile: tunnel.cells[input.indy.index], diff: 0 };
				final nextNode = tunnel.getNextNode( currentNode );
				final childNodes = tunnel.getChildNodes( currentNode, nextNode );
				// trace( childNodes.map( node -> '${node.index} ${node.tile}' ));
				childNodes.length.should.be( 2 );
				childNodes[0].tile.should.be( 10 );
				childNodes[1].tile.should.be( 11 );
			});
			
			it( "Turn left 2", {
				final input = turnLeft;
				final tunnel = new Tunnel( input.cells, input.locked, input.width );
				final currentNode:Node = { indy: input.indy, rocks: [], index: input.indy.index, tile: tunnel.cells[input.indy.index], diff: 0 };
				final nextNode = tunnel.getNextNode( currentNode );
				final childNodes = tunnel.getChildNodes( currentNode, nextNode );
				trace( "childnodes " + childNodes.map( node -> '${node.index}: ${node.tile}' ));
				
				final childNodes2 = childNodes.flatMap( currentNode -> {
					trace( 'currentNode ${currentNode.index}: ${currentNode.tile}' );
					final nextNode = tunnel.getNextNode( currentNode );
					trace( 'nextNode ${nextNode.index}: ${nextNode.tile}' );
					final childNodes = tunnel.getChildNodes( currentNode, nextNode );
					return childNodes;
				});

				trace( "childNodes2 " + childNodes2.map( node -> '${node.index}: ${node.tile}' ));
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
	"5 3
	0 0 3 0 0
	0 12 10 0 0
	0 3 0 0 0
	1
	2 0 TOP" );
	
	final turnRight = parseInput(
	"5 3
	0 0 3 0 0
	0 0 11 13 0
	0 0 0 3 0
	3
	2 0 TOP" );
	
	final horizontal = parseInput(
	"5 3
	0 0 0 0 0
	2 2 2 2 2
	0 0 0 0 0
	2
	2 0 TOP" );
	
}

