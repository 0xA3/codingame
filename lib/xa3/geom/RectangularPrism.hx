package xa3.geom;

class RectangularPrism {

	extern public static inline function area( width:Float, length:Float, height:Float ) return 2 * ( width * length + length * height + height * width );
	extern public static inline function volume( width:Float, length:Float, height:Float ) return length * width * height;
}