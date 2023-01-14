package viewer;

import h2d.Object;
import view.Coord;
import viewer.GameView.sX;
import viewer.GameView.sY;

using xa3.MathUtils;

class ShieldSpellView {
	
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
			object.alpha = frame < start + 1 ? subFrame : 1;
			final scale = frame < start + 1 ? frame.map( start, start + 1, 0.15, 1 ) : 1;
			object.scaleX = object.scaleY = scale;
			
			final posIndex = intFrame - start;
			final nextIndex = ( posIndex + 1 ).min( positions.length - 1 );
			final currentPos = positions[posIndex];
			final nextPos = positions[nextIndex];
			place( currentPos, nextPos, subFrame );

		} else if( frame <= end + 1 ) {
			object.visible = true;
			object.alpha = 1 - subFrame;
			final pos = positions[positions.length - 1];
			object.x = sX( pos.x );
			object.y = sY( pos.y );
		} else {
			object.visible = false;
		}
	}

	function place( currentPos:Coord, nextPos:Coord, subFrame:Float ) {
		final easedSubFrame = MathUtils.quadEaseInOut( subFrame );
		
		final x = MathUtils.interpolate( currentPos.x, nextPos.x, easedSubFrame);
		final y = MathUtils.interpolate( currentPos.y, nextPos.y, easedSubFrame );
		
		object.x = sX( x );
		object.y = sY( y );
	}
}