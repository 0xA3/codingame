import CodinGame.printErr;

using Lambda;

enum abstract Action(Int) {
	var Take;
	var Attack;
	var Defend;
	var Increase;
}

enum TroopsToSend {
	All;
	Some( troops:Int );
}

class Factory {
	
	public final id:Int;
	public var owner = 0;
	public var cyborgs = 0;
	public var production = 0;
	public var value = 0.0;
	public var score = 0.0;
	public final myIncomingTroops:Array<Troop> = [];
	public final incomingEnemyTroops:Array<Troop> = [];

	public var action:Action;
	public var troopsToSend = Some( 0 );

	public function new( id:Int ) {
		this.id = id;
	}

	public function reset() {
		incomingEnemyTroops.splice( 0, incomingEnemyTroops.length );
	}

	public function update( owner:Int, cyborgs:Int, production:Int ) {
		this.owner = owner;
		this.cyborgs = cyborgs;
		this.production = production;
	}

	public function calculateValue( pathsThrough:Int ) {
		value = production + 0.01 * Math.pow( pathsThrough, 0.5 ) + 0.1;
		// printErr( 'factory $id cybs $cyborgs prod $production value $value' );
	}

	public function addMyIncomingTroop( troop:Troop ) {
		myIncomingTroops.push( troop );
	}
	
	public function addIncomingEnemyTroop( troop:Troop ) {
		incomingEnemyTroops.push( troop );
	}

	public function getNeededForDefense( turns:Int ) {
		final attackers = incomingEnemyTroops.fold(( troop, sum ) -> troop.arrives <= turns ? troop.cyborgs : 0, 0 );
		return attackers;
	}

	function getNeededReinforcements( turns:Int ) {
		final attackers = getNeededForDefense( turns );
		final producted = turns * production;
		return Std.int( Math.max( 0, attackers - cyborgs - producted ));
		// todo account for incoming bombs
	}

	function getRequiredToTakeNeutral( turnsToGetThere:Int ) {
		final fasterEnemyTroops = incomingEnemyTroops.filter( troop -> troop.arrives <= turnsToGetThere );
		final enemyTroops = fasterEnemyTroops.fold(( troop, sum ) -> sum + troop.cyborgs, 0 );
		if( enemyTroops > cyborgs ) {
			fasterEnemyTroops.sort( Troop.sortByArrives );
			var turnsUntilTakeover = 0;
			var neutralCyborgs = cyborgs;
			for( troop in fasterEnemyTroops ) {
				neutralCyborgs -= troop.cyborgs;
				turnsUntilTakeover = troop.arrives;
				if( neutralCyborgs < 0 ) break;
			}
			final remainingEnemyTroops = enemyTroops - cyborgs;
			final productionAfterTakeOver = (turnsToGetThere - turnsUntilTakeover ) * production;
			return remainingEnemyTroops + productionAfterTakeOver;
		} else {
			return cyborgs;
		}
		
	}

	public function calculateScore( turnsToGetThere:Int ) {
		switch owner {
			case 1:
				final defenseScore = calculateDefenseScore( turnsToGetThere );
				final increaseScore = calculateIncreaseScore();
				if( defenseScore > increaseScore ) {
					score = defenseScore;
					action = Defend;
				} else {
					score = increaseScore;
					action = Increase;
				}
			case -1:
				calculateEnemyAttackScore( turnsToGetThere );
				action = Attack;
			default:
				calculateNeutralScore( turnsToGetThere );
				action = Take;
		}
	}

	function calculateNeutralScore( turnsToGetThere:Int ) {
		final troops = getRequiredToTakeNeutral( turnsToGetThere );
		troopsToSend = Some( troops );
		final s = value / Math.pow( turnsToGetThere, 2 ) * troops;
		// printErr( '$id neutral troops $troops $score $s' );
		return s;
	}

	function calculateEnemyAttackScore( turnsToGetThere:Int ) {
		troopsToSend = All;
		final s = value / ( Math.pow( turnsToGetThere, 2 ) * 8 );
		// printErr( '$id enemy $score $s' );
		return s;
	}

	function calculateDefenseScore( turnsToGetThere:Int ) {
		final troops = getNeededReinforcements( turnsToGetThere + 5 );
		troopsToSend = Some( troops );
		final s = value / ( Math.pow( turnsToGetThere, 2 ) * troops );
		// printErr( '$id my score $s' );
		return s;
	}

	function calculateIncreaseScore() {
		action = Increase;
		final s = 1 / Math.pow( 10, 1.6 );
		// printErr( '$id my increase $s' );
		return s;
	}

	public static function sortByScore( f1:Factory, f2:Factory ) {
		if( f1.score > f2.score ) return -1;
		if( f1.score < f2.score ) return 1;
		return 0;
	}

}