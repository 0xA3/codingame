package test.tunnel;

import BreadthFirstSearch;
import data.Location;
import data.Node;
import parser.ParseLevel;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Tunnel)
class TestRemoveRockRockCollision extends buddy.BuddySuite {

	static final colLeft = 0;
	static final colCenter = 1;
	static final colRight = 2;

	static final TOP = 0;
	static final LEFT = 1;
	static final RIGHT = 2;

	public function new() {
		
		describe( "Test Tunnel removeRockRockCollision", {
			
			it( "No collision", {
				final input = simple;
				final tunnel = new Tunnel( input.locked, input.width );
				final rocks = [for( i in 0...4 ) {
					final rock:Location = { index: i, pos: 1 };
					rock;
				}];
				tunnel.removeCollidedRocks( rocks );
				rocks.length.should.be( 4 );
			});
			
			it( "1 collision", {
				final input = simple;
				final tunnel = new Tunnel( input.locked, input.width );
				final indices = [1, 2, 1, 4, 3];
				final rocks = indices.map( i -> {
					final rock:Location = { index: i, pos: 1 };
					rock;
				});
				tunnel.removeCollidedRocks( rocks );
				rocks.length.should.be( 3 );
			});
			
			it( "2 collisions", {
				final input = simple;
				final tunnel = new Tunnel( input.locked, input.width );
				final indices = [1, 2, 1, 4, 1];
				final rocks = indices.map( i -> {
					final rock:Location = { index: i, pos: 1 };
					rock;
				});
				tunnel.removeCollidedRocks( rocks );
				rocks.length.should.be( 2 );
			});
			
			it( "3 collisions", {
				final input = simple;
				final tunnel = new Tunnel( input.locked, input.width );
				final indices = [1, 2, 1, 1, 1];
				final rocks = indices.map( i -> {
					final rock:Location = { index: i, pos: 1 };
					rock;
				});
				tunnel.removeCollidedRocks( rocks );
				rocks.length.should.be( 1 );
			});
			
		});
		
		describe( "Test Tunnel checkIndyRockCollision", {
			
			it( "No collision", {
				final input = simple;
				final tunnel = new Tunnel( input.locked, input.width );
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
				final tunnel = new Tunnel( input.locked, input.width );
				final indy:Location = { index: 1, pos: 1 };
				final indices = [1, 2, 3];
				final rocks = indices.map( i -> {
					final rock:Location = { index: i, pos: 1 };
					rock;
				});
				tunnel.checkIndyRockCollision( indy, rocks ).should.be( true );
			});

		});
		

	}

	final simple = parseLevel(
	"3 2
	0 3 0
	0 3 0
	1
	1 0 TOP
	0" );
	
	final turnLeft = parseLevel(
	"5 3
	0 0 3 0 0
	0 12 10 0 0
	0 3 0 0 0
	1
	2 0 TOP
	0" );
	
	final turnRight = parseLevel(
	"5 3
	0 0 3 0 0
	0 0 11 13 0
	0 0 0 3 0
	3
	2 0 TOP
	0" );
	
	final horizontal = parseLevel(
	"5 3
	0 0 0 0 0
	2 2 2 2 2
	0 0 0 0 0
	2
	2 0 TOP
	0" );
	
	final horizontalWell = parseLevel(
	"5 3
	0 0 0 0 0
	2 2 8 2 2
	0 0 3 0 0
	2
	0 1 LEFT
	0" );
	
}

