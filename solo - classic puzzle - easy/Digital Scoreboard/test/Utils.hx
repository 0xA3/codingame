package test;

using StringTools;

class Utils {
	public static function arrayJoin( a:Array<Array<String>> ) {
		return a.map( row -> row.join( "" )).join( "\n" );
	}
}
