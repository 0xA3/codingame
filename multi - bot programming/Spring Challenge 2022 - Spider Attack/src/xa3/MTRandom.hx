package xa3;

/**
 * ...
 * @author Stephen Calendar
 */
class MTRandom {
	
	static var maxRange:Float;
	//Mersenne Twister variables
	public static var MT:Array<Int> = [];
	public static var indexMT:Int;
	//—————————————————————————————
	//***************************************************************************************

	//—————————————————————
	//these functions compose the algorithm for a Mersenne Twister
	//see http://en.wikipedia.org/wiki/Mersenne_twister
	//This is a MT19937 implementation
	//named because it has a proven 2^19937 – 1 period (approx 4.3 * 10^6001)
	//(w, m, n, r) = (32, 624, 397, 31)
	//a = 0x9908B0DF
	//u = 11
	//(s, b) = (7, 0x9D2C5680)
	//(t, c) = (15, 0xEFC60000)
	//l = 18
	//it generates numbers in the range 0 to 2^32 – 1
	//—————————————————————-

	//while MT is the ‘best’ random number generator, it is considerably slower
	//then Flash’s Math.random()

	public static function initializeRandGenerator(seed:Int):Void {
		
		maxRange = Math.pow(2, 32);
		//the seed can be any positive integer
		indexMT = 624;
		MT[0] = seed;
	  
		for(i in 1...624){
			MT[i] = Std.int(0xFFFFFFFF & (0x6C078965 * (MT[i-1] ^ (MT[i-1] >>> 30)) + i));
		}
	}

	public static function quickRand():Float {
		
		if(indexMT == 624){
			indexMT = 0;
			generateRands();
		}
	  
		var y:Int = MT[indexMT];
		y = y ^ (y >>> 11);
		y = y ^ ((y << 7) & 0x9D2C5680);
		y = y ^ ((y << 15) & 0xEFC60000);
		y = y ^ (y >>> 18);
		indexMT++;
		return (y / MTRandom.maxRange) + 0.5;
	}

	public static function quickIntRand( max:Int ):Int {
		return Math.floor( quickRand() * max );
	}

	static function generateRands():Void {
		
		var i:Int;
		var y:Int;
		for(i in 0...227) {
			//y = (0×80000000 & MT[i]) + (0x7FFFFFFF & (MT[i+1]));
			y = (0x80000000 & MT[i]) + (0x7FFFFFFF & (MT[i+1]));
			//MT[i] = MT[i + 397] ^ (y >>> 1) ^ ((y & 0×1) * 0x9908B0DF);
			MT[i] = MT[i + 397] ^ (y >>> 1) ^ ((y & 0x1) * 0x9908B0DF);
		}
		//special case for i + 397 > 624 to avoid a mod operator
		for(i in 227...623){
			//y = (0×80000000 & MT[i]) + (0x7FFFFFFF & (MT[i+1]));
			y = (0x80000000 & MT[i]) + (0x7FFFFFFF & (MT[i+1]));
			//MT[i] = MT[i - 227] ^ (y >>> 1) ^ ((y & 0×1) * 0x9908B0DF);
			MT[i] = MT[i - 227] ^ (y >>> 1) ^ ((y & 0x1) * 0x9908B0DF);
		}
		//special case for last value, to avoid mod operator
		//y = (0×80000000 & MT[623]) + (0x7FFFFFFF & (MT[0]));
		y = (0x80000000 & MT[623]) + (0x7FFFFFFF & (MT[0]));
		//MT[623] = MT[396] ^ (y >>> 1) ^ ((y & 0×1) * 0x9908B0DF);
		MT[623] = MT[396] ^ (y >>> 1) ^ ((y & 0x1) * 0x9908B0DF);
	  
	}

	//***************************************************************************************
	//—————————————————————————————}
}