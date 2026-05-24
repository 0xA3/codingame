package ai.versions;

import CodinGame.printErr;
import Std.int;
import ai.contexts.WarCry;
import ai.data.Board;
import ai.data.Inventory;
import ai.data.Player;
import ai.data.TResource;
import ai.data.Troll;
import ai.data.TypeAmount;
import xa3.math.Pos;

using xa3.math.IntMath;

class Ai14 {

	public var aiId = "Ai14";

	final outputs:Array<String> = [];

	var board:Board;
	var myInventory:Inventory;
	var oppInventory:Inventory;
	var myTrolls:Array<Troll>;
	var oppTrolls:Array<Troll>;

	final myTrollsMap:Map<Pos, Troll> = [];
	final oppTrollsMap:Map<Pos, Troll> = [];


	final warCry = new WarCry();
	
	var maxSpeed = 0;
	var maxCarry = 0;
	var maxHarvest = 0;
	var maxChop = 0;
	// var treeTypesAroundBase:Array<TypeAmount> = [];
	// var numTreesAroundBase = 0;
	// var fruitsAroundBase:Map<TResource, Int> = [];
	// var numFruitsAroundBase = 0;
	
	final resources = [PLUM, LEMON, APPLE, IRON];
	final myRequiredResources:Array<TypeAmount> = [
		new TypeAmount( PLUM, 0 ),
		new TypeAmount( LEMON, 0 ),
		new TypeAmount( APPLE, 0 ),
		new TypeAmount( IRON, 0 )
	];
	
	static inline var NEAR_DISTANCE = 2;
	static inline var FAR_DISTANCE = 4;

	var turn = 1;

	public function new() {	}

	public function setGlobalInputs( board:Board ) {
		this.board = board;
	}

	public function setInputs( myInventory:Inventory, oppInventory:Inventory, myTrolls:Array<Troll>, oppTrolls:Array<Troll> ) {
		this.myInventory = myInventory;
		this.oppInventory = oppInventory;
		this.myTrolls = myTrolls;
		this.oppTrolls = oppTrolls;
		board.reset();
		outputs.splice( 0, outputs.length );
		myTrollsMap.clear();
		oppTrollsMap.clear();
		for( troll in myTrolls ) myTrollsMap.set( troll.pos, troll );
		for( troll in oppTrolls ) oppTrollsMap.set( troll.pos, troll );
	}

	public function processx() { // test tasks
		final troll = myTrolls[0];
		// final treeTypesAroundBase = board.getTreeTypesAroundBase( NEAR_DISTANCE );
		// treeTypesAroundBase.sort(( a, b ) -> a.amount - b.amount );
		// final mostRareTreeType = treeTypesAroundBase[0].type;
		// printErr( [for( tt in treeTypesAroundBase ) '${tt.type} ${tt.amount}'].join(",") );

		// if( troll.isDoing == Nothing ) troll.addTask( Plant( mostRareTreeType ));
		// final action = troll.go();
		// if( action != "" ) return action else return "WAIT";

	}

	public function process() {
		
		calculateMaxTrainValues();

		printErr( 'turn $turn myTrolls.length ${myTrolls.length}' );

		if( myTrolls.length == 1 ) process1( myTrolls[0], 2, 2, 1, 1 );
		else if( myTrolls.length == 2 ) process2();
		else if( myTrolls.length == 3 ) process3( 2, 2, 2, 2 );
		else process4();

		for( troll in myTrolls ) {
			final action = troll.go();
			if( action != "" ) outputs.push( action );
		}
		
		turn++;
		
		final warcry = warCry.get();
		return ( warcry != "" ? 'MSG $warcry;' : "" ) + ( outputs.length == 0 ? "WAIT" : outputs.join(";"));
	}

