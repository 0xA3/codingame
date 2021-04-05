package test.tunnel;

import BreadthFirstSearch;
import data.Location;
import data.Node;
import parser.ParseLevel;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Tunnel)
class TestIncrementLocation extends buddy.BuddySuite {

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
				final tunnel = new Tunnel( input.locked, input.width, input.height );
				final resultLocation = tunnel.incrementLocation( input.indy.index, input.indy.pos, input.cells[input.indy.index] );
				resultLocation.index.should.be( 4 );
				resultLocation.pos.should.be( 0 );
			});
			
			it( "Turn Left", {
				final input = turnLeft;
				final tunnel = new Tunnel( input.locked, input.width, input.height );
				final location:Location = { index: 7, pos: 0 };
				final resultLocation = tunnel.incrementLocation( location.index, location.pos, input.cells[location.index] );
				resultLocation.index.should.be( 6 );
				resultLocation.pos.should.be( 2 );
			});
			
			it( "Turn Right", {
				final input = turnRight;
				final tunnel = new Tunnel( input.locked, input.width, input.height );
				final location:Location = { index: 7, pos: 0 };
				final resultLocation = tunnel.incrementLocation( location.index, location.pos, input.cells[location.index] );
				resultLocation.index.should.be( 8 );
				resultLocation.pos.should.be( 1 );
			});
			
			it( "Horizontal", {
				final input = horizontal;
				final tunnel = new Tunnel( input.locked, input.width, input.height );
				final location:Location = { index: 5, pos: 1 };
				final resultLocation = tunnel.incrementLocation( location.index, location.pos, input.cells[location.index] );
				resultLocation.index.should.be( 6 );
				resultLocation.pos.should.be( 1 );
			});
			
			it( "Horizontal Well", {
				final input = horizontalWell;
				final tunnel = new Tunnel( input.locked, input.width, input.height );
				final location:Location = { index: 7, pos: 1 };
				final resultLocation = tunnel.incrementLocation( location.index, location.pos, input.cells[location.index] );
				resultLocation.index.should.be( 12 );
				resultLocation.pos.should.be( 0 );
			});
			
			it( "Turn Right Left", {
				final input = turnRightLeft;
				final tunnel = new Tunnel( input.locked, input.width, input.height );
				final location:Location = { index: 8, pos: 1 };
				final resultLocation = tunnel.incrementLocation( location.index, location.pos, input.cells[location.index] );
				resultLocation.index.should.be( 13 );
				resultLocation.pos.should.be( 0 );
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
	0 1 LEFT
	0" );
	
	final horizontalWell = parseLevel(
	"5 3
	0 0 0 0 0
	2 2 8 2 2
	0 0 3 0 0
	2
	0 1 LEFT
	0" );

	final turnRightLeft = parseLevel(
	"5 3
	0 0 -3 0 0
	0 0 11 -13 0
	0 0 0 -3 0
	2
	2 0 TOP
	0" );
	
	
}

