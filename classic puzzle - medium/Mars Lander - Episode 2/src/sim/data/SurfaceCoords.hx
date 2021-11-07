package sim.data;

class SurfaceCoords {
	
	public final coords:Array<Array<Int>>;
	public final landX1 = -1;
	public final landX2 = -1;
	public final landY = -1;

	public function new( coords:Array<Array<Int>> ) {
		this.coords = coords;
		for( i in 1...coords.length ) {
			final c0 = coords[i - 1];
			final c1 = coords[i];
			// trace( '${c0[0]}:${c0[1]} - ${c1[0]}:${c1[1]}' );
			if( c0[1] == c1[1] && c1[0] >= c0[0] + 1000 ) {
				landX1 = c0[0];
				landX2 = c1[0];
				landY = c0[1];
				break;
			}
		}
		if( landY == -1 ) throw 'Error: no landing zone found.';
	}
}