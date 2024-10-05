package data;

class Triangle {
	
	public final p1:Point;
	public final p2:Point;
	public final p3:Point;

	public function new( p1:Point, p2:Point, p3:Point ) {
		this.p1 = p1;
		this.p2 = p2;
		this.p3 = p3;
	}

	public function getEdges() {
		final dist1 = p1.x * p1.x + p1.y * p1.y;
		final dist2 = p2.x * p2.x + p2.y * p2.y;
		final dist3 = p3.x * p3.x + p3.y * p3.y;
		
		final e1 = dist1 < dist2 ? new Edge( p1, p2 ) : new Edge( p2, p1 );
		final e2 = dist2 < dist3 ? new Edge( p2, p3 ) : new Edge( p3, p2 );
		final e3 = dist3 < dist1 ? new Edge( p3, p1 ) : new Edge( p1, p3 );

		return [e1, e2, e3];
	}

	public function toString() return '$p1 - $p2 - $p3';

	public function pointInCircumcircle( p:Point ) {
		final ax = p1.x - p.x;
		final ay = p1.y - p.y;
		final bx = p2.x - p.x;
		final by = p2.y - p.y;
		final cx = p3.x - p.x;
		final cy = p3.y - p.y;
		final apb = ax * by - ay * bx;
		final bpc = bx * cy - by * cx;
		final cpa = cx * ay - cy * ax;
		final sum = apb + bpc + cpa;
		
		return Math.abs( sum ) > 0.0001;
	}

	public function hasPoint( p:Point ) {
		if( p1.x == p.x && p1.y == p.y ) return true;
		if( p2.x == p.x && p2.y == p.y ) return true;
		if( p3.x == p.x && p3.y == p.y ) return true;
		return false;
	}

	public function pointInTriangle( p:Point ) {
		final v0x = p2.x - p1.x;
		final v0y = p2.y - p1.y;
		final v1x = p3.x - p1.x;
		final v1y = p3.y - p1.y;
		final v2x = p.x - p1.x;
		final v2y = p.y - p1.y;
	
		final dot00 = v0x * v0x + v0y * v0y;
		final dot01 = v0x * v1x + v0y * v1y;
		final dot02 = v0x * v2x + v0y * v2y;
		final dot11 = v1x * v1x + v1y * v1y;
		final dot12 = v1x * v2x + v1y * v2y;
	
		final invDenom = 1 / (dot00 * dot11 - dot01 * dot01);
		final u = (dot11 * dot02 - dot01 * dot12) * invDenom;
		final v = (dot00 * dot12 - dot01 * dot02) * invDenom;
		
		return u >= 0 && v >= 0 && (u + v <= 1);
	}

	public function edgeInTriangle( p1:Point, p2:Point ) {
		final a = (p1.x - p2.x) * (p1.y - p1.y) - (p1.y - p2.y) * (p1.x - p1.x);
		final b = (p2.x - p1.x) * (p1.y - p1.y) - (p2.y - p1.y) * (p1.x - p1.x);
		final c = (p1.x - p1.x) * (p2.y - p1.y) - (p1.y - p1.y) * (p2.x - p1.x);
	
		return (a >= 0 && b >= 0 && c >= 0) || (a <= 0 && b <= 0 && c <= 0);
	}
	
	public static function createSuperTriangle( minimumEnclosingCircle:Circle ) {
		final doubleRadius = minimumEnclosingCircle.radius * 2;

		final p1 = new Point( minimumEnclosingCircle.center.x, minimumEnclosingCircle.center.y - doubleRadius );
		final p2 = new Point( minimumEnclosingCircle.center.x - doubleRadius, minimumEnclosingCircle.center.y + doubleRadius );
		final p3 = new Point( minimumEnclosingCircle.center.x + doubleRadius, minimumEnclosingCircle.center.y + doubleRadius );

		return new Triangle( p1, p2, p3 );
	}
}