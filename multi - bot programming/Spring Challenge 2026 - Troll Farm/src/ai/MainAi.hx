package ai;

import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import ai.data.Inventory;
import ai.data.Tree;
import ai.data.Troll;
import ai.factory.BoardFactory;
import xa3.MTRandom;
import xa3.math.Pos;

using StringTools;

class MainAi {

	public static var seed = 0;
	public static var mtRandom:MTRandom;

	static function main() {
		var turn = 1;
		// js.Syntax.code("// Build date {0}", CompileTime.buildDateString() );
		printErr( CompileTime.buildDateString());
		var startTime = haxe.Timer.stamp();

		final ai = new ai.versions.Ai2();
		final inputs = readline().split(" ");
		final boardWidth = parseInt( inputs[0] ); // The width of the board
		final boardHeight = parseInt( inputs[1] ); // The height of the board
		final lines = [for( i in 0...boardHeight ) readline()];

		final myId = 0; // Your player id

		final board = BoardFactory.createBoard( boardWidth, boardHeight, lines );
		mtRandom = new MTRandom( seed );

		ai.setGlobalInputs( board );

		final inventories = [for( i in 0...2 ) new Inventory()];

		final treePositionsMap:Map<Pos, Tree> = [];
		final trees = [];
		final trolls:Map<Int, Troll> = [];
		final myTrolls = [];
		final oppTrolls = [];
		// game loop
		while( true ) {
			if( turn > 1 ) startTime = haxe.Timer.stamp();
			
			treePositionsMap.clear();
			trees.splice( 0, trees.length );
			
			for( i in 0...inventories.length ) updateInventory( inventories[i], readline().split(" ") );

			final treesCount = parseInt( readline() );

			for( _ in 0...treesCount ) {
				final inputs = readline().split(" ");
				final type = inputs[0];
				final x = parseInt( inputs[1] );
				final y = parseInt( inputs[2] );
				final size = parseInt( inputs[3] );
				final health = parseInt( inputs[4] );
				final fruits = parseInt( inputs[5] );
				final cooldown = parseInt( inputs[6] );

				final pos = board.positions[y][x];
				if( !treePositionsMap.exists( pos )) treePositionsMap.set( pos, new Tree( type, pos ));
				
				final tree = treePositionsMap[pos];
				tree.update( size, health, fruits, cooldown );
				// printErr( 'add tree at $pos  size $size health $health fruits $fruits cooldown $cooldown' );
				
				trees.push( tree );
			}

			final trollsCount = parseInt( readline() );

			for( _ in 0...trollsCount ) {
				final inputs = readline().split(" ");
				final id = parseInt( inputs[0] );
				final player = parseInt( inputs[1] );
				final x = parseInt( inputs[2] );
				final y = parseInt( inputs[3] );
				final movementSpeed = parseInt( inputs[4] );
				final carryCapacity = parseInt( inputs[5] );
				final harvestPower = parseInt( inputs[6] );
				final chopPower = parseInt( inputs[7] );
				final carryPlum = parseInt( inputs[8] );
				final carryLemon = parseInt( inputs[9] );
				final carryApple = parseInt( inputs[10] );
				final carryBanana = parseInt( inputs[11] );
				final carryIron = parseInt( inputs[12] );
				final carryWood = parseInt( inputs[13] );
				
				if( !trolls.exists( id )) {
					if( player == myId ) {
						final troll = new Troll( id, myTrolls.length, player, board, inventories[player] );
						myTrolls.push( troll );
						trolls.set( id, troll );
					} else {
						final troll = new Troll( id, oppTrolls.length, player, board, inventories[player] );
						oppTrolls.push( troll );
						trolls.set( id, troll );
					}
				}
				
				trolls[id].update( board.positions[y][x], movementSpeed, carryCapacity, harvestPower, chopPower, carryPlum, carryLemon, carryApple, carryBanana, carryIron, carryWood );
			}

			// board.populateBoard( treePositionsMap, trolls );
			
			ai.setInputs( inventories[myId], myTrolls, trees, treePositionsMap );
			final output = ai.process();
			
			printErr( '${int(( haxe.Timer.stamp() - startTime ) * 1000)}ms' );
			
			turn++;
			print( output );
		}
	}

	static function updateInventory( inventory:Inventory, values:Array<String> ) {
		final plum = parseInt( values[0] );
		final lemon = parseInt( values[1] );
		final apple = parseInt( values[2] );
		final banana = parseInt( values[3] );
		final iron = parseInt( values[4] );
		final wood = parseInt( values[5] );
		inventory.update( plum, lemon, apple, banana, iron, wood );
	}
}