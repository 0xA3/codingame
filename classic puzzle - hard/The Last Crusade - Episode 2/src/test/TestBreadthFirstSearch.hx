package test;

import test.ParseInput;

using Lambda;
using StringTools;
using buddy.Should;

@:access(BreadthFirstSearch)
class TestBreadthFirstSearch extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test BreadthFirstSearch getPathStates", {
			
			it( "Well", {
				final input = well;
				final state = new State( input.start, [], input.cells, input.locked, input.width );
				final bfs = new BreadthFirstSearch( input.exit );
				bfs.getPathStates( state );
			});	
			
			it( "Broken Well", {
				final input = brokenWell;
				final state = new State( input.start, [], input.cells, input.locked, input.width );
				final bfs = new BreadthFirstSearch( input.exit );
				bfs.getPathStates( state );
			});	
			
			it( "Broken Sewer", {
				final input = brokenSewer;
				final state = new State( input.start, [], input.cells, input.locked, input.width );
				final bfs = new BreadthFirstSearch( input.exit );
				bfs.getPathStates( state );
			});
			
			it( "Broken secret passages", {
				final input = brokenSecretPassages;
				final state = new State( input.start, [], input.cells, input.locked, input.width );
				final bfs = new BreadthFirstSearch( input.exit );
				bfs.getPathStates( state );
			});
			
			it( "Broken mausoleum", {
				final input = brokenMausoleum;
				final state = new State( input.start, [], input.cells, input.locked, input.width );
				final bfs = new BreadthFirstSearch( input.exit );
				bfs.getPathStates( state );
			});

		});
		describe( "Test BreadthFirstSearch getPaths", {
			
			it( "Well", {
				final input = well;
				final tunnel = new Tunnel( input.cells, input.locked, input.width );
				final bfs = new BreadthFirstSearch( input.exit );
				bfs.getPaths( input.start.index, input.start.pos, [], tunnel );
			});	
			@include
			it( "Broken Well", {
				final input = brokenWell;
				final tunnel = new Tunnel( input.cells, input.locked, input.width );
				final bfs = new BreadthFirstSearch( input.exit );
				bfs.getPaths( input.start.index, input.start.pos, [], tunnel );
			});	
			
			it( "Broken Sewer", {
				final input = brokenSewer;
				final tunnel = new Tunnel( input.cells, input.locked, input.width );
				final bfs = new BreadthFirstSearch( input.exit );
				bfs.getPaths( input.start.index, input.start.pos, [], tunnel );
			});
			
			it( "Broken secret passages", {
				final input = brokenSecretPassages;
				final tunnel = new Tunnel( input.cells, input.locked, input.width );
				final bfs = new BreadthFirstSearch( input.exit );
				bfs.getPaths( input.start.index, input.start.pos, [], tunnel );
			});
			
			it( "Broken mausoleum", {
				final input = brokenMausoleum;
				final tunnel = new Tunnel( input.cells, input.locked, input.width );
				final bfs = new BreadthFirstSearch( input.exit );
				bfs.getPaths( input.start.index, input.start.pos, [], tunnel );
			});

		});
	}

	final well = parseInput(
	"3 3
	0 3 0
	0 3 0
	0 3 0
	1
	1 0 TOP" );

	final brokenWell = parseInput(
	"5 3
	0 0 -3 0 0
	0 0 2 0 0
	0 0 -3 0 0
	2
	2 0 TOP
	0" );

	final brokenSewer = parseInput(
	"8 4
	0 -3 0 0 0 0 0 0
	0 12 3 3 2 3 12 0
	0 0 0 0 0 0 2 0
	0 -12 3 2 2 3 13 0
	1
	1 0 TOP
	0" );

	final brokenSecretPassages = parseInput(
	"6 9
	0 0 0 0 0 -3
	8 3 3 2 2 10
	2 0 0 0 10 13
	11 3 -2 3 1 13
	-3 10 0 0 2 0
	0 6 3 3 4 13
	0 3 0 13 -4 10
	0 13 2 4 10 0
	0 0 0 -3 0 0
	3
	5 0 TOP
	0" );

	final brokenMausoleum = parseInput(
	"13 10
	-3 12 8 6 3 2 7 2 7 0 0 0 0
	11 5 13 0 0 0 3 0 3 0 0 0 0
	0 11 2 2 3 3 8 2 -9 2 3 13 0
	0 0 0 0 0 12 8 3 1 3 2 7 0
	0 0 11 2 3 1 5 2 10 0 0 11 13
	0 0 3 0 0 6 8 0 0 0 0 0 2
	0 0 11 3 3 10 11 2 3 2 3 2 8
	0 12 6 3 2 3 3 6 3 3 2 3 12
	0 11 4 2 3 2 2 11 12 13 13 13 0
	0 0 -3 12 7 8 13 13 4 5 4 10 0
	2
	0 0 TOP
	0" );

}

