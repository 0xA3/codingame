package ai.data;

import Std.int;
import ai.data.TFruit;
import xa3.math.Pos;

using xa3.math.IntMath;

typedef TreeProperties = {
	final cooldown:Int;
	final cooldownNearWater:Int;
	final healths:Array<Int>;
}

class Tree {
	
	public static final NO_TREE = new Tree( "NONE", Pos.NO_POS );
	
	final treesProperties:Map<TFruit, TreeProperties> = [
		NONE => { cooldown: 0, cooldownNearWater: 0, healths: [0, 0, 0, 0] },
		PLUM => { cooldown: 8, cooldownNearWater: 3, healths: [6, 8, 10, 12] },
		LEMON => { cooldown: 8, cooldownNearWater: 3, healths: [6, 8, 10, 12] },
		APPLE => { cooldown: 9, cooldownNearWater: 2, healths: [11, 14, 17, 20] },
		BANANA => { cooldown: 6, cooldownNearWater: 4, healths: [3, 4, 5, 6] }
	];

	public final type:TFruit;
	public final pos:Pos;
	final properties:TreeProperties;

	public var size = 0;
	public var health = 0;
	public var fruits = 0;
	public var cooldown = 0;
	public var isNearWater = false;

	public function new( sType:String, pos:Pos ) {
		this.type = convertType( sType );
		this.pos = pos;
		this.properties = treesProperties[this.type];
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

	public function update( size:Int, health:Int, fruits:Int, cooldown:Int, isNearWater:Bool ) {
		this.size = size;
		this.health = health;
		this.fruits = fruits;
		this.cooldown = cooldown;
		this.isNearWater = isNearWater;
	}

	/**
	 * Calculates the tree size after a given number of frames.
	 *
	 * @param frames Number of frames to project forward (default: 0)
	 * @return The projected tree size after the given frames
	 */
	public function getSizeAfter( frames = 0 ) {
		if( frames <= 0 ) return size;
		final cycles = getCycles( frames );
		
		return ( size + cycles ).min( 4 );
	}

	public function getHealthAfter( frames = 0 ) {
		if( frames <= 0 ) return health;
		final cycles = getCycles( frames );
		
		return properties.healths[( size + cycles ).min( 4 ) - 1];
	}

	public function getFruitsAfter( frames = 0 ) {
		if( frames <= 0 ) return fruits;
		final cycles = getCycles( frames );
		
		return ( size + fruits + cycles - 4 ).min( 3 ).max( 0 );
	}

	public function getCooldownAfter( frames = 0 ) {
		// Use the appropriate cooldown based on water proximity
		final effectiveCooldown = isNearWater ? properties.cooldownNearWater : properties.cooldown;
		
		// Guard against invalid cooldown values
		if( effectiveCooldown <= 0 ) return 0;
		
		// Calculate cooldown after frames, wrapping around where 0 becomes max cooldown
		var remaining = ( cooldown - frames ) % effectiveCooldown;
		if( remaining < 0 ) remaining += effectiveCooldown;
		return remaining == 0 ? effectiveCooldown : remaining;
	}

	function getCycles( frames:Int ) {
		// Use the appropriate cooldown based on water proximity
		final effectiveCooldown = isNearWater ? properties.cooldownNearWater : properties.cooldown;
		
		// Guard against invalid cooldown values
		if (effectiveCooldown <= 0) return 0;
		
		// Calculate remaining frames until next cycle
		final remainingFrames = effectiveCooldown - cooldown;
		
		// Calculate number of complete cycles using integer division
		final cycles = int(( frames + remainingFrames) / effectiveCooldown );
		
		return cycles;
	}

}
