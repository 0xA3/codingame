package game.data;

using Lambda;

class Action {
	
	public final actionId:Int; // the unique ID of this spell or recipe
	public final actionType:ActionType; // in the first league: BREW; later: CAST, OPPONENT_CAST, LEARN, BREW
	public final delta:Array<Int>; // tier-0 ingredient change
	public final price:Int; // the price in rupees if this is a potion
	public final tomeIndex:Int; // in the first two leagues: always 0; later: the index in the tome if this is a tome spell, equal to the read-ahead tax
	public final taxCount:Int; // in the first two leagues: always 0; later: the amount of taxed tier-0 ingredients you gain from learning this spell
	public final castable:Bool; // in the first league: always 0; later: 1 if this is a castable player spell
	public final repeatable:Bool; // for the first two leagues: always 0; later: 1 if this is a repeatable player spell
	
	public function new( actionId:Null<Int>, actionType:String, delta0:Int, delta1:Int, delta2:Int, delta3:Int, price:Int, tomeIndex:Int, taxCount:Int, castable:Bool, repeatable:Bool ) {
		this.actionId = actionId;
		this.actionType = createActionType( actionType );
		this.delta = [delta0, delta1, delta2, delta3];
		this.price = price;
		this.tomeIndex = tomeIndex;
		this.taxCount = taxCount;
		this.castable = castable;
		this.repeatable = repeatable;
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

	public function inventoryChange() {
		return delta.fold(( d, sum ) -> d + sum, 0 );
	}

	public function toString() {
		return 'actionId: $actionId, actionType: $actionType, delta: $delta, price: $price, tomeIndex: $tomeIndex, taxCount: $taxCount${castable ? ", castable" : ""}${repeatable ? ", repeatable" : ""}';
	}

	function createActionType( s:String ) {
		return switch s{
			case "BREW": Brew;
			case "CAST": Cast;
			case "OPPONENT_CAST": OpponentCast;
			case "LEARN": Learn;
			case s: throw 'Error: no actionType $s';
		}

	}

	public function type() {
		return switch actionType {
			case Brew: "BREW";
			case Cast: "CAST";
			case OpponentCast: "OPPONENT_CAST";
			case Learn: "LEARN";
		}
	}

	public function copy() {
		return new Action()
	}
	
}

enum ActionType {
	Brew;
	Cast;
	OpponentCast;
	Learn;
}