package game.data;

using Lambda;

class Action {
	
	static inline var MAX_INVENTORY = 10;

	public final actionId:Int; // the unique ID of this spell or recipe
	public final actionType:ActionType; // CAST, OPPONENT_CAST, LEARN, BREW
	public final delta0:Int; // tier-0 ingredient change
	public final delta1:Int; // tier-0 ingredient change
	public final delta2:Int; // tier-0 ingredient change
	public final delta3:Int; // tier-0 ingredient change
	public final price:Int; // the price in rupees if this is a potion
	public final tomeIndex:Int; // the index in the tome if this is a tome spell, equal to the read-ahead tax
	public final taxCount:Int; // the amount of taxed tier-0 ingredients you gain from learning this spell
	public final castable:Bool; // 1 if this is a castable player spell
	public final repeatable:Bool; // 1 if this is a repeatable player spell

	public function new( actionId:Int, actionType:ActionType, delta0 = 0, delta1 = 0, delta2 = 0, delta3 = 0, price = 0, tomeIndex = 0, taxCount = 0, castable = false, repeatable = false ) {
		this.actionId = actionId;
		this.actionType = actionType;
		this.delta0 = delta0;
		this.delta1 = delta1;
		this.delta2 = delta2;
		this.delta3 = delta3;
		this.price = price;
		this.tomeIndex = tomeIndex;
		this.taxCount = taxCount;
		this.castable = castable;
		this.repeatable = repeatable;

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

	public function checkDoable( inv0:Int, inv1:Int, inv2:Int, inv3:Int, times:Int ) {
		return switch actionType {
			case Brew: checkBrewable( inv0, inv1, inv2, inv3 );
			case Cast: checkCastable( inv0, inv1, inv2, inv3, times );
			case Learn: checkLearnable( inv0 );
			case OpponentCast: false;
			case Rest: true;
			case Wait: false; // don't clone wait actions
		}
	}

	inline function checkBrewable( inv0:Int, inv1:Int, inv2:Int, inv3:Int ) {
		return inv0 + delta0 >= 0
		&& inv1 + delta1 >= 0
		&& inv2 + delta2 >= 0
		&& inv3 + delta3 >= 0;
	}

	inline function checkCastable( inv0:Int, inv1:Int, inv2:Int, inv3:Int, times:Int ) {
		return castable
		&& inv0 + delta0 * times >= 0
		&& inv1 + delta1 * times >= 0
		&& inv2 + delta2 * times >= 0
		&& inv3 + delta3 * times >= 0
		&& inv0 - tomeIndex * times >= 0
		&& inventorySum( inv0, inv1, inv2, inv3 ) + inventoryChange( times ) <= MAX_INVENTORY;
	}

	inline function checkLearnable( inv0:Int ) {
		return inv0 >= tomeIndex;
	}

	inline function inventorySum( inv0:Int, inv1:Int, inv2:Int, inv3:Int ) {
		return inv0 + inv1 + inv2 + inv3;
	}
	inline function inventoryChange( times:Int ) {
		// trace( 'inventoryChange ${( delta0 + delta1 + delta2 + delta3 ) * times}' );
		return ( delta0 + delta1 + delta2 + delta3 ) * times;
	}

	public function toString() {
		return 'actionId: $actionId, actionType: $actionType, delta0: $delta0, delta1: $delta1, delta2: $delta2, delta3: $delta3, price: $price, tomeIndex: $tomeIndex, taxCount: $taxCount${castable ? ", castable" : ""}${repeatable ? ", repeatable" : ""}';
	}
	
	// public function toString() {
	// 	return '$actionId $actionType $delta $price $tomeIndex $taxCount${castable ? "1" : " "}${repeatable ? "1" : " "}';
	// }

	public function type() {
		return switch actionType {
			case Brew: "BREW";
			case Cast: "CAST";
			case OpponentCast: "OPPONENT_CAST";
			case Learn: "LEARN";
			case Rest: "REST";
			case Wait: "WAIT";
		}
	}

	public function convertToCastAction() {
		return new Action( actionId, Cast, delta0, delta1, delta2, delta3, price, tomeIndex, taxCount, true, repeatable );
	}

	public function setCastable() {
		return new Action( actionId, actionType, delta0, delta1, delta2, delta3, price, tomeIndex, taxCount, true, repeatable );
	}
	
	public function setUncastable() {
		return new Action( actionId, actionType, delta0, delta1, delta2, delta3, price, tomeIndex, taxCount, false, repeatable );
	}
	
	public function reduceTomeIndex() {
		return new Action( actionId, actionType, delta0, delta1, delta2, delta3, price, tomeIndex - 1, taxCount, castable, repeatable );
	}

	public function clone() {
		return new Action( actionId, actionType, delta0, delta1, delta2, delta3, price, tomeIndex, taxCount, castable, repeatable );
	}

}

enum ActionType {
	Brew;
	Cast;
	OpponentCast;
	Learn;
	Rest;
	Wait;
}