	function calculateMaxTrainValues() {
		// cost = trolls + attribute * attribute
		// attribute * attribute = cost - trolls
		// attribute = sqrt( cost - trolls )
		maxSpeed = int( Math.sqrt( myInventory.plum - myTrolls.length ));
		maxCarry = int( Math.sqrt( myInventory.lemon - myTrolls.length ));
		maxHarvest = int( Math.sqrt( myInventory.apple - myTrolls.length ));
		maxChop = int( Math.sqrt( myInventory.iron - myTrolls.length ));

		// printErr( 'maxSpeed $maxSpeed maxCarry $maxCarry maxHarvest $maxHarvest maxChop $maxChop' );
	}

	function calculateRequiredResources( speed:Int, carry:Int, harvest:Int, chop:Int ) {
		for( i in 0...resources.length ) { // reset
			myRequiredResources[i].type = resources[i];
			myRequiredResources[i].amount = 0;
		}

		// cost = trolls + attribute * attribute
		final requiredPlums = myTrolls.length + speed * speed;
		final requiredLemons = myTrolls.length + carry * carry;
		final requiredApples = myTrolls.length + harvest * harvest;
		final requiredIron = myTrolls.length + chop * chop;
		
		final diffPlums = requiredPlums - myInventory.plum;
		final diffLemons = requiredLemons - myInventory.lemon;
		final diffApples = requiredApples - myInventory.apple;
		final diffIron = requiredIron - myInventory.iron;

		myRequiredResources[0].amount = diffPlums;
		myRequiredResources[1].amount = diffLemons;
		myRequiredResources[2].amount = diffApples;
		myRequiredResources[3].amount = diffIron;
		// printErr( 'requiredPlums $requiredPlums requiredLemons $requiredLemons requiredApples $requiredApples requiredIron $requiredIron' );
		// printErr( 'required ' + [for( resource in requiredResources ) 'type ${resource.type}: ${resource.amount}'].join(",") );
	}

	function process1( troll:Troll, nextTrollSpeed:Int, nextTrollCarry:Int, nextTrollHarvest:Int, nextTrollChop:Int ) { // find ressources for second troll
		
		calculateMaxTrainValues();
		if( maxSpeed >= nextTrollSpeed && maxCarry >= nextTrollCarry && maxHarvest >= nextTrollHarvest && maxChop >= nextTrollChop ) {
			final speed = maxSpeed;
			final carry = maxCarry;
			final harvest = maxHarvest;
			final chop = maxChop;
			printErr( 'Train Troll $speed $carry $harvest $chop' );
			outputs.push( 'TRAIN $speed $carry $harvest $chop' );

			myInventory.subtractTrainingCosts( myTrolls.length, speed, carry, harvest, chop );
			calculateMaxTrainValues();
			
			if( turn == 1 ) { // move away from shack
				final plantPosition = board.getPlantPosition( troll.pos );
				if( plantPosition != Pos.NO_POS ) {
					troll.addTask( Move( plantPosition ));
				}
			}
		}
		
		if( troll.isDoing == Nothing ) {
			calculateRequiredResources( nextTrollSpeed, nextTrollCarry, nextTrollHarvest, nextTrollChop );
			myRequiredResources.sort( TypeAmount.sortReverse );

			final treeTypesAroundBase = board.getTreeTypesAroundBase( 2 );

			for( requiredResource in myRequiredResources ) {
				if( requiredResource.amount <= 0 ) continue;
				
				printErr( 'requiredResource ${requiredResource.type} ${requiredResource.amount} treeTypesAroundBase ${treeTypesAroundBase[requiredResource.type]}' );
				if( requiredResource.type == IRON ) {
					troll.addTask( Mine );
					break;
				} else if( requiredResource.amount > 2 && myInventory.getFruitAmount( requiredResource.type ) > 0 && treeTypesAroundBase[requiredResource.type] < 2 ) {
					troll.addTask( Plant( requiredResource.type ));
					break;
				} else {
					printErr( 'troll ${troll.id} harvest ${requiredResource.type}' );
					troll.addTask( Harvest( requiredResource.type ));
					break;
				}
			}
		}
	}

