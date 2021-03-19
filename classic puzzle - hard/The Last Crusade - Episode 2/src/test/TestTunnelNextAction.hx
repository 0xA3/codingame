package test;

import BreadthFirstSearch;
import parser.ParseLevel;

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
				final tunnel = new Tunnel( input.locked, input.width );
				final paths = breadthFirstSearch( input.indy, [], tunnel, input.cells, input.exit );
				paths.length.should.be( 1 );
				final path = paths[0];
				tunnel.getNextAction( input.cells, path ).should.be( "WAIT" );
			});
			
			it( "Rotate cell left", {
				final input = rotateCellLeft;
				final tunnel = new Tunnel( input.locked, input.width );
				final paths = breadthFirstSearch( input.indy, [], tunnel, input.cells, input.exit );
				paths.length.should.be( 1 );
				// final path = paths[0];
				// tunnel.getNextAction( path ).should.be( "1 1 LEFT" );
			});
			
			it( "Rotate cell right", {
				final input = rotateCellRight;
				final tunnel = new Tunnel( input.locked, input.width );
				final paths = breadthFirstSearch( input.indy, [], tunnel, input.cells, input.exit );
				paths.length.should.be( 1 );
				final path = paths[0];
				tunnel.getNextAction( input.cells, path ).should.be( "1 1 RIGHT" );
			});
			
			it( "Rotate cell twice", {
				final input = rotateCellTwice;
				final tunnel = new Tunnel( input.locked, input.width );
				final paths = breadthFirstSearch( input.indy, [], tunnel, input.cells, input.exit );
				paths.length.should.be( 1 );
				final path = paths[0];
				tunnel.getNextAction( input.cells, path ).should.be( "1 1 RIGHT" );
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
	
	final rotateCellLeft = parseLevel(
	"5 3
	0 0 3 0 0
	0 13 10 0 0
	0 3 0 0 0
	1
	2 0 TOP
	0" );
	
	final rotateCellRight = parseLevel(
	"5 3
	0 0 3 0 0
	0 10 10 0 0
	0 3 0 0 0
	1
	2 0 TOP
	0" );
	
	final rotateCellTwice = parseLevel(
	"5 3
	0 0 3 0 0
	0 11 10 0 0
	0 3 0 0 0
	1
	2 0 TOP
	0" );
	
}

