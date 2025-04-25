package test;

using StringTools;

class Readline {
	
	static var lineCounter = 0;
	static var inputLines:Array<String>;
	
	public static function initReadline( input:String ) {
		lineCounter = 0;
		inputLines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
	}
	
	public static function readline() return inputLines[lineCounter++];
}