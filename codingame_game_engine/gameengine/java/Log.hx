package gameengine.java;

class Log {
	
	var _isInfoEnabled = true;

	public function new() {}

	public function info( s:String ) trace( s );
	public function isInfoEnabled() return _isInfoEnabled;
	public function warn( s:String ) trace( s );
}