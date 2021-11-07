package sim.view;

import h2d.Graphics;
import sim.data.SurfaceCoords;

class Surface {

	final g:Graphics;
	final surfaceCoords:SurfaceCoords;
	
	public function new( g:Graphics, surfaceCoords:SurfaceCoords ) {
		this.g = g;
		this.surfaceCoords = surfaceCoords;
	}

	public function draw( zero:Int, scaleFactor:Float ) {
		g.clear();
		g.lineStyle( 1, 0xff0000 );
		for( xy in surfaceCoords.coords ) g.lineTo( xy[0] * scaleFactor, ( zero - xy[1] ) * scaleFactor );
	}
}