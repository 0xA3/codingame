package test;

class Output {
	
	public static function arrayToString( a:Array<String> ) return a.join( "" );
	public static function charCodes( s:String ) return s.split( "" ).map( c -> c.charCodeAt( 0 )).join( "," );
}