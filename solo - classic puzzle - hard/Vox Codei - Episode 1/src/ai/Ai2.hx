package ai;

import CodinGame.printErr;
import Constants;
import board.Board;
import board.Node;
import board.Visualize.visualize;
import data.Pos;
import haxe.ds.HashMap;
import haxe.ds.ReadOnlyArray;

class Ai2 {
	
	final startBoard:Board;

	var toInitialize = true;
	var actions = [];

	public function new( startBoard:Board ) {
		this.startBoard = startBoard;
	}

	public function process( rounds:Int, bombsNum:Int ) {
		if( toInitialize ) {
			actions = search(rounds, bombsNum );
			toInitialize = false;
		}
		if( actions.length > 0 ) return actions.shift();
		printErr( 'Error: not enough actions' );
		return "WAIT";
	}

	function search( rounds:Int, bombsNum:Int ) {
		final frontier = new List<Node>();

		frontier.add({ parent: null, action: "", rounds: rounds, bombsNum: bombsNum, board: startBoard });

		while( !frontier.isEmpty()) {
			final current = frontier.pop();
			// printErr( getStatus( current ));
			
			if( current.board.surveillanceNodes.length == 0 ) return backtrack( current );
			if( current.rounds < 0 ) break;
			
			if( current.bombsNum > 0 ) {
				final bestBombPositions = getBombPositions( current.board );
				for( bestBombPosition in bestBombPositions ) {
					final pos = bestBombPosition.pos;
					final nextAction = '${pos.x} ${pos.y}';
					final nextBoard = current.board.next( pos.x, pos.y );
					final actionNode:Node = {
						parent: current,
						action: nextAction,
						rounds: current.rounds - 1,
						bombsNum: current.bombsNum - 1,
						board: nextBoard,
					}
					frontier.add( actionNode );
				}
			}
			
			final waitNode:Node = {
				parent: current,
				action: WAIT,
				rounds: current.rounds - 1,
				bombsNum: current.bombsNum,
				board: current.board.next(),
			}
			frontier.add( waitNode );
			
		}

		throw 'Error: no solution found';
	}

	function getActions( node:Node ) {
		final actions = [];
		var temp = node;
		while( temp.parent != null ) {
			actions.unshift( temp.action );
			temp = temp.parent;
		}
		
		return actions;
	}

	function backtrack( node:Node ) {
		var outputs = [];
		final actions = [];
		var current = node;
		while( current.parent != null ) {
			outputs.push( getStatus( current ));

			actions.push( current.action );
			current = current.parent;
		}
		outputs.reverse();
		// #if sim trace( outputs.join( "\n" )); #end
		actions.reverse();

		return actions;
	}

	function getStatus( current:Node ) {
		final sNodes = [for( sNode in current.board.surveillanceNodes ) '${sNode.x}:${sNode.y}'];
		return '${getActions( current )} $current sNodes ${sNodes}\n' + visualize( current.board );
	}

	function getBombPositions( board:Board ) {
		final destroyPositions = getDestroyPositions( board, board.surveillanceNodes );
		destroyPositions.sort(( a, b ) -> b.surveillanceNodes.length - a.surveillanceNodes.length );
		// for( dp in destroyPositions ) trace( dp );
		
		final prevSurveillanceNodes = new Map<Int, Bool>();
		final destroyPositions2 = [];
		for( destroyPosition in destroyPositions ) {
			var hasNew = false;
			for( sNodeId in destroyPosition.surveillanceNodes ) {
				if( !prevSurveillanceNodes.exists( sNodeId )) {
					hasNew = true;
				}
				prevSurveillanceNodes.set( sNodeId, true );
			}
			if( hasNew ) destroyPositions2.push( destroyPosition );
		}
		// for( dp in destroyPositions2 ) trace( dp );
		
		return destroyPositions2.slice( 0, min( 2, destroyPositions2.length ));
	}

	function getDestroyPositions( board:Board, surveillanceNodes:ReadOnlyArray<Pos> ) {
		final posMap = new HashMap<Pos, Array<Int>>();
		for( i in 0...surveillanceNodes.length ) {
			final node = surveillanceNodes[i];
			// north
			for( dy in 1...4 ) {
				final y = node.y - dy;
				if( y >= 0 ) {
					final cell = board.grid[y][node.x];
					if( cell == PASSIVE_NODE ) break;
					if( cell == EMPTY ) {
						final pos:Pos = { x: node.x, y: y }
						if( posMap.exists( pos )) posMap[pos].push( i );
						else posMap.set( pos, [i] );
					}
				}
			}
			// west
			for( dx in 1...SAVE_DISTANCE ) {
				final x = node.x - dx;
				if( x >= 0 ) {
					final cell = board.grid[node.y][x];
					if( cell == PASSIVE_NODE ) break;
					if( cell == EMPTY ) {
						final pos:Pos = { x: x, y: node.y }
						if( posMap.exists( pos )) posMap[pos].push( i );
						else posMap.set( pos, [i] );
					}
				}
			}
			// south
			for( dy in 1...SAVE_DISTANCE ) {
				final y = node.y + dy;
				if( y < board.height ) {
					final cell = board.grid[y][node.x];
					if( cell == PASSIVE_NODE ) break;
					if( cell == EMPTY ) {
						final pos:Pos = { x: node.x, y: y }
						if( posMap.exists( pos )) posMap[pos].push( i );
						else posMap.set( pos, [i] );
					}
				}
			}
			// east
			for( dx in 1...SAVE_DISTANCE ) {
				final x = node.x + dx;
				if( x < board.width ) {
					final cell = board.grid[node.y][x];
					if( cell == PASSIVE_NODE ) break;
					if( cell == EMPTY ) {
						final pos:Pos = { x: x, y: node.y }
						if( posMap.exists( pos )) posMap[pos].push( i );
						else posMap.set( pos, [i] );
					}
				}
			}
		}
		final destroyPositions = [for( pos => surveillanceNodes in posMap ) { surveillanceNodes: surveillanceNodes, pos: pos }];
		
		return destroyPositions;
	}

	function min( v1:Int, v2:Int ) return v1 < v2 ? v1 : v2;
}