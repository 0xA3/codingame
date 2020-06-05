import CodinGame.printErr;

using Lambda;

enum abstract Action(Int) {
	var Take;
	var Attack;
	var Defend;
	var Increase;
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
	public var neededTroops = 0;

	public function new( id:Int ) {
		this.id = id;
	}

	public function reset() {
		myIncomingTroops.splice( 0, myIncomingTroops.length );
		incomingEnemyTroops.splice( 0, incomingEnemyTroops.length );
		score = 0;
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
		
		final myFasterTroops = myIncomingTroops.filter( troop -> troop.arrives <= turnsToGetThere );
		final myTroops = myFasterTroops.fold(( troop, sum ) -> sum + troop.cyborgs, 0 );
		
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
			return remainingEnemyTroops + productionAfterTakeOver - myTroops + 1;
		} else {
			return cyborgs - myTroops + 1;
		}
		
	}

	public function calculateScore( turnsToGetThere:Int ) {
		switch owner {
			case 1:
				score = calculateDefenseScore( turnsToGetThere );
				action = Defend;
				// printErr( '$id ${actionToString( action )} troops $neededTroops score $score' );
			case -1:
				score = calculateEnemyAttackScore( turnsToGetThere );
				action = Attack;
				// printErr( '$id ${actionToString( action )} score $score' );
			default:
				score = calculateNeutralScore( turnsToGetThere );
				action = Take;
				// printErr( '$id ${actionToString( action )} troops $neededTroops score $score' );
		}

	}

	function calculateNeutralScore( turnsToGetThere:Int ) {
		final requiredTroops = getRequiredToTakeNeutral( turnsToGetThere );
		final myTroopsGoingThere = myIncomingTroops.fold(( troop, sum ) -> sum + troop.cyborgs, 0 );
		neededTroops = Std.int( Math.max( 0, requiredTroops - myTroopsGoingThere ));
		final s = value / Math.pow( turnsToGetThere, 2 ) * neededTroops;
		// printErr( '$id neutral troops $troops $score $s' );
		return s;
	}

	function calculateEnemyAttackScore( turnsToGetThere:Int ) {
		neededTroops = 0;
		final s = value / ( Math.pow( turnsToGetThere, 2 ) * 8 );
		// printErr( '$id enemy $score $s' );
		return s;
	}

	function calculateDefenseScore( turnsToGetThere:Int ) {
		neededTroops = getNeededReinforcements( turnsToGetThere + 5 );
		if( neededTroops == 0 ) return 0.0;

		final s = value / ( Math.pow( turnsToGetThere, 2 ) * neededTroops );
		// printErr( '$id my score $s' );
		return s;
	}

	public function calculateIncreaseScore() {
		final neededForDefense = getNeededForDefense( 5 );
		if( production == 3 || cyborgs - neededForDefense < 10 ) {
			score = 0;
			return;
		}
		
		neededTroops = 10;
		score = 1 / Math.pow( 10, 1.6 );
		action = Increase;
		// printErr( '$id ${actionToString( action )} score $score' );
	}

	public static function sortByScore( f1:Factory, f2:Factory ) {
		if( f1.score > f2.score ) return -1;
		if( f1.score < f2.score ) return 1;
		return 0;
	}

	public static inline function actionToString( action:Action ) {
		return switch action {
			case Take: "Take";
			case Attack: "Attack";
			case Defend: "Defend";
			case Increase: "Increase";
		}
	}

}