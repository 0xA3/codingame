using Lambda;

class Parser {
	
	static final chars = ["<",">","+","-",".",",","[","]"];

	public static function parse( lines:Array<String> ) {
		final parsed = lines.flatMap( line -> line.split( "" ).filter( s -> chars.contains( s )));
		return parsed.join( "" );
	}
}