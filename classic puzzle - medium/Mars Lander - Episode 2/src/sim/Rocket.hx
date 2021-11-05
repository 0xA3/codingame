package sim;

import Math.max;
import Math.min;
import Math.round;
import Std.int;
import h2d.Bitmap;
import h2d.Object;
import h3d.Vector;

class Rocket {
	
	static inline var gravity = -3.711;
	static final PIq = Math.PI / 2;

	var pos:Vector;
	var vel:Vector;
	var force:Vector;
	var fRotation = 0.0;

	final obj:Object;
	final rocket:Bitmap;
	final flame1:Bitmap;
	final flame2:Bitmap;
	final explosion:Bitmap;

	public var x( get,never ):Int;
	function get_x() return round( pos.x );
	
	public var y( get,never ):Int;
	function get_y() return round( pos.y );
	
	public var hSpeed( get,never ):Int;
	function get_hSpeed() return round( vel.x );
	
	public var vSpeed( get,never ):Int;
	function get_vSpeed() return round( vel.y );
	
	public var fuel( get, null ):Int;
	function get_fuel() return fuel;
	
	public var rotate( default, null ) = 0;
	public var power( default, null ) = 0;

	public function new( pos:Vector, vel:Vector, force:Vector, obj:Object, rocket:Bitmap, flame1:Bitmap, flame2:Bitmap, explosion:Bitmap ) {
		this.pos = pos;
		this.vel = vel;
		this.force = force;
		this.obj = obj;
		this.rocket = rocket;
		this.flame1 = flame1;
		this.flame2 = flame2;
		this.explosion = explosion;
	}

	public function reset( startPosition:Vector, fuel:Int ) {
		pos = startPosition;
		this.fuel = fuel;
		vel = vel.multiply( 0 );
		explosion.visible = false;
		rocket.visible = true;
	}

	public function update( dt:Float, inRotate:Int, inPower:Int ) {
		
		final deltaRot = inRotate - rotate;
		rotate = deltaRot > 15 ? rotate + 15 : deltaRot < -15 ? rotate - 15 : inRotate;
		
		// power = inPower;
		power = int( min( fuel, inPower ));
		fuel -= power;
		
		this.fRotation = -rotate / 180 * Math.PI;
		final powerX = power * Math.sin( fRotation );
		final powerY = power * Math.cos( fRotation );
		force.x = powerX;
		force.y = gravity + powerY;
		
		vel = vel.add( force );
		pos = pos.add( vel );
	
		flame2.visible = power > 0;
		flame2.scaleY = power;
	}

	public function draw( zero:Int, scaleFactor:Float ) {
		obj.rotation = fRotation;
		var x = pos.x * scaleFactor;
		var y = ( zero - pos.y ) * scaleFactor;
		
		obj.x = x;
		obj.y = pos.y < 0 ? zero * scaleFactor : y;
	}

	public function explode() {
		rocket.visible = false;
		flame2.visible = false;
		explosion.visible = true;
	}

	public function lose() {
		rocket.visible = false;
		flame2.visible = false;
	}

	public function land() {
		flame2.visible = false;
	}

}