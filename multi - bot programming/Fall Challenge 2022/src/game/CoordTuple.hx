package game;

import haxe.ds.HashMap;

class CoordTuple {
	
	public final a:Coord;
	public final b:Coord;

	public function new( a:Coord, b:Coord ) {
		this.a = a;
		this.b = b;		
	}

	public function hashCode() {
		final prime = 577;
		var result = 1;
		result = prime * result + a.hashCode();
		result = prime * result + b.hashCode();
		return result;
	}
	
	public function equals( other:CoordTuple ) return hashCode() == other.hashCode();

	public static function compute<V>( map:HashMap<CoordTuple, V>, key:CoordTuple, remappingFunction:( k:CoordTuple, v:V )->Null<V> ) {
		final result = try {
			remappingFunction( key, map[key] );
		} catch( e:Dynamic ) {
			throw e;
		}
		if( result == null ) map.remove( key );
		else map.set( key, result );
	}

}