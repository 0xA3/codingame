package ai;

import CodinGame.print;
import CodinGame.printErr;
import Std.int;
import Std.parseInt;
import ai.contexts.WarCry;
import ai.data.Inventory;
import ai.data.Player;
import ai.data.Tree;
import ai.data.Troll;
import ai.factory.BoardFactory;
import js.Node.process;
import xa3.MTRandom;
import xa3.math.Pos;

using StringTools;
using tink.CoreApi;

// below is a mechanism that connects nodejs standard input with something that resembles the readline()
@await class MainAiLocal {

	public static var seed = 0;
	public static var mtRandom:MTRandom;

	static var inputLines:Array<String> = [];
	static var promises:Array<(String)->Void> = [];
	static var buffer:String = "";

	static function main() {
		process.stdin.setEncoding("utf8");
		process.stdin.on( "data", ( data:String ) -> {
			buffer += data;
			var lines:Array<String> = buffer.split( "\n" );
			if( lines.length > 1 ) {
				for( i in 0...lines.length - 1 ) inputLines.push( lines[i].trim() );
				buffer = lines[lines.length - 1];
				onReadline();
			}
		});

		// Start the async function
		asyncMain();
	}

	static function onReadline() {
		while( true ) {
			if( promises.length == 0 ) break;
			if( inputLines.length == 0 ) break;
			var prom = promises.shift();
			var str = inputLines.shift();
			
			prom( str );
		}
	}

	static function readline() {
		// trace( "readline" );
		var resolve:(String)->Void;

		final initFunc = function( r:(String)->Void ):Void {
			resolve = r;
			// trace( 'initFunc resolve: ${resolve}' );
			promises.push( resolve );
			onReadline();
		}

		// var prom:js.lib.Promise<String> = new js.lib.Promise( initFunc );
		final prom = Future.irreversible( initFunc );
		
		return prom;
	}
	
	@await static function asyncMain() {
		printErr( 'asyncMain' );
		// actual code, but must use (@await readline()) instead of readline() - for example
		// trace( "asyncMain" );
		js.Syntax.code("// Build date {0}", CompileTime.buildDateString() );
		
		var turn = 1;
		var startTime = haxe.Timer.stamp();
		mtRandom = new MTRandom( seed );
		final warCry = new WarCry( mtRandom );
		
		// final ai = new ai.versions.AiWait();
		final ai = new ai.versions.Ai17( warCry );
		final inputsAwait = @await readline();
		final inputs = inputsAwait.split(" ");
		final boardWidth = parseInt( inputs[0] ); // The width of the board
		final boardHeight = parseInt( inputs[1] ); // The height of the board
		final lines:Array<String> = [];
		for( i in 0...boardHeight ) {
			final line = @await readline();
			lines.push( line );
		}

		final trees = [];
		final treePositionsMap:Map<Pos, Tree> = [];

		final board = BoardFactory.createBoard( boardWidth, boardHeight, lines, trees, treePositionsMap );
		ai.setGlobalInputs( board );

		final inventories = [Me => new Inventory(), Opp => new Inventory()];

		final trolls:Map<Int, Troll> = [];
		final myTrolls = [];
		final oppTrolls = [];
		// game loop
		while( true ) {
			if( turn > 1 ) startTime = haxe.Timer.stamp();
			
			trees.splice( 0, trees.length );
			final treesLastTurn:Map<Pos, Tree> = [for( pos => tree in treePositionsMap ) pos => tree];
			treePositionsMap.clear();
			
			final inputsAwait = @await readline();
			inventories[Me].update( inputsAwait.split(" ") );
			
			final inputsAwait = @await readline();
			inventories[Opp].update( inputsAwait.split(" ") );

			final treesCount = parseInt( @await readline() );

			for( _ in 0...treesCount ) {
				final inputsAwait = @await readline();
				final inputs = inputsAwait.split(" ");
				final type = inputs[0];
				final x = parseInt( inputs[1] );
				final y = parseInt( inputs[2] );
				final size = parseInt( inputs[3] );
				final health = parseInt( inputs[4] );
				final fruits = parseInt( inputs[5] );
				final cooldown = parseInt( inputs[6] );

				final pos = board.positions[y][x];
				if( treesLastTurn.exists( pos )) treePositionsMap.set( pos, treesLastTurn[pos] );
				else treePositionsMap.set( pos, new Tree( type, pos ));
				
				final tree = treePositionsMap[pos];
				final isNearWater = board.waterNeighborPosSet.contains( pos );
				final myDistance = board.getDistance( pos, board.myShack );
				final oppDistance = board.getDistance( pos, board.oppShack );
				tree.update( size, health, fruits, cooldown, isNearWater, myDistance < oppDistance ? Me : Opp );
				// if( '$pos' == "10:2" ) printErr( 'tree at $pos health $health' );
				// printErr( 'add tree at $pos  myDistance $myDistance oppDistance $oppDistance' );
				
				trees.push( tree );
			}

			final trollsCount = parseInt( @await readline() );

			for( _ in 0...trollsCount ) {
				final inputsAwait = @await readline();
				final inputs = inputsAwait.split(" ");
				final id = parseInt( inputs[0] );
				final player = parseInt( inputs[1] ) == 0 ? Me : Opp;
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
					if( player == Me ) {
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
			
			ai.setInputs( inventories[Me], inventories[Opp], myTrolls, oppTrolls );
			final output = ai.process();
			
			printErr( '${int(( haxe.Timer.stamp() - startTime ) * 1000)}ms' );
			
			turn++;
			print( output );
		}
	}
}