	function process2() {
		final troll0 = myTrolls[0];
		final troll1 = myTrolls[1];
		checkOppAttack();

		if( troll1.chopPower < 3 ) {
			printErr( 'process2 harvestForThirdTroll' );
			harvestForThirdTroll( 2, 3, 1, 3);
		// } else if( board.shacksDistance > 5 ) {
		// 	printErr( 'process2 shack distance == ${board.getDistance( board.myShack, board.oppShack )} harvestForThirdTroll' );
		// 	harvestForThirdTroll( 2, 3, 1, 3);
		} else {
			if( oppTrolls.length < 2 ) {
				printErr( 'process2 harvestAndAttack' );
				process1( troll0, 2, 2, 1, 1 );
				attack( troll1 );
			} else {
				printErr( 'process2 harvestAndChop' );
				process1( troll0, 2, 2, 1, 1 );
				chop( troll1, Opp );
			}
		}
	}

	function checkOppAttack() {
		// detect opp troll hacking at my trees
		final attackedTrees = [];
		for( tree in board.trees ) {
			if( board.targetTrees.exists( tree.pos )) continue;
			
			if( tree.isNearPlayer == Me && tree.healthDecline > 0 ) {
				if( oppTrollsMap.exists( tree.pos )) attackedTrees.push( tree );
			}
		}

		if( attackedTrees.length == 0 ) return;

		final myTrollsByCarryCapacity = myTrolls.copy();
		myTrollsByCarryCapacity.sort(( a, b ) -> b.carryCapacity - a.carryCapacity);

		attackedTrees.sort(( a, b ) -> {
			final distanceA = board.getDistance( a.pos, board.myShack );
			final distanceB = board.getDistance( b.pos, board.myShack );
			return distanceA - distanceB;
		});


		for( tree in attackedTrees ) {
			final oppTroll = oppTrollsMap[tree.pos];
			final remainingHackDuration = int( tree.health / oppTroll.chopPower );
			printErr( 'Troll ${oppTroll.id} hacks at tree ${tree.pos}. healthDecline ${tree.healthDecline} remainingHealth ${tree.health} remainingDuration $remainingHackDuration Finished at turn ${turn + remainingHackDuration}' );
			
			for( myTroll in myTrollsByCarryCapacity ) {
				final turnsToReach = int( board.getDistance( myTroll.pos, tree.pos ) / oppTroll.movementSpeed );
				
				if( turnsToReach <= remainingHackDuration ) {
					switch myTroll.isDoing {
						case CoChop( _ ): // no-op
						default:
						printErr( 'troll ${myTroll.id} cochop tree ${tree.pos}' );
						myTroll.insertTask( CoChop( tree ));
						break;
					}
				}
			}
		}
	}

	function attack( troll:Troll ) {
		if( !board.treePositionsMap.exists( troll.pos )) troll.finishTask();
		
		final oppFruitAmounts = oppInventory.getFruitAmounts();
		oppFruitAmounts.sort(( a, b ) -> a.amount - b.amount );
		final treePriorities = oppFruitAmounts.map( typeAmount -> typeAmount.fruit ).concat([ BANANA ]);
		
		if( troll.isDoing == Nothing ) troll.addTask( Attack( treePriorities ));
	}

	function chop( troll:Troll, targetPlayer:Player ) {
		final oppFruitAmounts = oppInventory.getFruitAmounts();
		oppFruitAmounts.sort(( a, b ) -> a.amount - b.amount );
		final treePriorities = oppFruitAmounts.map( typeAmount -> typeAmount.fruit ).concat([ BANANA ]);

		if( troll.isDoing == Nothing ) troll.addTask( Chop( Opp, treePriorities ));
	}

