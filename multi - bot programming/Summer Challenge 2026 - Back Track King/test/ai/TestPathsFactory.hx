package test.ai;

import Std.int;
import test.ai.ParseInput.parseInput;
import xa3.math.Pos;

using buddy.Should;

class TestPathsFactory extends buddy.BuddySuite {
	
	var boardWidth = 0;
	var positions = [];

	public function new() {
		
		describe( "Test PathsFactory", {
			it( "width 2", {
				final ip = width2;
				boardWidth = ip.boardWidth;
				positions = ip.positions;

				final paths = new ai.factory.PathsFactory( ip.boardWidth, ip.boardHeight, ip.grid, ip.positions ).createPaths();
				outputPaths( paths );
			});
			
			it( "width 3", {
				final ip = width3;
				boardWidth = ip.boardWidth;
				positions = ip.positions;

				final paths = new ai.factory.PathsFactory( ip.boardWidth, ip.boardHeight, ip.grid, ip.positions ).createPaths();
				outputPaths( paths );
			});
			@include it( "u", {
				final ip = u;
				boardWidth = ip.boardWidth;
				positions = ip.positions;

				final paths = new ai.factory.PathsFactory( ip.boardWidth, ip.boardHeight, ip.grid, ip.positions ).createPaths();
				outputPaths( paths );
			});
		});
	}

	function outputPaths( paths:Array<Array<Array<Pos>>> ) {
		for( startIndex in 0...paths.length ) {
			for( endIndex in 0...paths[startIndex].length ) {
				if( startIndex != endIndex ) trace( '${index2Pos(startIndex)} -> ${index2Pos(endIndex)} ${paths[startIndex][endIndex]}' );
			}
		}
	}
	
	function index2Pos( index:Int ) {
		return positions[int( index / boardWidth )][index % boardWidth];
	}

	public final width2 = parseInput(
		"2
		1
		.."
	);

	public final width3 = parseInput(
		"3
		1
		..."
	);

	public final u = parseInput(
		"3
		2
		.#.
		..."
	);
}