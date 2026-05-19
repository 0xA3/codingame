package ai.versions;

import CodinGame.printErr;
import Std.int;
import ai.contexts.WarCry;
import ai.data.Board;
import ai.data.Inventory;
import ai.data.TFruit;
import ai.data.Tree;
import ai.data.Troll;
import xa3.math.Pos;

using xa3.math.IntMath;


class Ai5 {

	public var aiId = "Ai5";
	final outputs:Array<String> = [];

	var board:Board;
	var myInventory:Inventory;
	var myTrolls:Array<Troll>;
	
	var turn = 1;
	final warCry = new WarCry();
	
	var maxSpeed = 0;
	var maxCarry = 0;
	var maxHarvest = 0;
	var maxChop = 0;

	public function new() {	}

	public function setGlobalInputs( board:Board ) {
		this.board = board;
	}

	public function setInputs( myInventory:Inventory, myTrolls:Array<Troll>, trees:Array<Tree>, treePositionsMap:Map<Pos, Tree> ) {
		this.myInventory = myInventory;
		this.myTrolls = myTrolls;
		board.reset( trees, treePositionsMap );
		outputs.splice( 0, outputs.length );
	}

	public function processx() {
		final troll = myTrolls[0];
		final treeTypesAroundBase = board.getTreeTypesAroundBase( 4 );
		treeTypesAroundBase.sort(( a, b ) -> a.amount - b.amount );
		final mostRareTreeType = treeTypesAroundBase[0].type;
		printErr( [for( tt in treeTypesAroundBase ) '${tt.type} ${tt.amount}'].join(",") );

		if( troll.state == Idle ) troll.addTask( Plant( mostRareTreeType ));
		final action = troll.go();
		if( action != "" ) return action else return "WAIT";

	}

	public function process() {
		maxSpeed = int( Math.sqrt( myInventory.plum - myTrolls.length ));
		maxCarry = int( Math.sqrt( myInventory.lemon - myTrolls.length ));
		maxHarvest = int( Math.sqrt( myInventory.apple - myTrolls.length ));
		maxChop = int( Math.sqrt( myInventory.iron - myTrolls.length ));
		printErr( 'maxSpeed $maxSpeed maxCarry $maxCarry maxHarvest $maxHarvest maxChop $maxChop' );

		var chopSum = 0;
		var plantSum = 0;
		for( troll in myTrolls ) {
			chopSum += troll.chopCounter;
			plantSum += troll.plantCounter;
		}

		final treeTypesAroundBase = board.getTreeTypesAroundBase( 4 );
		final fruitsAroundBase = board.getFruitsAroundBase( 4 );

		treeTypesAroundBase.sort(( a, b ) -> a.amount - b.amount );
		final plant1 = treeTypesAroundBase[0].type;
		final plant2 = treeTypesAroundBase[1].type;

		final rareFruits = myInventory.getFruitAmounts();
		final mostRareFruit = rareFruits[0].fruit;
		final secondMostRareFruit = rareFruits[1].fruit;

		if( myTrolls.length == 1 ) { // find ressources for second troll
			final troll = myTrolls[0];
			if( troll.state == Idle ) {
				if( maxSpeed < 1 ) troll.addTask( Harvest( PLUM ));
				if( maxCarry < 1 ) troll.addTask( Harvest( LEMON ));
				if( maxHarvest < 1 ) troll.addTask( Harvest( APPLE ));
				if( maxChop < 1 ) troll.addTask( Mine );
				
				if( maxSpeed >= 1 && maxCarry >= 1 && maxHarvest >= 1 && maxChop >= 1 ) {
					troll.addTask( Harvest( ANY ));
					final speed = maxSpeed.min( 3 );
					final carry = maxCarry.min( 3 );
					final harvest = maxHarvest.min( 3 );
					final chop = maxChop.min( 3 );
					printErr( 'Train Troll $speed $carry $harvest $chop' );
					outputs.push( 'TRAIN $speed $carry $harvest $chop' );
				}
			}
		} else if( myTrolls.length == 2 ) {
			final troll0 = myTrolls[0];
			final troll1 = myTrolls[1];
			
			if( troll0.state == Idle ) {
				if( fruitsAroundBase[mostRareFruit] == 0 ) {
					troll0.addTask( Plant( plant1 ));
				} else {
					troll0.addTask( Harvest( mostRareFruit ));
				}
			}
			if( troll1.state == Idle ) {
				if( fruitsAroundBase[secondMostRareFruit] == 0 ) {
					troll1.addTask( Plant( plant2 ));
				} else {
					troll1.addTask( Harvest( secondMostRareFruit ));
				}
				if( maxChop < 3 ) troll1.addTask( Mine );
			}

			if( maxSpeed >= 1 && maxCarry >= 3 && maxHarvest >= 1 && maxChop >= 3 ) {
				final speed = maxSpeed.min( 3 );
				final carry = maxCarry.min( 3 );
				final harvest = maxHarvest.min( 3 );
				final chop = maxChop.min( 3 );
				printErr( 'Train Troll $speed $carry $harvest $chop' );
				outputs.push( 'TRAIN $speed $carry $harvest $chop' );
			}

		} else {
			final troll0 = myTrolls[0];
			final troll1 = myTrolls[1];
			final troll2 = myTrolls[2];
			
			final treesNumAroundBase = board.countTreesAroundBase( 4 );

			if( troll0.state == Idle ) {
				if( treesNumAroundBase < 4 ) troll0.addTask( Plant( ANY ));
				else if( fruitsAroundBase[mostRareFruit] == 0 ) {
					troll0.addTask( Plant( plant1 ));
				} else {
					troll0.addTask( Harvest( mostRareFruit ));
				}
			}
			if( troll1.state == Idle ) {
				if( treesNumAroundBase < 6 ) troll0.addTask( Plant( ANY ));
				else if( fruitsAroundBase[secondMostRareFruit] == 0 ) {
					troll1.addTask( Plant( plant2 ));
				} else {
					troll1.addTask( Harvest( secondMostRareFruit ));
				}
			}

			if( troll2.state == Idle ) {
				troll2.addTask( Chop( AnyPlayer ));
			}
		}

		for( troll in myTrolls ) {
			final action = troll.go();
			if( action != "" ) outputs.push( action );
		}
		
		turn++;
		
		final warcry = warCry.get();
		return ( warcry != "" ? 'MSG $warcry;' : "" ) + ( outputs.length == 0 ? "WAIT" : outputs.join(";"));
	}
}