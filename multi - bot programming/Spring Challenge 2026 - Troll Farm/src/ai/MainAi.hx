package ai;

import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import ai.data.Board;
import ai.data.Cell;
import ai.data.Inventory;
import ai.data.Tree;
import ai.data.Troll;
import ai.factory.BoardFactory;
import xa3.math.Pos;
import ya.Set;

using StringTools;

class MainAi {

	static function main() {
		// js.Syntax.code("// Build date {0}", CompileTime.buildDateString() );
		printErr( CompileTime.buildDateString());
		
		final ai = new ai.versions.AiWood2();
		final inputs = readline().split(" ");
		final boardWidth = parseInt( inputs[0] ); // The width of the board
		final boardHeight = parseInt( inputs[1] ); // The height of the board
		final lines = [for( i in 0...boardHeight ) readline()];

		final myId = 0; // Your player id

		final board = BoardFactory.createBoard( boardWidth, boardHeight, lines );

		ai.setGlobalInputs( board );

		final inventories = [for( i in 0...2 ) new Inventory() ];
		
		final trees = [];
		final trolls:Map<Int, Troll> = [];
		// game loop
		while( true ) {
			final startTime = haxe.Timer.stamp();
			
			for( i in 0...2 ) updateInventory( inventories[i], readline().split(" ") );
			
			final treesMap:Map<Pos, Tree> = [];
			trees.splice( 0, trees.length );

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
				if( !treesMap.exists( pos )) treesMap.set( pos, new Tree( type, pos ) );
				final tree = treesMap[pos];
				tree.update( size, health, fruits, cooldown );
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
				
				if( !trolls.exists( id )) trolls.set( id, new Troll( id, player ));
				trolls[id].update( board.positions[y][x], movementSpeed, carryCapacity, harvestPower, chopPower, carryPlum, carryLemon, carryApple, carryBanana, carryIron, carryWood );
			}

			final myTrolls = [for( id => troll in trolls ) if( troll.player == myId ) troll];
			final oppTrolls = [for( id => troll in trolls ) if( troll.player != myId ) troll];

			board.populateBoard( treesMap, trolls );
			
			ai.setInputs( myTrolls, trees );
			final output = ai.process();
			
			printErr( '${int(( haxe.Timer.stamp() - startTime ) * 1000)}ms' );

			print( output );
		}
	}

	static function updateInventory( inventory:Inventory, values:Array<String> ) {
		final lemon = parseInt( values[0] );
		final plum = parseInt( values[1] );
		final apple = parseInt( values[2] );
		final banana = parseInt( values[3] );
		final iron = parseInt( values[4] );
		final wood = parseInt( values[5] );
		inventory.update( lemon, plum, apple, banana, iron, wood );
	}
}