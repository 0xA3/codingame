package ai;

import CodinGame.printErr;
import Constants;
import board.GetNodePositions.getNodePositions;
import data.Pos;
import haxe.ds.HashMap;
import sim.Board;

class Ai1 {
	
	final board:Board;
	var bombPositions:Array<Pos>;

	var toInitialize = true;

	public function new( board:Board ) {
		this.board = board;
	}

	public function process( rounds:Int, bombsNum:Int ) {
		printErr( 'rounds $rounds  bombs $bombsNum' );
		if( toInitialize ) {
			bombPositions = getBombPositions( bombsNum );
			toInitialize = false;
		}
		
		if( bombsNum == 0 || bombPositions.length == 0 ) return "WAIT";
		
		final pos = bombPositions.shift();
		
		return '${pos.x} ${pos.y}';
	}

	function getBombPositions( bombsNum:Int ) {
		final surveillanceNodes = getNodePositions( board.grid, SURVELLANCE_NODE );
		final destroyPositions = getDestroyPositions( surveillanceNodes );
		destroyPositions.sort(( a, b ) -> b.destroy.length - a.destroy.length );

		final counts = [];
		for( i in 0...surveillanceNodes.length ) {
			final count = [for( dp in destroyPositions ) for( d in dp.destroy ) if( i == d ) true].length;
			counts.push({ id: i, count: count });
		}
		counts.sort(( a, b ) -> a.count - b.count );
		final ids = counts.map( c -> c.id );

		#if sim
		// trace( ids );
		// for( dp in destroyPositions ) trace( '${dp.pos}  ${dp.destroy}' );
		#end
		
		var bombs = [];
		while( ids.length > 0 ) {
			final id = ids[0];
			var nextDestroyPosition = destroyPositions[0];
			for( dp in destroyPositions ) {
				if( dp.destroy.contains( id )) {
					nextDestroyPosition = dp;
					break;
				}
			}
			bombs.push( nextDestroyPosition.pos );
			for( dpid in nextDestroyPosition.destroy ) {
				ids.remove( dpid );
			}
			// trace( 'bomb at ${nextDestroyPosition.pos}  destroys ${nextDestroyPosition.destroy}  remaining $ids' );
		}
		// trace( bombs );
		return bombs;
	}

	function getDestroyPositions( surveillanceNodes:Array<Pos> ) {
		final posMap = new HashMap<Pos, Array<Int>>();
		for( i in 0...surveillanceNodes.length ) {
			final node = surveillanceNodes[i];
			// north
			for( dy in 1...4 ) {
				final y = node.y - dy;
				if( y >= 0 ) {
					final cell = board.grid[y][node.x];
					if( cell == PASSIVE_NODE ) break;
					final pos:Pos = { x: node.x, y: y }
					if( posMap.exists( pos )) posMap[pos].push( i );
					else posMap.set( pos, [i] );
				}
			}
			// west
			for( dx in 1...SAVE_DISTANCE ) {
				final x = node.x - dx;
				if( x >= 0 ) {
					final cell = board.grid[node.y][x];
					if( cell == PASSIVE_NODE ) break;
					final pos:Pos = { x: x, y: node.y }
					if( posMap.exists( pos )) posMap[pos].push( i );
					else posMap.set( pos, [i] );
				}
			}
			// south
			for( dy in 1...SAVE_DISTANCE ) {
				final y = node.y + dy;
				if( y < board.height ) {
					final cell = board.grid[y][node.x];
					if( cell == PASSIVE_NODE ) break;
					final pos:Pos = { x: node.x, y: y }
					if( posMap.exists( pos )) posMap[pos].push( i );
					else posMap.set( pos, [i] );
				}
			}
			// east
			for( dx in 1...SAVE_DISTANCE ) {
				final x = node.x + dx;
				if( x < board.width ) {
					final cell = board.grid[node.y][x];
					if( cell == PASSIVE_NODE ) break;
					final pos:Pos = { x: x, y: node.y }
					if( posMap.exists( pos )) posMap[pos].push( i );
					else posMap.set( pos, [i] );
				}
			}
		}
		final destroyPositions = [for( pos => destroy in posMap ) { destroy: destroy, pos: pos }];
		
		return destroyPositions;
	}
}