	function harvestForThirdTroll( speed:Int, carry:Int, harvest:Int, chop:Int ) {
		final slowTroll = myTrolls[0];
		final fastTroll = myTrolls[1];

		calculateMaxTrainValues();
		if( maxSpeed >= speed && maxCarry >= carry && maxHarvest >= harvest && maxChop >= chop ) {
			final speed = maxSpeed;
			final carry = maxCarry;
			final harvest = maxHarvest;
			final chop = maxChop;
			printErr( 'Train Troll $speed $carry $harvest $chop' );
			outputs.push( 'TRAIN $speed $carry $harvest $chop' );

			myInventory.subtractTrainingCosts( myTrolls.length, speed, carry, harvest, chop );
			calculateMaxTrainValues();
		}
		
		calculateRequiredResources( speed, carry, harvest, chop );
		myRequiredResources.sort( TypeAmount.sortReverse );

		printErr( 'requiredResources ' + [for( requiredResource in myRequiredResources ) '${requiredResource.type} ${requiredResource.amount}'].join(",") );

		final mostNeeded = myRequiredResources[0];
		final secondMostNeeded = myRequiredResources[1];

		final treeTypeDistances = board.getTreeTypeDistances();
		final resourceTypeDistances = [
			{ type: mostNeeded.type, amount: mostNeeded.amount, distance: mostNeeded.type == IRON ? board.getIronDistance( board.myShack ) : treeTypeDistances[mostNeeded.type] },
			{ type: secondMostNeeded.type, amount: secondMostNeeded.amount, distance: secondMostNeeded.type == IRON ? board.getIronDistance( board.myShack ) : treeTypeDistances[secondMostNeeded.type] }
		];
		resourceTypeDistances.sort(( a, b ) -> a.distance - b.distance );
		final nearResource = resourceTypeDistances[0];
		final farResource = resourceTypeDistances[1];
	
		final treeTypesAroundBaseMap = board.getTreeTypesAroundBase( 4 );
		final treeTypesAroundBase:Array<TypeAmount> = [for( type => amount in treeTypesAroundBaseMap ) new TypeAmount( type, amount )];
		treeTypesAroundBase.sort( TypeAmount.sortReverse );
		printErr( 'tree types around base ' + [for( ta in treeTypesAroundBase ) '${ta.type} ${ta.amount}' ].join(",") );
		final plant1 = treeTypesAroundBase[0].type;
		final plant2 = treeTypesAroundBase[1].type;
		
		if( slowTroll.isDoing == Nothing ) {
			if( nearResource.type == IRON ) slowTroll.addTask( Mine );
			else if( nearResource.amount > 2 && myInventory.getFruitAmount( nearResource.type ) > 0 && treeTypesAroundBaseMap[nearResource.type] < 2 ) {
				slowTroll.addTask( Plant( nearResource.type ));
			} else {
				slowTroll.addTask( Harvest( nearResource.type ));
			}
		}
		if( fastTroll.isDoing == Nothing ) {
			if( farResource.type == IRON ) fastTroll.addTask( Mine );
			else if( farResource.amount > 2 && myInventory.getFruitAmount( farResource.type ) > 0 && treeTypesAroundBaseMap[farResource.type] < 2 ) {
				fastTroll.addTask( Plant( farResource.type ));
			} else {
				fastTroll.addTask( Harvest( farResource.type ));
			}
		}
	}

