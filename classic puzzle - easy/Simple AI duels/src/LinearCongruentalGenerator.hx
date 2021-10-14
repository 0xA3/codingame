import Dec2Bin.dec2bin;

class LinearCongruentalGenerator {
	
	var x:Int;

	public function new( seed:Int ) {
		x = seed;
	}
	
	public function rand() {
		x = ( 137 * x + 187 ) % 256;
		final bin = dec2bin( x );
		final ones = bin.filter( v -> v == 1 ).length;
		return ones % 2;
	}
}