package ai.data;

class Inventory {
	
	var lemon = 0;
	var plum = 0;
	var apple = 0;
	var banana = 0;
	var iron = 0;
	var wood = 0;

	public function new() {	}

	public function update( lemon:Int, plum:Int, apple:Int, banana:Int, iron:Int, wood:Int ) {
		this.lemon = lemon;
		this.plum = plum;
		this.apple = apple;
		this.banana = banana;
		this.iron = iron;
		this.wood = wood;
	}
}