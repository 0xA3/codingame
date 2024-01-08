package game;

import Std.int;
import view.Coord;

class Vector {
	
	public var x:Float;
	public var y:Float;

	public function new( x:Float, y:Float ) {
		this.x = x;
		this.y = y;
	}

	public static function fromVectors( a:Vector, b:Vector ) {
		return new Vector( b.x - a.x, b.y - a.y );
	}

	public static function fromAngle( angle:Float ) {
		return new Vector( Math.cos( angle ), Math.sin( angle ));
	}

	public function rotate( angle:Float ) {
        final nx = ( x * Math.cos( angle )) - ( y * Math.sin( angle ));
        final ny = ( x * Math.sin( angle )) + ( y * Math.cos( angle ));

        return new Vector( nx, ny );
	}

    public function equals( v:Vector ) {
        return v.x == x && v.y == y;
    }

    public function round() {
        return new Vector( Math.round( this.x ), Math.round( this.y ));
    }

    public function truncate() {
        return new Vector( Std.int( this.x ), Std.int( this.y ));
    }

	public function distance( v:Vector ) {
		return Math.sqrt( distanceSq( v ));
	}

	public function distanceSq( v:Vector ) {
		return ( v.x - x ) * ( v.x - x ) + ( v.y - y ) * ( v.y - y );
	}

    public function inRange( v:Vector, range:Float ) {
        return ( v.x - x ) * ( v.x - x ) + ( v.y - y ) * ( v.y - y ) <= range * range;
    }

    public function add( v:Vector ) {
        return new Vector( x + v.x, y + v.y );
    }

    public function mult( factor:Float ) {
        return new Vector( x * factor, y * factor );
    }

    public function sub( v:Vector ) {
        return new Vector( this.x - v.x, this.y - v.y );
    }

    public function length() {
        return Math.sqrt( x * x + y * y );
    }

    public function lengthSquared() {
        return x * x + y * y;
    }

    public function normalize() {
        final length = length();
        if ( length == 0 )
            return new Vector( 0, 0 );
        return new Vector( x / length, y / length );
    }

    public function dot( v:Vector ) {
        return x * v.x + y * v.y;
    }

    public function angle() {
        return Math.atan2( y, x );
    }

    public function toString() {
        return '${int( x )} ${int( y )}';
    }

    public function project( force:Vector ) {
        final normalize = this.normalize();
        return normalize.mult( normalize.dot( force ));
    }

    public function cross( s:Float ) {
        return new Vector( -s * y, s * x );
    }

    public function hsymmetric( ?center:Float ) {
       if( center == null ) return new Vector( -this.x, this.y );
		return new Vector( 2 * center - this.x, this.y );
    }

    public function vsymmetric( ?center:Float ) {
        if( center == null ) return new Vector( this.x, -this.y );
		return new Vector( this.x, 2 * center - this.y );
    }

    public function symmetric( ?center:Vector ) {
        if( center == null ) return symmetric( new Vector( 0, 0 ));
		return new Vector( center.x * 2 - this.x, center.y * 2 - this.y );
    }

    public function withinBounds( minx:Float, miny:Float, maxx:Float, maxy:Float ) {
        return x >= minx && x < maxx && y >= miny && y < maxy;
    }

    public function isZero() {
        return x == 0 && y == 0;
    }

    public function symmetricTruncate( origin:Vector ) {
        return sub( origin ).truncate().add( origin );
    }

}