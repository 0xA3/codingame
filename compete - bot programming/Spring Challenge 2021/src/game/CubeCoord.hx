package game;

class CubeCoord {
	
	public static final directions:Array<Array<Int>> = [[ 1, -1, 0 ], [ 1, 0, -1 ], [ 0, 1, -1 ], [ -1, 1, 0 ], [ -1, 0, 1 ], [ 0, -1, 1 ]];

	public final x:Int;
	public final y:Int;
	public final z:Int;

	public function new( x:Int, y:Int, z:Int ) {
		this.x = x;
		this.y = y;
		this.z = z;
	}

	public function hashCode() {
		final prime = 31;
		var result = 1;
		result = prime * result + x;
        result = prime * result + y;
        result = prime * result + z;
        return result;
	}

	public function equals( other:CubeCoord ) {
		if( other == null ) return false;
		if( x != other.x ) return false;
		if( y != other.y ) return false;
		if( z != other.z ) return false;
		return true;
	}

	public function neighbor( orientation:Int, distance = 1 ) {
		final nx = this.x + directions[orientation][0] * distance;
        final ny = this.y + directions[orientation][1] * distance;
        final nz = this.z + directions[orientation][2] * distance;

        return new CubeCoord(nx, ny, nz);
	}

	public function distanceTo( dst:CubeCoord ) return ( Math.abs( x - dst.x ) + Math.abs( y - dst.y ) + Math.abs( z - dst.z )) / 2;

	public function toString() return '$x $y $z';

	public function getOpposite() return new CubeCoord( -x, -y, -z );
}