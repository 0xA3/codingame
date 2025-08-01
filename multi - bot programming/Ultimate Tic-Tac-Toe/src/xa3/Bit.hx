package xa3;

class Bit {
	
	extern public static inline function getBit( n:Int, pos:Int ) {
  		return n & ( 1 << pos );
	}

	extern public static inline function setBit( n:Int, pos:Int ) {
  		return n | ( 1 << pos );
	}
}
