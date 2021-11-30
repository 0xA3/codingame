package simGA.view;

import h2d.Graphics;
import simGA.data.SurfaceCoords;

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
		for( position in surfaceCoords.coords ) g.lineTo( position.x * scaleFactor, ( zero - position.y ) * scaleFactor );
	}
}