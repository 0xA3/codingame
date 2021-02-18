package test;

import BreadthFirstSearch.Path;
import BreadthFirstSearch.breadthFirstSearch;
import CheckRotations;
import haxe.Timer;
import test.ParseInput;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestBreadthFirstSearch extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test BreadthFirstSearch getPaths", {
			
			it( "Well", {
				final input = well;
				final tunnel = new Tunnel( input.locked, input.width );
				final paths = breadthFirstSearch( input.indy, [], tunnel, input.cells, input.exit );
				paths.length.should.be( 1 );
				paths[0].map( node -> node.index ).join(" ").should.be( "2 7 12" );
			});	

			it( "Broken Well", {
				final input = brokenWell;
				final tunnel = new Tunnel( input.locked, input.width );
				final paths = breadthFirstSearch( input.indy, [], tunnel, input.cells, input.exit );
				paths.length.should.be( 1 );
				paths[0].map( node -> node.index ).join(" ").should.be( "2 7 12" );
			});	
			
			it( "Broken Sewer", {
				final input = brokenSewer;
				final tunnel = new Tunnel( input.locked, input.width );
				final paths = breadthFirstSearch( input.indy, [], tunnel, input.cells, input.exit );
				paths.length.should.be( 1 );
				paths[0].map( node -> node.index ).join(" ").should.be( "1 9 10 11 12 13 14 22 30 29 28 27 26 25" );
			});
			
			it( "Broken Sewer 1 1 LEFT", {
				final input = brokenSewer;
				final tunnel = new Tunnel( input.locked, input.width );
				input.cells[9] = 11;
				final indy:Location = { index: 9, pos: 0 };
				final paths = breadthFirstSearch( indy, [], tunnel, input.cells, input.exit );
				paths.length.should.be( 1 );
				paths[0].map( node -> node.index ).join(" ").should.be( "9 10 11 12 13 14 22 30 29 28 27 26 25" );
			});
			
			it( "Broken secret passages", {
				final input = brokenSecretPassages;
				final tunnel = new Tunnel( input.locked, input.width );
				final paths = breadthFirstSearch( input.indy, [], tunnel, input.cells, input.exit );
				paths.length.should.be( 6 );
				paths[0].map( node -> node.index ).join(" ").should.be( "5 11 10 9 8 7 6 12 18 19 20 21 22 28 34 35 41 40 46 45 51" );
			});
			
			it( "Broken mausoleum", {
				final input = brokenMausoleum;
				final tunnel = new Tunnel( input.locked, input.width );
				final paths = breadthFirstSearch( input.indy, [], tunnel, input.cells, input.exit );
				final validPaths = paths.filter( path -> checkRotations( tunnel, path ));
				validPaths.sort(( a, b ) -> a.length - b.length );
				validPaths.length.should.be( 12 );
				validPaths[0].map( node -> node.index ).join(" ").should.be( "0 13 14 27 28 29 30 31 32 33 34 47 60 59 58 71 84 85 86 87 88 89 90 103 102 101 100 99 98 111 110 109 108 107 106 119" );
				// trace( "\n" + validPaths.map( path -> pathToString( path )).join( "\n" ));
				// trace( "\n" + pathTiles( validPaths[0] ));
				// trace( "\n" + pathDiffs( validPaths[0] ));
				// trace( "\n" + outputPath( tunnel, validPaths[0] ));
				// trace( "\n" + outputPathUtf8( tunnel, input.cells, validPaths[0] ));
			});
			
			it( "Broken Well Step 2", {
				final input = brokenWell;
				final tunnel = new Tunnel( input.locked, input.width );
				final paths = breadthFirstSearch( input.indy, [], tunnel, input.cells, input.exit );
				paths.length.should.be( 1 );
				final path = paths[0];

				tunnel.getNextAction( input.cells, path );
				
				final node = path[1];
				final paths2 = breadthFirstSearch( node.indy, node.rocks, tunnel, node.cells, input.exit );
				paths2.length.should.be( 1 );
			});	

			it( "Rocks 1 Frame 5", {
				final input = rocks1Frame5;
				final tunnel = new Tunnel( input.locked, input.width );
				final rocks = parseRocks( rocks1Frame5Rocks, input.width );
				final start = Timer.stamp();
				final paths = breadthFirstSearch( input.indy, rocks, tunnel, input.cells, input.exit );
				trace( 'paths ${paths.length} time ${Timer.stamp() - start}' );
			});
			
		});
		
	}

	function pathTiles( path:Path ) return path.map( node -> node.tile ).join(" ");
	function pathDiffs( path:Path ) return path.map( node -> node.diff ).join(" ");
	
	static function parseRocks( input:String, width:Int ) {
		final inputLines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		return inputLines.map( line -> Main.parseLocation( line, width ));
	}
	
	function outputPath( tunnel:Tunnel, cells:Array<Int>, path:Path ) {
		for( node in path ) cells[node.index] = node.tile;
		return tunnel.cellsToString( cells );
	}

	function outputPathUtf8( tunnel:Tunnel, cells:Array<Int>, path:Path ) {
		for( node in path ) cells[node.index] = node.tile;
		return tunnel.cellsToStringUtf8( cells );
	}

	final well = parseInput(
	"5 3
	0 0 3 0 0
	0 0 3 0 0
	0 0 3 0 0
	2
	2 0 TOP
	0" );

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

	final rocks1Frame5 = parseInput(
	"10 8
	0 0 0 0 0 0 0 0 -3 0
	0 7 -2 2 -2 2 -2 2 10 0
	0 -7 -2 2 2 2 2 2 2 -2
	0 6 -2 2 2 2 2 2 2 -2
	0 -7 -2 2 2 2 2 2 2 -2
	0 8 -2 2 2 2 2 2 2 -2
	0 -7 -2 2 2 2 2 2 2 -2
	0 -3 0 0 0 0 0 0 0 0
	1
	5 1 RIGHT" );

	final rocks1Frame5Rocks =
	"6 2 RIGHT
	7 3 RIGHT
	8 4 RIGHT
	9 5 RIGHT";
	
}

