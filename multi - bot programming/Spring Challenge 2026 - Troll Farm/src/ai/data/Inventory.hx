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

	public function toString() return 'plum $plum lemon $lemon apple $apple banana $banana iron $iron wood $wood';
}