package ai.data;

class Inventory {
	
	public var plum = 0;
	public var lemon = 0;
	public var apple = 0;
	public var banana = 0;
	public var iron = 0;
	public var wood = 0;

	public function new() {	}

	public function update( plum:Int, lemon:Int, apple:Int, banana:Int, iron:Int, wood:Int ) {
		this.plum = plum;
		this.lemon = lemon;
		this.apple = apple;
		this.banana = banana;
		this.iron = iron;
		this.wood = wood;
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

	public function toString() return 'plum $plum lemon $lemon apple $apple banana $banana iron $iron wood $wood';
}