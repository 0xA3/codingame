package viewer;

import Math.max;
import Math.min;
import Std.int;
import h2d.Object;
import view.Coord;
import viewer.GameView.sX;
import viewer.GameView.sY;
import xa3.MathUtils;

class CharacterView {

	public final container:Object;
	public final infoContainer:Object;
	public final object:Object;
	public final angleOffset:Float;
	public final positions:Array<Coord> = [];

	var x( default, null ) = 0.0;
	var y( default, null ) = 0.0;
	public var isVisible( get, set ):Bool;
	function get_isVisible() return container.visible;
	function set_isVisible( v:Bool ) return container.visible = v;

	var prevPos:Coord;
	var currentPos:Coord;
	var nextPos:Coord;

	public function new( container:Object, infoContainer:Object, object:Object, direction:TDirection ) {
		this.container = container;
		this.infoContainer = infoContainer;
		this.object = object;
		switch direction {
			case Up: angleOffset = 0;
			case Down: angleOffset = Math.PI;
		}
	}
	
	public function show() container.visible = true;
	public function hide() container.visible = false;

	public function update( frame:Float, intFrame:Int, subFrame:Float ) {
		if( !container.visible ) return;
		
		if( positions[intFrame] == null ) return;
		
		final previousFrame = int( max( 0, intFrame - 1 ));
		final nextFrame = int( min( positions.length - 1, intFrame + 1 ));
		
		currentPos = positions[intFrame];
		prevPos = positions[previousFrame] == null ? currentPos : positions[previousFrame];
		nextPos = positions[nextFrame] == null ? currentPos : positions[nextFrame];

		place( prevPos, currentPos, nextPos, subFrame );
	}
	
	public function rotate( angle:Float ) object.rotation = angle + angleOffset;
	
	function place( prevPos:Coord, currentPos:Coord, nextPos:Coord, subFrame:Float ) {
		final dx1 = currentPos.x - prevPos.x;
		final dy1 = currentPos.y - prevPos.y;
		final dx2 = nextPos.x - currentPos.x;
		final dy2 = nextPos.y - currentPos.y;
		
		final easedRotation = MathUtils.quadEaseInOut( Math.min( 1, subFrame * 3 ));
		final easedSubFrame = MathUtils.quadEaseInOut( subFrame );
		
		final angle1 = MathUtils.angle( dx1, dy1 );
		final angle2 = MathUtils.angle( dx2, dy2 );
		final angle = MathUtils.interpolate( angle1, angle2, easedRotation );// + ( isAttacking ? subFrame * TAU : 0 );
		if( dx2 != 0 || dy2 != 0 ) rotate( angle );

		final x = MathUtils.interpolate( currentPos.x, nextPos.x, easedSubFrame);
		final y = MathUtils.interpolate( currentPos.y, nextPos.y, easedSubFrame );
		
		container.x = this.x = sX( x );
		container.y = this.y = sY( y );
	}
}