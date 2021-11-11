package sim.view;

import h2d.Graphics;
import haxe.ds.Vector;
import sim.data.AgentPath;

class PathView {
	
	final g:Graphics;
	var agentPaths:Vector<AgentPath>;
	var startX:Int;
	var startY:Int;

	public function new( g:Graphics ) {
		this.g = g;
	}

	public function init( startX:Int, startY:Int, agentPaths:Vector<AgentPath> ) {
		this.startX = startX;
		this.startY = startY;
		this.agentPaths = agentPaths;
	}

	public function draw( zero:Int, scaleFactor:Float ) {
		g.clear();
		g.lineStyle( 1, 0x666666 );
		for( path in agentPaths ) {
			if( path.length == 0 ) continue;
			g.moveTo( startX * scaleFactor,( zero - startY ) * scaleFactor );
			for( i in 0...path.length ) {
				g.lineTo( path[i].x * scaleFactor, ( zero - path[i].y ) * scaleFactor );
			}
		}
	}

}