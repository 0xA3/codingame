class StringUtils {
	
	public static function repeat( s:String, times:Int ) {
		var output = "";
		for( i in 0...times ) output += s;
		return output;
	}
}