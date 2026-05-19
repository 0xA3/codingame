package ai.data;
import CodinGame.printErr;
import Std.parseInt;
import ai.data.TFruit;

class Inventory {
	
	public var plum = 0;
	public var lemon = 0;
	public var apple = 0;
	public var banana = 0;
	public var iron = 0;
	public var wood = 0;

	public var fruitSum = 0;

	public function new() {	}

	public function update( values:Array<String> ) {
		plum = parseInt( values[0] );
		lemon = parseInt( values[1] );
		apple = parseInt( values[2] );
		banana = parseInt( values[3] );
		iron = parseInt( values[4] );
		wood = parseInt( values[5] );

		fruitSum = plum + lemon + apple + banana;
	}

	public function reduceTrainingCosts( trollCount:Int, speed:Int, carry:Int, harvest:Int, chop:Int ) {
		final plumCost = trollCount + speed * speed;
		final lemonCost = trollCount + carry * carry;
		final appleCost = trollCount + harvest * harvest;
		final ironCost = trollCount + chop * chop;
		
		this.plum -= plumCost;
		this.lemon -= lemonCost;
		this.apple -= appleCost;
		this.iron -= ironCost;
		printErr( 'training costs: plums $plumCost lemons $lemonCost apples $appleCost iron $ironCost' );
	}

	public function getFruit( fruit:TFruit ) {
		switch fruit {
			case PLUM: return plum;
			case LEMON: return lemon;
			case APPLE: return apple;
			case BANANA: return banana;
			default: return plum + lemon + apple + banana;
		}
	}
	public function getAnyFruit() {
		if( plum > 0 ) return TFruit.PLUM;
		if( lemon > 0 ) return TFruit.LEMON;
		if( apple > 0 ) return TFruit.APPLE;
		if( banana > 0 ) return TFruit.BANANA;
		return TFruit.NONE;
	}

	public function getFruitAmounts() {
		final fruits = [
			{ fruit: PLUM, amount: plum },
			{ fruit: LEMON, amount: lemon },
			{ fruit: APPLE, amount: apple },
			{ fruit: BANANA, amount: banana }
		];
		
		fruits.sort(( a, b ) -> a.amount - b.amount );

		return fruits;
	}

	public function toString() return 'plum $plum lemon $lemon apple $apple banana $banana iron $iron wood $wood';
}