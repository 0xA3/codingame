package simGA.view;

import h2d.Bitmap;
import h2d.Object;
import simGA.data.Agent;


class Rocket {
	
	static inline var gravity = -3.711;
	static final PIq = Math.PI / 2;

	final obj:Object;
	final rocket:Bitmap;
	final flame1:Bitmap;
	final flame2:Bitmap;
	final explosion:Bitmap;

	public function new( obj:Object, rocket:Bitmap, flame1:Bitmap, flame2:Bitmap, explosion:Bitmap ) {
		this.obj = obj;
		this.rocket = rocket;
		this.flame1 = flame1;
		this.flame2 = flame2;
		this.explosion = explosion;
	}

	public function reset() {
		explosion.visible = false;
		rocket.visible = true;
	}

	public function update( agent:Agent, zero:Int, scaleFactor:Float ) {
		obj.scaleX = obj.scaleY = scaleFactor * 2;
		obj.rotation = -agent.rotate / 180 * Math.PI;
		obj.x = agent.x * scaleFactor;
		obj.y = ( zero - agent.y ) * scaleFactor;
		flame2.visible = agent.power > 0;
		flame2.scaleY = agent.power;

		if( agent.isExploded ) explode();
		if( agent.isLost ) lose();
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

}