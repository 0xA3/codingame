package ai.data;

import ai.data.TFruit;
import xa3.math.Pos;

class Tree {
	
	public static final NO_TREE = new Tree( "NONE", Pos.NO_POS );
	
	public final type:TFruit;
	public final pos:Pos;
	public var size:Int;
	public var health:Int;
	public var fruits:Int;
	public var cooldown:Int;

	public function new( sType:String, pos:Pos ) {
		this.type = convertType( sType );
		this.pos = pos;
		this.size = 0;
		this.health = 0;
		this.fruits = 0;
		this.cooldown = 0;
	}

	public function convertType( sType:String ) {
		switch( sType ) {
			case "NONE": return TFruit.NONE;
			case "PLUM": return TFruit.PLUM;
			case "LEMON": return TFruit.LEMON;
			case "APPLE": return TFruit.APPLE;
			case "BANANA": return TFruit.BANANA;
			default: throw 'Error: Unknown tree type: $sType';
		}
	}

	public function update( size:Int, health:Int, fruits:Int, cooldown:Int ) {
		this.size = size;
		this.health = health;
		this.fruits = fruits;
		this.cooldown = cooldown;
	}

}