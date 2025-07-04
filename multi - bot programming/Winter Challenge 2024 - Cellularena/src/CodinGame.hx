package;

class CodinGame
{
	extern static public inline function print(output:Dynamic):Void { js.Syntax.code("print({0})", output ); }
	extern static public inline function printErr(output:Dynamic):Void { js.Syntax.code("printErr({0})", output ); }
	// extern static public inline function readline():String { return js.Syntax.code('readline()'); }
}