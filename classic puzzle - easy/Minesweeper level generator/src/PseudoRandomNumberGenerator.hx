class PseudoRandomNumberGenerator {
	
	final uInt32Max = Math.pow( 2, 32 );

	var r:Float;
	
	public function new( seed:Int ) r = seed;

	public function random() {
		return r = Math.ffloor((( 214013 * r + 2531011 ) % uInt32Max ) / 65536 ) ;
	}
}