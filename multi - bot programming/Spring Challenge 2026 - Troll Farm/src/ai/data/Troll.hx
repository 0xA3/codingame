package ai.data;

import xa3.math.Pos;

class Troll {
	
	public final id:Int;
	public final player:Int;

	public var pos = Pos.NO_POS;
	public var movementSpeed = 0;
	public var carryCapacity = 0;
	public var harvestPower = 0;
	public var chopPower = 0;
	public var carryPlum = 0;
	public var carryLemon = 0;
	public var carryApple = 0;
	public var carryBanana = 0;
	public var carryIron = 0;
	public var carryWood = 0;

	public var carrySum = 0;

	public function new( id:Int, player:Int ) {
		this.id = id;
		this.player = player;
	}

	public function update(
		pos:Pos,
		movementSpeed:Int,
		carryCapacity:Int,
		harvestPower:Int,
		chopPower:Int,
		carryPlum:Int,
		carryLemon:Int,
		carryApple:Int,
		carryBanana:Int,
		carryIron:Int,
		carryWood:Int
	) {
		this.pos = pos;
		this.movementSpeed = movementSpeed;
		this.carryCapacity = carryCapacity;
		this.harvestPower = harvestPower;
		this.chopPower = chopPower;
		this.carryPlum = carryPlum;
		this.carryLemon = carryLemon;
		this.carryApple = carryApple;
		this.carryBanana = carryBanana;
		this.carryIron = carryIron;
		this.carryWood = carryWood;

		carrySum = carryPlum + carryLemon + carryApple + carryBanana + carryIron + carryWood;
	}

	public function getFruit() {
		if( carryPlum > 0 ) return TFruit.PLUM;
		if( carryLemon > 0 ) return TFruit.LEMON;
		if( carryApple > 0 ) return TFruit.APPLE;
		if( carryBanana > 0 ) return TFruit.BANANA;
		return TFruit.NONE;
	}
}