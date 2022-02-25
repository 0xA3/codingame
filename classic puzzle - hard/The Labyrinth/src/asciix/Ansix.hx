package asciix;

import haxe.ds.Vector;
import asciix.Color;

enum Parameter {
	Clear;
	PlaceCursor( x:Int, y:Int );
	ResetFormat;
	Color( c:Color );
	Background( c:Color );
}

class Ansix {
	
	/**
	 * Clear Console content
	 * @return return '\u001b[2J'
	 */
	public static function clear() return '\u001b[2J';
	
	/**
	 * Reset Console text format
	 * @return return '\u001b[0m'
	 */
	public static function resetFormat() return '\u001b[0m';
	
	/**
	 * Move cursor to top left
	 * @return return '\u001b[1
	 */
	public static function resetCursor() return '\u001b[1;1H';

	/**
	 * format string with parameters
	 * @param s String
	 * @param parameters Array of type Parameter
	 */
	public static function format( s:String, parameters:Array<Parameter> ) {
		
		final sequences = parameters.map( parameter -> {
			return switch parameter {
				case Clear: clear();
				case PlaceCursor(x, y): '\u001b[${y};${x}H';
				case ResetFormat: resetFormat();
				case Color(c): getColorFormat( c );
				case Background(c): getBackgroundFormat( c );
			}
		});
		return sequences.join("") + s;
	}

	static function getColorFormat( c:Color ) {
		return switch c {
			case Transparent:		'';
			case Default: 			'\u001b[39m';
			case RGB( r, g, b ): 	'\u001b[38;2;${r};${g};${b}m';
			default: 				'\u001b[${getColor( c )}m';
		}
	}

	static function getBackgroundFormat( c:Color ) {
		return switch c {
			case Transparent:		'';
			case Default: 			'\u001b[49m';
			case RGB( r, g, b ): 	'\u001b[48;2;${r};${g};${b}m';
			default:				'\u001b[${getBackground( c )}m';
		}
	}

	/**
	 * Return ANSI format string for Cells in a 2d Array in row-major order
	 * @param grid:Array<Array<Cell>>
	 * @param width:Int
	 */
	public static function renderGrid2d( grid:Array<Array<Cell>>, width:Int ) {
		var color = Default;
		var background = Default;
		final sv = new Vector<String>( grid.length * width );
		for( y in 0...grid.length ) {
			final row = grid[y];
			for( x in 0...row.length ) {
				final index = width * y + x;
				final cell = grid[y][x];
				sv[index] =
					( cell.color == color ? "" : getColorFormat( cell.color )) +
					( cell.background == background ? "" : getBackgroundFormat( cell.background )) +
					String.fromCharCode( cell.code );
				
				// if( cell.color != color ) trace( '$x:$y change color to ${cell.color}' );
				// if( cell.background != background ) trace( '$x:$y change background to ${cell.background}' );
				if( cell.color != color ) color = cell.color;
				if( cell.background != background ) background = cell.background;
				if( x == row.length - 1 ) sv[index] += "\n";
			}
		}
		return sv.join( "" );
	}

	/**
	 * Return ANSI format string for Cells in a 1d Array in row-major order
	 * @param grid:Array<Cell>
	 * @param width:Int
	 */
	public static function renderGrid( grid:Array<Cell>, width:Int ) {
		var color = Default;
		var background = Default;
		final sv = new Vector<String>( grid.length );
		for( i in 0...grid.length ) {
			final cell = grid[i];
			sv[i] =
				( cell.color == color ? "" : getColorFormat( cell.color )) +
				( cell.background == background ? "" : getBackgroundFormat( cell.background )) +
				String.fromCharCode( cell.code );
			if( Asciix.compareColors( cell.color, color )) color = cell.color;
			if( Asciix.compareColors( cell.background, background )) background = cell.background;
			if( i % width == width - 1 ) sv[i] += "\n";
		}
		return sv.join( "" );
	}

	public static function getColor( c:Color ) {
		return switch c {
			case Transparent: throw "Error: in getColor: Transparent should be handeled in getColorFormat()";
			case Default: throw "Error: in getColor: Default should be handeled in getColorFormat()";
			case Black: 30;
			case Red: 31;
			case Green: 32;
			case Yellow: 33;
			case Blue: 34;
			case Magenta: 35;
			case Cyan: 36;
			case White: 37;
			case BrightBlack: 90;
			case BrightRed: 91;
			case BrightGreen: 92;
			case BrightYellow: 93;
			case BrightBlue: 94;
			case BrightMagenta: 95;
			case BrightCyan: 96;
			case BrightWhite: 97;
			case RGB(r, g, b): throw "Error: in getColor: RGB should be handeled in getColorFormat()";
		}
	}

	public static function getBackground( c:Color ) {
		return switch c {
			case Transparent: throw "Error: in getColor: Transparent should be handeled in getBackgroundFormat()";
			case Default: throw "Error: in getBackground: Default should be handeled in getBackgroundFormat()";
			case Black: 40;
			case Red: 41;
			case Green: 42;
			case Yellow: 43;
			case Blue: 44;
			case Magenta: 45;
			case Cyan: 46;
			case White: 47;
			case BrightBlack: 100;
			case BrightRed: 101;
			case BrightGreen: 102;
			case BrightYellow: 103;
			case BrightBlue:1094;
			case BrightMagenta: 105;
			case BrightCyan: 106;
			case BrightWhite: 107;
			case RGB(r, g, b): throw "Error: in getBackground: RGB should be handeled in getBackgroundFormat()";
		}
	}

}

