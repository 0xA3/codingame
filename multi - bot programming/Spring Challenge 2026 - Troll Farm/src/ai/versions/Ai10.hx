package ai.versions;

import CodinGame.printErr;
import Std.int;
import ai.contexts.WarCry;
import ai.data.Board;
import ai.data.Inventory;
import ai.data.TResource;
import ai.data.Tree;
import ai.data.Troll;
import ai.data.TypeAmount;
import xa3.math.Pos;

using xa3.math.IntMath;

class Ai10 {

	public var aiId = "Ai10";

	final outputs:Array<String> = [];

	var board:Board;
	var myInventory:Inventory;
	var myTrolls:Array<Troll>;
	
	final warCry = new WarCry();
	
	var maxSpeed = 0;
	var maxCarry = 0;
	var maxHarvest = 0;
	var maxChop = 0;
	var treeTypesAroundBase:Array<TypeAmount> = [];
	var numTreesAroundBase = 0;
	var fruitsAroundBase:Map<TResource, Int> = [];
	var numFruitsAroundBase = 0;

	static inline var NEAR_DISTANCE = 2;
	static inline var FAR_DISTANCE = 4;

	var turn = 1;

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

	public function processx() { // test tasks
		final troll = myTrolls[0];
		final treeTypesAroundBase = board.getTreeTypesAroundBase( NEAR_DISTANCE );
		treeTypesAroundBase.sort(( a, b ) -> a.amount - b.amount );
		final mostRareTreeType = treeTypesAroundBase[0].type;
		printErr( [for( tt in treeTypesAroundBase ) '${tt.type} ${tt.amount}'].join(",") );

		if( troll.isDoing == Nothing ) troll.addTask( Plant( mostRareTreeType ));
		final action = troll.go();
		if( action != "" ) return action else return "WAIT";

	}

	static inline var MIN_SPEED_SECOND_TROLL = 2;
	static inline var MIN_CARRY_CAPACITY_SECOND_TROLL = 2;

	public function process() {
		// cost = trolls + attribute * attribute
		// attribute * attribute = cost - trolls
		// attribute = sqrt( cost - trolls )
		maxSpeed = int( Math.sqrt( myInventory.plum - myTrolls.length ));
		maxCarry = int( Math.sqrt( myInventory.lemon - myTrolls.length ));
		maxHarvest = int( Math.sqrt( myInventory.apple - myTrolls.length ));
		maxChop = int( Math.sqrt( myInventory.iron - myTrolls.length ));
		// printErr( 'maxSpeed $maxSpeed maxCarry $maxCarry maxHarvest $maxHarvest maxChop $maxChop' );

		treeTypesAroundBase = board.getTreeTypesAroundBase( NEAR_DISTANCE );
		numTreesAroundBase = board.countTreesAroundBase( NEAR_DISTANCE );
		fruitsAroundBase = board.getFruitsAroundBase( NEAR_DISTANCE );
		numFruitsAroundBase = board.countFruits( fruitsAroundBase );
		
		// printErr( "tree types around base " + [for( tt in treeTypesAroundBase ) '${tt.type} ${tt.amount}'].join(",") );

		treeTypesAroundBase.sort(( a, b ) -> a.amount - b.amount );

		printErr( 'turn $turn myTrolls.length ${myTrolls.length}' );

		if( myTrolls.length == 1 ) process1();
		else if( myTrolls.length == 2 ) process2();
		// else if( myTrolls.length == 3 ) process3();

		for( troll in myTrolls ) {
			final action = troll.go();
			if( action != "" ) outputs.push( action );
		}
		
		turn++;
		
		final warcry = warCry.get();
		return ( warcry != "" ? 'MSG $warcry;' : "" ) + ( outputs.length == 0 ? "WAIT" : outputs.join(";"));
	}

	function process1() { // find ressources for second troll
		final troll0 = myTrolls[0];
		
		var isTrainingSecondTroll = false;
		if( maxSpeed >= MIN_SPEED_SECOND_TROLL && maxCarry >= MIN_CARRY_CAPACITY_SECOND_TROLL && maxHarvest >= 1 && maxChop >= 1 ) {
			final speed = maxSpeed;
			final carry = maxCarry;
			final harvest = maxHarvest;
			final chop = maxChop;
			printErr( 'Train Troll $speed $carry $harvest $chop' );
			outputs.push( 'TRAIN $speed $carry $harvest $chop' );

			myInventory.subtractTrainingCosts( myTrolls.length, speed, carry, harvest, chop );
			maxSpeed = int( Math.sqrt( myInventory.plum - myTrolls.length + 1 ));
			maxCarry = int( Math.sqrt( myInventory.lemon - myTrolls.length + 1 ));
			maxHarvest = int( Math.sqrt( myInventory.apple - myTrolls.length + 1 ));
			maxChop = int( Math.sqrt( myInventory.iron - myTrolls.length + 1 ));

			isTrainingSecondTroll = true;

			if( turn == 1 ) { // move away from shack
				final plantPosition = board.getPlantPosition( troll0.pos );
				if( plantPosition != Pos.NO_POS ) {
					troll0.addTask( Move( plantPosition ));
				}
			}
		}
		
		final myFruits = myInventory.getFruitAmounts();
		myFruits.sort(( a, b ) -> a.amount - b.amount ); // sort by amount in inventory

		if( troll0.isDoing == Nothing ) {
			if( maxChop < 1 ) troll0.addTask( Mine );
			troll0.addTask( Plant( myFruits[0].fruit ));
			troll0.addTask( Plant( myFruits[1].fruit ));
			troll0.addTask( Plant( myFruits[2].fruit ));
		}
	}

