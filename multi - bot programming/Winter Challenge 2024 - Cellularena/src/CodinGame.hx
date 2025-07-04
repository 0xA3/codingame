package;

class CodinGame {
	extern static public inline function print(output:Dynamic):Void { js.Syntax.code("console.log({0})", output ); }
	extern static public inline function printErr(output:Dynamic):Void { js.Syntax.code("console.error({0})", output ); }
}