	function process3( speed:Int, carry:Int, harvest:Int, chop:Int ) {
		final slowTroll = myTrolls[0];
		final fastTroll = myTrolls[1];
		final chopTroll = myTrolls[2];

		checkOppAttack();

		calculateMaxTrainValues();
		var isTrainingFourthTroll = false;
		if( maxSpeed >= speed && maxCarry >= carry && maxHarvest >= harvest && maxChop >= chop ) {
			final speed = maxSpeed;
			final carry = maxCarry;
			final harvest = maxHarvest;
			final chop = maxChop;
			printErr( 'Train Troll $speed $carry $harvest $chop' );
			outputs.push( 'TRAIN $speed $carry $harvest $chop' );

			myInventory.subtractTrainingCosts( myTrolls.length, speed, carry, harvest, chop );
			calculateMaxTrainValues();
			
			isTrainingFourthTroll = true;
		}
		
		calculateRequiredResources( speed, carry, harvest, chop );
		myRequiredResources.sort( TypeAmount.sortReverse );

		printErr( 'requiredResources ' + [for( requiredResource in myRequiredResources ) '${requiredResource.type} ${requiredResource.amount}'].join(",") );

		final mostNeeded = myRequiredResources[0];
		final secondMostNeeded = myRequiredResources[1];

		final treeTypeDistances = board.getTreeTypeDistances();
		final resourceTypeDistances = [
			{ type: mostNeeded.type, amount: mostNeeded.amount, distance: mostNeeded.type == IRON ? board.getIronDistance( board.myShack ) : treeTypeDistances[mostNeeded.type] },
			{ type: secondMostNeeded.type, amount: secondMostNeeded.amount, distance: secondMostNeeded.type == IRON ? board.getIronDistance( board.myShack ) : treeTypeDistances[secondMostNeeded.type] }
		];
		resourceTypeDistances.sort(( a, b ) -> a.distance - b.distance );
		final nearResource = resourceTypeDistances[0];
		final farResource = resourceTypeDistances[1];
		
		final treeTypesAroundBaseMap = board.getTreeTypesAroundBase( 4 );
		final treeTypesAroundBase:Array<TypeAmount> = [for( type => amount in treeTypesAroundBaseMap ) new TypeAmount( type, amount )];
		treeTypesAroundBase.sort( TypeAmount.sortReverse );
		printErr( 'tree types around base ' + [for( ta in treeTypesAroundBase ) '${ta.type} ${ta.amount}' ].join(",") );
		final plant1 = treeTypesAroundBase[0].type;
		final plant2 = treeTypesAroundBase[1].type;
		
		if( slowTroll.isDoing == Nothing ) {
			if( nearResource.type == IRON ) slowTroll.addTask( Mine );
			else if( nearResource.amount > 2 && myInventory.getFruitAmount( nearResource.type ) > 0 && treeTypesAroundBaseMap[nearResource.type] < 2 ) {
				slowTroll.addTask( Plant( nearResource.type ));
			} else {
				slowTroll.addTask( Harvest( nearResource.type ));
			}
		}
		if( fastTroll.isDoing == Nothing ) {
			if( farResource.type == IRON ) fastTroll.addTask( Mine );
			else if( farResource.amount > 2 && myInventory.getFruitAmount( farResource.type ) > 0 && treeTypesAroundBaseMap[farResource.type] < 2 ) {
				fastTroll.addTask( Plant( farResource.type ));
			} else {
				fastTroll.addTask( Harvest( farResource.type ));
			}
		}

		if( chopTroll.isDoing == Nothing ) {
			final oppFruitAmounts = oppInventory.getFruitAmounts();
			oppFruitAmounts.sort(( a, b ) -> a.amount - b.amount );
			final treePriorities = oppFruitAmounts.map( typeAmount -> typeAmount.fruit ).concat([ BANANA ]);
			
			chopTroll.addTask( Chop( Opp, treePriorities ));
		}
	}
	
	function process4() {
		final slowTroll = myTrolls[0];
		final fastTroll = myTrolls[1];
		final chopTroll = myTrolls[2];
		final fourthTroll = myTrolls[3];

		checkOppAttack();

		final myFruitAmounts = myInventory.getFruitAmounts();
		myFruitAmounts.sort(( a, b ) -> b.amount - a.amount );
		final productiveFruitPriorities = myFruitAmounts.map( typeAmount -> typeAmount.fruit );

		final treePriorities = [ BANANA ].concat( productiveFruitPriorities );

		if( slowTroll.isDoing == Nothing ) slowTroll.addTask( Plant( BANANA ));
		if( fastTroll.isDoing == Nothing ) fastTroll.addTask( Chop( AnyPlayer, treePriorities ));
		if( chopTroll.isDoing == Nothing ) chopTroll.addTask( Chop( AnyPlayer, treePriorities ));
		if( fourthTroll.isDoing == Nothing ) fourthTroll.addTask( Plant( BANANA ));
	}
}