	function process2() {
		final slowTroll = myTrolls[0];
		final fastTroll = myTrolls[1];
		
		// cost = trolls + attribute * attribute
		final requiredPlums = myTrolls.length + 1 * 1;
		final requiredLemons = myTrolls.length + 3 * 3;
		final requiredApples = myTrolls.length + 1 * 1;
		final requiredIron = myTrolls.length + 3 * 3;
		
		final diffPlums = requiredPlums - myInventory.plum;
		final diffLemons = requiredLemons - myInventory.lemon;
		final diffApples = requiredApples - myInventory.apple;
		final diffIron = requiredIron - myInventory.iron;

		final diffs:Array<TypeAmount> = [
			{ type: PLUM, amount: diffPlums },
			{ type: LEMON, amount: diffLemons },
			{ type: APPLE, amount: diffApples },
			{ type: IRON, amount: diffIron }
		];

		diffs.sort(( a, b ) -> b.amount - a.amount );

		printErr( 'needed ' + [for( d in diffs ) 'type ${d.type}: ${d.amount}'].join(",") );

		final mostNeededResource = diffs[0].type;
		final secondMostNeededResource = diffs[1].type;

		final treeTypeDistances = board.getTreeTypeDistances();
		final resourceTypeDistances = [
			{ type: mostNeededResource, distance: mostNeededResource == IRON ? board.getIronDistance( board.myShack ) : treeTypeDistances[mostNeededResource] },
			{ type: secondMostNeededResource, distance: secondMostNeededResource == IRON ? board.getIronDistance( board.myShack ) : treeTypeDistances[secondMostNeededResource] }
		];
		resourceTypeDistances.sort(( a, b ) -> a.distance - b.distance );
		final nearResource = resourceTypeDistances[0].type;
		final farResource = resourceTypeDistances[1].type;
	
		final plant1 = treeTypesAroundBase[0].type;
		final plant2 = treeTypesAroundBase[1].type;
		
		if( slowTroll.isDoing == Nothing ) {
			if( nearResource == IRON ) slowTroll.addTask( Mine );
			else {
				// if( fruitsAroundBase[nearResource] > 0 ) {
					slowTroll.addTask( Harvest( nearResource ));
				// } else {
				// 	slowTroll.addTask( Plant( plant1 ));
				// }
			}
		}
		// if( troll1.pos.manhattanDistance( board.myShack ) == 1 && troll1.carrySum > 0 ) {
		// 	troll1.insertTask( Drop );
		// }
		if( fastTroll.isDoing == Nothing ) {
			if( farResource == IRON ) fastTroll.addTask( Mine );
			else {
				// if( fruitsAroundBase[farResource] > 0 ) {
					fastTroll.addTask( Harvest( farResource ));
				// } else {
				// 	fastTroll.addTask( Plant( plant2 ));
				// }
			}
		}

		if( maxSpeed >= 1 && maxCarry >= 3 && maxHarvest >= 1 && maxChop >= 3 ) {
			final speed = maxSpeed.min( 3 );
			final carry = maxCarry.min( 3 );
			final harvest = maxHarvest.min( 3 );
			final chop = maxChop.min( 3 );
			printErr( 'Train Troll $speed $carry $harvest $chop' );
			outputs.push( 'TRAIN $speed $carry $harvest $chop' );
		}
	}

	function process3() {
		final troll0 = myTrolls[0];
		final troll1 = myTrolls[1];
		final troll2 = myTrolls[2];
		
		final myFruits = myInventory.getFruitAmounts();
		myFruits.sort(( a, b ) -> a.amount - b.amount );
		final mostRareFruit = myFruits[0].fruit;
		final secondMostRareFruit = myFruits[1].fruit;

		final plant1 = treeTypesAroundBase[0].type;
		final plant2 = treeTypesAroundBase[1].type;

		if( troll0.isDoing == Nothing ) {
			if( numTreesAroundBase < 4 ) troll0.addTask( Plant( ANY ));
			else if( fruitsAroundBase[mostRareFruit] == 0 ) {
				troll0.addTask( Plant( plant1 ));
			} else {
				troll0.addTask( Harvest( mostRareFruit ));
			}
		}
		if( troll1.isDoing == Nothing ) {
			if( numTreesAroundBase < 6 ) troll1.addTask( Plant( ANY ));
			else if( fruitsAroundBase[secondMostRareFruit] == 0 ) {
				troll1.addTask( Plant( plant2 ));
			} else {
				troll1.addTask( Harvest( secondMostRareFruit ));
			}
		}

		if( troll2.isDoing == Nothing ) {
			troll2.addTask( Chop( AnyPlayer ));
		}
	}
}