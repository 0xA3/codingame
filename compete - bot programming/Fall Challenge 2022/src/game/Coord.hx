package game;

import haxe.ds.HashMap;
import xa3.MathUtils.abs;
import xa3.MathUtils.max;

class Coord {
	
	public static final NO_COORD = new Coord( -1, -1 );

	public final x:Int;
	public final y:Int;

	public function new( x:Int, y:Int ) {
		this.x = x;
		this.y = y;
	}

	public function euclideanTo( x:Int, y:Int ) {
		return Math.sqrt( sqrEuclideanTo( x, y ));
	}

	public function sqrEuclideanTo( x:Float, y:Float ) {
		return Math.pow( x - this.x, 2 ) + Math.pow( y - this.y, 2 );
	}

	public function add( x:Int, y:Int ) return new Coord( this.x + x, this.y + y );

	public function addCoord( c:Coord ) return add( c.x, c.y );

	public function hashCode() {
		final prime = 31;
		var result = 1;
		result = prime * result + x;
		result = prime * result + y;
		return result;
	}

	public function equals( obj:Coord ) {
		if( this == obj ) return true;
		if( obj == null ) return false;
		final other = obj;
		if( x != other.x ) return false;
		if( y != other.y ) return false;
		return true;
	}

	public function toString() return "(" + x + "," + y + ")";

	public function manhattanToCoord( other:Coord ) return manhattanTo( other.x, other.y );

	public function chebyshevTo( x:Int, y:Int ) {
		return max( abs( x - this.x ), abs( y - this.y ));
	}

	public function manhattanTo( x:Int, y:Int ) {
		return abs( x - this.x ) + abs( y - this.y );
	}

	public static function compute<V>( map:HashMap<Coord, V>, key:Coord, remappingFunction:( k:Coord, v:V )->Null<V> ) {
		final result = try {
			remappingFunction( key, map[key] );
		} catch( e:Dynamic ) {
			throw e;
		}
		if( result == null ) map.remove( key );
		else map.set( key, result );
	}
}