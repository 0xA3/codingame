import Std.parseInt;

using Lambda;

class FormulaParser {

	final stepX = 6;
	final stepY = 2;

	final lines:Array<String>;

	var x:Int;
	var y:Int;

	public function new( lines:Array<String> ) {
		this.lines = lines;
	}

	public function parse() {
		y = 0;
		while( y < lines.length ) {
			x = 0;
			while( x < lines[y].length ) {
				if( lines[y].substr( x, 2 ) == "CH" && !isValid( x, y )) return false;
				x += stepX;
			}
			y += stepY;
		}
		return true;
	}

	function isValid( x:Int, y:Int ) {
		// trace( 'length ${lines[y].length}' );
		
		final bonds = [
			
			// number of H molecules
			lines[y].charAt( x + 2 ),
			
			// top position
			y == 0 || lines[y - 1].length <= x + 1 ? " " : lines[y - 1].charAt( x + 1 ),
			
			 // left position
			x == 0 ? " " : lines[y].charAt( x - 2 ),

			// bottom position
			y == lines.length - 1 || lines[y + 1].length <= x + 1 ? " " : lines[y + 1].charAt( x + 1 ),
			
			// right position
			x >= lines[y].length - 3 ? " " : lines[y].charAt( x + 4 )

		].map( c -> c == " " ? 0 : parseInt( c ));
		
		// trace( '$x:$y H ${bonds[0]}, top ${bonds[1]}, left ${bonds[2]}, bottom ${bonds[3]}, right ${bonds[4]}' );
		// trace( '$x:$y H ${bonds[0]}, top ${bonds[1]}, left ${bonds[2]}, bottom ${bonds[3]}, right ${bonds[4]}, sum ${bonds.fold(( number, sum ) -> sum + number, 0 )}' );
		
		final sum = bonds.fold(( number, sum ) -> sum + number, 0 );

		return sum == 4;
	}
}