package test;

import BreadthFirstSearch;
import test.ParseInput;

using Lambda;
using StringTools;
using buddy.Should;

class TestTunnelNextAction extends buddy.BuddySuite {

	static final colLeft = 0;
	static final colCenter = 1;
	static final colRight = 2;

	static final TOP = 0;
	static final LEFT = 1;
	static final RIGHT = 2;

	public function new() {
		
		describe( "Test Tunnel getNextAction", {
			
			it( "Simple", {
				final input = simple;
				final tunnel = new Tunnel( input.cells, input.locked, input.width );
				final paths = breadthFirstSearch( input.indy, [], tunnel, input.exit );
				paths.length.should.be( 1 );
				final path = paths[0];
				tunnel.getNextAction( path ).should.be( "WAIT" );
			});
			
			it( "Rotate cell left", {
				final input = rotateCellLeft;
				final tunnel = new Tunnel( input.cells, input.locked, input.width );
				final paths = breadthFirstSearch( input.indy, [], tunnel, input.exit );
				paths.length.should.be( 1 );
				// final path = paths[0];
				// tunnel.getNextAction( path ).should.be( "1 1 LEFT" );
			});
			
			it( "Rotate cell right", {
				final input = rotateCellRight;
				final tunnel = new Tunnel( input.cells, input.locked, input.width );
				final paths = breadthFirstSearch( input.indy, [], tunnel, input.exit );
				paths.length.should.be( 1 );
				final path = paths[0];
				tunnel.getNextAction( path ).should.be( "1 1 RIGHT" );
			});
			
			it( "Rotate cell twice", {
				final input = rotateCellTwice;
				final tunnel = new Tunnel( input.cells, input.locked, input.width );
				final paths = breadthFirstSearch( input.indy, [], tunnel, input.exit );
				paths.length.should.be( 1 );
				final path = paths[0];
				tunnel.getNextAction( path ).should.be( "1 1 RIGHT" );
			});
			
		});
		
	}

	final simple = parseInput(
	"3 2
	0 3 0
	0 3 0
	1
	1 0 TOP" );
	
	final rotateCellLeft = parseInput(
	"5 3
	0 0 3 0 0
	0 13 10 0 0
	0 3 0 0 0
	1
	2 0 TOP" );
	
	final rotateCellRight = parseInput(
	"5 3
	0 0 3 0 0
	0 10 10 0 0
	0 3 0 0 0
	1
	2 0 TOP" );
	
	final rotateCellTwice = parseInput(
	"5 3
	0 0 3 0 0
	0 11 10 0 0
	0 3 0 0 0
	1
	2 0 TOP" );
	
}

