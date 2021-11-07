package sim.view;

import h2d.Graphics;
import haxe.ds.Vector;
import sim.data.AgentPath;

class PathView {
	
	final g:Graphics;
	final agentPaths:Vector<AgentPath>;

	public function new( g:Graphics, agentPaths:Vector<AgentPath> ) {
		this.g = g;
		this.agentPaths = agentPaths;
	}

	public function draw( zero:Int, scaleFactor:Float ) {
		g.clear();
		g.lineStyle( 1, 0x666666 );
		for( position in agentPaths ) {
			if( position.length == 0 ) continue;
			for( position in position ) g.lineTo( position.x * scaleFactor, ( zero - position.y ) * scaleFactor );
		}
	}
}