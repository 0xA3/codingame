package ai.versions;

import CodinGame.printErr;
import Std.int;
import ai.contexts.WarCry;
import ai.data.Board;
import ai.data.Inventory;
import ai.data.Tree;
import ai.data.Troll;
import xa3.math.Pos;

using xa3.math.IntMath;

// MOVE id x y Move troll id to cell (x, y).
// HARVEST id Make troll id harvest on its current cell.
// PLANT id type Make troll id plant a type on its current cell: PLUM, LEMON, APPLE or BANANA.
// CHOP id Make troll id chop on its current cell.
// PICK id type Make troll id pick one type from the shack: PLUM, LEMON, APPLE or BANANA.
// DROP id Make troll id drop all carried items at the shack.
// TRAIN moveSpeed carryCapacity harvestPower chopPower Train a new troll with the given attributes.
// MINE id Make troll id mine a nearby IRON.
// WAIT to do nothing.
// MSG text to display a message in the replay.

class Ai3 {

	public var aiId = "Ai3";
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
		// for( pos in treePositionsMap.keys() ) printErr( 'tree at $pos' );
		board.reset( trees, treePositionsMap );
		outputs.splice( 0, outputs.length );
	}

	public function testJobs() {
		final troll = myTrolls[0];
		troll.setJob( Planting( ANY ));
		final action = troll.go();
		if( action != "" ) return action else return "WAIT";

	}

	public function process() {
		maxSpeed = int( Math.sqrt( myInventory.plum - myTrolls.length ));
		maxCarry = int( Math.sqrt( myInventory.lemon - myTrolls.length ));
		maxHarvest = int( Math.sqrt( myInventory.apple - myTrolls.length ));
		maxChop = int( Math.sqrt( myInventory.iron - myTrolls.length ));

		var chopSum = 0;
		var plantSum = 0;
		for( troll in myTrolls ) {
			chopSum += troll.chopCounter;
			plantSum += troll.plantCounter;
		}

		if( myTrolls.length == 1 ) { // find ressources for second troll
			final troll = myTrolls[0];
			if( maxSpeed < 2 ) troll.setJob( Harvesting( PLUM ));
			else if( maxCarry < 2 ) troll.setJob( Harvesting( LEMON ));
			else if( maxHarvest < 2 ) troll.setJob( Harvesting( APPLE ));
			else if( maxChop < 2 ) troll.setJob( Mining );
			else {
				troll.setJob( Harvesting( ANY ));
				printErr( 'Train Troll $maxSpeed $maxCarry $maxHarvest $maxChop' );
				outputs.push( 'TRAIN $maxSpeed $maxCarry $maxHarvest $maxChop' );
			}
		} else {
			printErr( 'chopSum $chopSum plantSum $plantSum' );
			if( chopSum > plantSum ) {
				myTrolls[0].setJob( Planting( ANY ));
			} else {
				myTrolls[0].setJob( Harvesting( ANY ));
			}
			myTrolls[1].setJob( Chopping );
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