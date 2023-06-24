package gameengine.java;

class Log {
	
	var _isInfoEnabled = true;

	public function new() {}

	public function info( s:String ) Sys.println( s );
	public function isInfoEnabled() return _isInfoEnabled;
	public function warn( s:String ) Sys.println( s );
}