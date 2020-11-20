package game.data;

using Lambda;

class Action {
	
	static inline var V1 = 11;
	static inline var V2 = 11 * 11;
	static inline var V3 = 11 * 11 * 11;
	
	public final actionId:Int; // the unique ID of this spell or recipe
	public final actionType:ActionType; // CAST, OPPONENT_CAST, LEARN, BREW
	public final delta:Array<Int>; // tier-0 ingredient change
	public final price:Int; // the price in rupees if this is a potion
	public final tomeIndex:Int; // the index in the tome if this is a tome spell, equal to the read-ahead tax
	public final taxCount:Int; // the amount of taxed tier-0 ingredients you gain from learning this spell
	public var castable:Bool; // 1 if this is a castable player spell
	public final repeatable:Bool; // 1 if this is a repeatable player spell
	public var potionValue = 0;

	public function new( actionId:Int, actionType:ActionType, delta0 = 0, delta1 = 0, delta2 = 0, delta3 = 0, price = 0, tomeIndex = 0, taxCount = 0, castable = false, repeatable = false ) {
		this.actionId = actionId;
		this.actionType = actionType;
		this.delta = [delta0, delta1, delta2, delta3];
		this.price = price;
		this.tomeIndex = tomeIndex;
		this.taxCount = taxCount;
		this.castable = castable;
		this.repeatable = repeatable;

		if( actionType == Brew ) potionValue = getPotionValue();
	}

	public static function createType( s:String ) {
		return switch s {
			case "BREW": Brew;
			case "CAST": Cast;
			case "OPPONENT_CAST": OpponentCast;
			case "LEARN": Learn;
			case s: throw 'Error: no actionType $s';
		}
	}

	public static function createDefault() {
		return new Action( -1, Wait );
	}

	public function checkDoable( player:Player ) {
		return switch actionType {
			case Nothing: false;
			case Brew: checkBrewable( player );
			case Cast: checkCastable( player );
			case Learn: checkLearnable( player );
			case OpponentCast: false;
			case Rest, Wait: true;
		}
	}

	public function checkBrewable( player:Player ) {
		return player.inventory[0] + delta[0] >= 0
		&& player.inventory[1] + delta[1] >= 0
		&& player.inventory[2] + delta[2] >= 0
		&& player.inventory[3] + delta[3] >= 0;
	}

	public function checkCastable( player:Player ) {
		return inventoryChange() <= player.space
		&& player.inventory[0] + delta[0] >= 0
		&& player.inventory[1] + delta[1] >= 0
		&& player.inventory[2] + delta[2] >= 0
		&& player.inventory[3] + delta[3] >= 0
		&& castable;
	}

	public function checkLearnable( player:Player ) {
		return inventoryChange() <= player.space
		&& player.inventory[0] + delta[0] >= 0
		&& player.inventory[1] + delta[1] >= 0
		&& player.inventory[2] + delta[2] >= 0
		&& player.inventory[3] + delta[3] >= 0
		&& castable;
	}

	public function inventoryChange() {
		return delta.fold(( d, sum ) -> d + sum, 0 );
	}

	inline function getPotionValue() {
		return -delta[0] - delta[1] * V1 - delta[2] * V2 - delta[3] * V3;
	}

	public function toString() {
		return 'actionId: $actionId, actionType: $actionType, delta: $delta, price: $price, tomeIndex: $tomeIndex, taxCount: $taxCount${castable ? ", castable" : ""}${repeatable ? ", repeatable" : ""}';
	}
	
	// public function toString() {
	// 	return '$actionId $actionType $delta $price $tomeIndex $taxCount${castable ? "1" : " "}${repeatable ? "1" : " "}';
	// }

	public function type() {
		return switch actionType {
			case Nothing: throw "Error: Nothing is no valid input";
			case Brew: "BREW";
			case Cast: "CAST";
			case OpponentCast: "OPPONENT_CAST";
			case Learn: "LEARN";
			case Rest: "REST";
			case Wait: "WAIT";
		}
	}

	public function clone() {
		return new Action( actionId, actionType, delta[0], delta[1], delta[2], delta[3], price, tomeIndex, taxCount, castable, repeatable );
	}
	
}

enum ActionType {
	Nothing;
	Brew;
	Cast;
	OpponentCast;
	Learn;
	Rest;
	Wait;
}