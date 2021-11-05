package sim;

import Math.abs;
import Std.parseInt;
import h2d.Bitmap;
import h2d.Graphics;
import h2d.Object;
import h2d.Text;
import h3d.Vector;
import hxd.res.DefaultFont;
import sim.factory.RocketFactory;

class Main extends hxd.App {

	static inline var MAX_X = 7000;
	static inline var MAX_Y = 3000;

	var currentFrame = 0;
	var surface:Surface;
	var rocket:Rocket;
	var marsLander:MarsLander;

	var zero:Int;
	var scaleFactor:Float;
	final force = new Vector();

	var frame = 0.0;
	var counter = 0;

	var isPlaying = true;
	var isSuccess = false;

	static function main() {
		hxd.Res.initEmbed();
		new Main();
	}
	
	override function init() {
		
		final surfaceCoords = [
			[ 0, 100 ],
			[ 1000, 500 ],
			[ 1500, 1500 ],
			[ 3000, 1000 ],
			[ 4000, 150 ],
			[ 5500, 150 ],
			[ 6999, 800 ]
		];

		final surfaceHeight = 3000;
		scaleFactor = 0.3;
		zero = surfaceHeight;

		final g = new Graphics( s2d );
		surface = new Surface( g, surfaceCoords );
		surface.draw( zero, scaleFactor );
		
		rocket = RocketFactory.createRocket( s2d );
		rocket.reset( new Vector( 2500, 2700 ), 550 );
		
		marsLander = new MarsLander( surfaceCoords );
		// tf = new Text( DefaultFont.get(), s2d );
		// tf.x = 20;
		// tf.y = s2d.height - 55;
		// s2d.addChild( tf );

	}

	override function update( dt:Float ) {
		if( !isPlaying ) return;
		frame += dt;
		if( frame < 0.033 ) return;
		frame = 0;
		counter++;

		// trace( 'X=${rocket.x}m, Y=${rocket.y}m, HSpeed=${rocket.hSpeed}m/s VSpeed=${rocket.vSpeed}m/s\nFuel=${rocket.fuel}l, Angle=${rocket.rotate}°, Power=${rocket.power}m/s2' );
		
		final response = marsLander.update( rocket.x, rocket.y, rocket.hSpeed, rocket.vSpeed, rocket.fuel, rocket.rotate, rocket.power );
		final parts = response.split(' ');
		final rotate = parseInt( parts[0] );
		final power = parseInt( parts[1] );
		// trace( response );
		
		rocket.update( dt, rotate, power );
		checkCollision();
		rocket.draw( zero, scaleFactor );
	}

	function checkCollision() {
		
		if( rocket.x >= MAX_X || rocket.x < 0 || rocket.y >= MAX_Y ) {
			rocket.lose();
			isPlaying = false;
		}
		
		if(
			rocket.x >= surface.landX1 &&
			rocket.x <= surface.landX2 &&
			rocket.y <= surface.landY &&
			abs( rocket.hSpeed ) <= 20 &&
			rocket.vSpeed >= -40 &&
			rocket.rotate == 0 ) {
				// trace( 'rocket.x ${rocket.x} landx ${surface.landX1}-${surface.landX2} landy ${surface.landY}' );
				rocket.land();
				isPlaying = false;
				isSuccess = true;
			return;
		}

		for( i in 1...surface.coords.length ) {
			final x1 = surface.coords[i - 1][0];
			final x2 = surface.coords[i][0];
			if( x1 < rocket.x && x2 >= rocket.x ) {
				final xFraction = ( rocket.x - x1 ) / ( x2 - x1 );
				final y1 = surface.coords[i - 1][1];
				final y2 = surface.coords[i][1];
				final surfaceY = y1 + ( y2 - y1 ) * xFraction;
				if( rocket.y <= surfaceY ) {
					rocket.explode();
					isPlaying = false;
				}
				break;
			}
		}
	}
}
