package xa3.geom;

import Math.PI;

class Circle {
	
	extern public static inline function circumfence( r:Float ) return 2 * PI * r;
	extern public static inline function circumfenceFromArea( a:Float ) return 2 * Math.sqrt( PI * a );
	extern public static inline function area( r:Float ) return PI * r * r;
	extern public static inline function areaFromCircumfence( c:Float ) return c * c / 4 / PI;
}