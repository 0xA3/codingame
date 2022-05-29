package viewer;

import h2d.Object;
import view.Coord;
import viewer.GameView.sX;
import viewer.GameView.sY;

using xa3.MathUtils;

class ControlMarkerView {
	
	final object:Object;
	public final mobId:Int;
	final start:Int;
	var end:Int;
	public final positions:Array<Coord>;

	public function new( object:Object, mobId:Int, frame:Int, startPos:Coord ) {
		this.object = object;
		this.mobId = mobId;
		start = frame;
		end = frame;
		positions = [startPos];
	}

	public function addPos( frame:Int, pos:Coord ) {
		positions[frame - start] = pos;
		end = frame;
	}
	
	public function update( frame:Float, intFrame:Int, subFrame:Float ) {
		if( frame < start ) object.visible = false;
		else if( frame <= end ) {
			object.visible = true;
			
			final posIndex = intFrame - start;
			final nextIndex = ( posIndex + 1 ).min( positions.length - 1 );
			final currentPos = positions[posIndex];
			final nextPos = positions[nextIndex];
			place( currentPos, nextPos, subFrame );
			
		} else {
			object.visible = false;
		}
	}
	
	public function updateRotation( dt:Float ) {
		if( object.visible ) object.rotation += dt;
	}

	function place( currentPos:Coord, nextPos:Coord, subFrame:Float ) {
		final easedSubFrame = MathUtils.quadEaseInOut( subFrame );
		
		final x = MathUtils.interpolate( currentPos.x, nextPos.x, easedSubFrame);
		final y = MathUtils.interpolate( currentPos.y, nextPos.y, easedSubFrame );
		
		object.x = sX( x );
		object.y = sY( y );
	}
}