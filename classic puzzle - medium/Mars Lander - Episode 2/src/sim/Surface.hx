package sim;

import h2d.Graphics;

class Surface {
	
	final g:Graphics;
	public final coords:Array<Array<Int>>;
	public final landX1 = -1;
	public final landX2 = -1;
	public final landY = -1;

	public function new( g:Graphics, coords:Array<Array<Int>> ) {
		this.g = g;
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

	public function draw( zero:Int, scaleFactor:Float ) {
		g.clear();
		g.lineStyle( 1, 0xff0000 );
		for( xy in coords ) g.lineTo( xy[0] * scaleFactor, ( zero - xy[1] ) * scaleFactor );
	}

}