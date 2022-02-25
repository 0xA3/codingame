package asciix;

import asciix.Color;

class Asciix {
	
	public static function compareColors( c1:Color, c2:Color ) {
		switch c1 {
			case RGB( r1, g1, b1 ):
				switch c2 {
					case RGB( r2, g2, b2 ): return r1 == r2 && g1 == g2 && b1 == b2;
					default: return false;
				}
			default: return c1 == c2;
		}
	}

	/**
	 * returns cell data as string
	 * @param cell:Cell
	 */
	 public static function cellToString( cell:Cell ) {
		return 'code: "${String.fromCharCode( cell.code )}", color: ${colorToString( cell.color )}, background: ${colorToString( cell.background )}';
	}

	/**
	 * returns color data as string
	 * @param c:Color
	 */
	public static function colorToString( c:Color ) {
		return switch c {
			case Transparent:		'Transparent';
			case Default: 			'Default';
			case RGB( r, g, b ): 	'RGB(${r},${g},${b})';
			case color: 			'$color';

		}
	}
}
