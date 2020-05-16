package test;

class GetFloorLines {
	
	public static function get( lines:Array<String> ) {
		final floorLines = lines.map( line -> line.split("").map( s -> s == "#" ? "#" : " " ).join("") );
		return floorLines;
	}
	
}