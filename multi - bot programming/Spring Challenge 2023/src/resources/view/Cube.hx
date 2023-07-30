package resources.view;

@:structInit class Cube {

	public final q:Int;
	public final r:Int;
	public final s:Int;

	public static function axialToCube( hex:Hex ):Cube {
		final q = hex.q;
		final r = hex.r;
		final s = -q - r;
		
		return { q: q, r: r, s: s }
	}
	
	public static function cubeRound( frac: Cube ):Cube {
		var q = Math.round( frac.q );
		var r = Math.round( frac.r );
		var s = Math.round( frac.s );
	  
		final qDiff = Math.abs( q - frac.q );
		final rDiff = Math.abs( r - frac.r );
		final sDiff = Math.abs( s - frac.s );
	  
		if( qDiff > rDiff && qDiff > sDiff ) {
		  q = -r - s;
		} else if( rDiff > sDiff ) {
		  r = -q - s;
		} else {
		  s = -q - r;
		}
	  
		return { q: q, r: r, s: s }
	}
}
