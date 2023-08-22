package resources.view;

import gameengine.view.core.Utils.fitAspectRatio;
import gameengine.view.core.Utils.lerpAngle;
import h2d.Anim;
import h2d.Font;
import resources.view.pixi.Container;
import resources.view.pixi.Sprite;
import resources.view.pixi.Text;
import xa3.MathUtils;

using Lambda;

function setAnimationProgress( fx:Anim, progress:Float ) {
	var idx = Math.floor( progress * fx.frames.length );
	idx = MathUtils.min( fx.frames.length - 1, idx );
	fx.currentFrame = idx;
}

function distance ( a, b ) {
	return Math.sqrt(( a.x - b.x ) * ( a.x - b.x ) + ( a.y - b.y ) * ( a.y - b.y ));
}

function fit( entity:Sprite, maxWidth:Float, maxHeight:Float ) {
	final bounds = entity.getBounds( entity.parent );
	entity.setScale( fitAspectRatio( bounds.width, bounds.height, maxWidth, maxHeight ) );
}

function fitContainer( entity:Container, maxWidth:Float, maxHeight:Float ) {
	final bounds = entity.getBounds( entity.parent );
	entity.setScale( fitAspectRatio( bounds.width, bounds.height, maxWidth, maxHeight ));
}

// function setSize( sprite:Container, size:Float ) {
// 	sprite.width = size;
// 	sprite.height = size;
// }

function bounce( t:Float ):Float {
	return 1 + ( Math.sin( t * 10 ) * 0.5 * Math.cos( t * 3.14 / 2 )) * ( 1 - t ) * ( 1 - t );
}

function generateText( text:String, color:Int, font:Font ) {
	final drawnText = new Text( font );
	drawnText.textColor = color;
	drawnText.text = text;
	drawnText.anchor.x = 0.5;
	drawnText.anchor.y = 0.5;
	return drawnText;
}

function last<T>( arr:Array<T> ) {
	return arr.length == 0 ? null : arr[arr.length - 1];
}

function keyOf( x:Float, y:Float ) {
	return '${x},${y}';
}

function angleDiff( a:Float, b:Float ):Float {
	return Math.abs( lerpAngle( a, b, 0 ) - lerpAngle( a, b, 1 ));
}

function randomChoice( rand:Float, coeffs:Array<Float> ) {
	final total = coeffs.fold(( a, sum ) -> sum + a, 0 );
	final b = 1 / total;
	final weights = coeffs.map( v -> v * b );
	var cur = 0.0;
	for ( i in 0...weights.length ) {
		cur += weights[i];
		if ( cur >= rand ) {
			return i;
		}
	}
	return 0;
}

function sum( arr:Array<Int> ) {
	return arr.fold(( a, sum ) -> sum + a, 0 );
}

function fsum( arr:Array<Float> ) {
	return arr.fold(( a, sum ) -> sum + a, 0.0 );
}
