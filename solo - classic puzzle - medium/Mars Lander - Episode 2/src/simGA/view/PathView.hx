package simGA.view;

import h2d.Graphics;
import simGA.data.AgentPath;

class PathView {
	
	final g:Graphics;
	var agentPaths:Array<AgentPath>;
	var startX:Int;
	var startY:Int;

	public function new( g:Graphics ) {
		this.g = g;
	}

	public function reset( startX:Int, startY:Int, agentPaths:Array<AgentPath> ) {
		this.startX = startX;
		this.startY = startY;
		this.agentPaths = agentPaths;
	}

	public function draw( zero:Int, scaleFactor:Float ) {
		g.clear();
		for( path in agentPaths ) {
			g.lineStyle( 1, path.color );
			g.moveTo( startX * scaleFactor,( zero - startY ) * scaleFactor );
			
			var x = startX;
			var y = startY;
			final positions = path.positions;
			for( i in 0...positions.length ) {
				var nx = positions[i].x;
				var ny = positions[i].y;
				if( nx != x || ny != y ) {
					g.lineTo( nx * scaleFactor, ( zero - ny ) * scaleFactor );
					x = nx;
					y = ny;
				}
			}
		}
	}

}