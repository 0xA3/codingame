class Random {
	static inline function fract( x:Float ) return x - Math.floor( x );
	
	public static function random( seed:Int, range:Int ) {
		final f = fract( Math.sin( seed ) * 10000 ) * 0.9999;
		final i = Std.int( f * range );
		return i;
	}
}