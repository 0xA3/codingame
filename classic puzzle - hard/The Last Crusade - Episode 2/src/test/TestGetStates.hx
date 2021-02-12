package test;

import test.ParseInput;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Tunnel)
class TestGetStates extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test getStates", {
			@include
			it( "Simple", {
				final input = simple;
				final tunnel = new Tunnel( input.cells, input.width, input.locked, input.exit );
				final nextCells = tunnel.getNextCells( input.start, [] );
				final states = tunnel.getInitialStates( input.start, nextCells );
				trace( states );
			});	
			
			// it( "Blocked path", {
			// 	final input = blockedPath;
			// 	final tunnel = new Tunnel( input.cells, input.width, input.locked, input.exit );
			// 	tunnel.getNextCells( input.start, [] ).join(" ").should.be( "4 7" );
			// });	
			
			// it( "To left Edge", {
			// 	final input = toLeftEdge;
			// 	final tunnel = new Tunnel( input.cells, input.width, input.locked, input.exit );
			// 	tunnel.getNextCells( input.start, [] ).join(" ").should.be( "4 3" );
			// });	
			
			// it( "To right Edge", {
			// 	final input = toRightEdge;
			// 	final tunnel = new Tunnel( input.cells, input.width, input.locked, input.exit );
			// 	tunnel.getNextCells( input.start, [] ).join(" ").should.be( "4 5" );
			// });	
			
		});
	}

	final simple = parseInput(
	"3 2
	0 3 0
	0 3 0
	1
	1 0 TOP" );
	
	final blockedPath = parseInput(
	"3 3
	0 3 0
	0 3 0
	0 2 0
	1
	1 0 TOP" );
	
	final toLeftEdge = parseInput(
	"3 3
	0 3 2
	2 10 0
	0 0 0
	1
	1 0 TOP" );
	
	final toRightEdge = parseInput(
	"3 3
	0 3 0
	0 11 2
	2 13 0
	1
	1 0 TOP" );
	
}

