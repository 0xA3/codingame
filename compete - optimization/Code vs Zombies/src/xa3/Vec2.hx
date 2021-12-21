package xa3;

@:structInit class Vec2 {
	
	var x:Int;
	var y:Int;

	public inline function lengthSq() {
		return x * x + y * y;
	}

	public inline function length() {
		return Math.sqrt( lengthSq() );
	}

	public inline function normalize() {
		var k = lengthSq();
		if( k < hxd.Math.EPSILON ) k = 0 else k = invSqrt( k );
		x *= k;
		y *= k;
	}

	public static inline function invSqrt( v:Int ) return 1. / Math.sqrt( v );
	
	public inline function multiply( v:Int ) {
		x *= v;
		y *= v;
	}

	public inline function setLength( v:Int ) {
		normalize();
		multiply( v );
	}


}