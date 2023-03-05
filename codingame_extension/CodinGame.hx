package;
/**
 * ...
 * @author Tom Hortobágyi
 */
/*
@:native("")
extern class CodinGame
{
	static public function print(output:Dynamic):Void;
	static public function printErr(output:Dynamic):Void;
	static public function readline():String;
}
//*/
class CodinGame
{
	#if nodejs
	static public function print(output:Dynamic):Void { Sys.println(output); }
	static public function printErr(output:Dynamic):Void { Sys.println(output); }
	static public inline function readline():String { return Sys.stdin().readLine(); }
	#elseif js
	extern static public inline function print(output:Dynamic):Void { js.Syntax.code("print({0})", output ); }
	extern static public inline function printErr(output:Dynamic):Void { js.Syntax.code("printErr({0})", output ); }
	extern static public inline function readline():String { return js.Syntax.code('readline()'); }
	#elseif php
	static public function print(output:Dynamic):Void { untyped __php__('echo "$output\n"'); }
	static public function printErr(output:Dynamic):Void { untyped __php__('error_log(var_export($output, true)'); }
	static public inline function readline():String { return untyped __php__('fscanf(STDIN, "%d", $N);'); }
	#elseif python
	static public function print(output:Dynamic):Void { python.Syntax.code('print(output)'); }
	static public function printErr(output:Dynamic) {
        python.Syntax.code('print(output, file=python_lib_Sys.stderr)');
        return python.lib.Sys.platform; // to force import of sys in python script
    }
	static public inline function readline():String { return python.Syntax.code('input()'); }
	#elseif lua
	static public function print(output:Dynamic):Void { untyped __lua__('print(output)'); }
	static public function printErr(output:Dynamic):Void { untyped __lua__('io.stderr:write(output)'); }
	static public inline function readline():String { return untyped __lua__('io.read()'); }
	#elseif interp
	static public function print(output:Dynamic):Void { Sys.println(output); }
	static public function printErr(output:Dynamic):Void { Sys.println(output); }
	static public inline function readline():String { return ""; }
	#elseif fcpp
	extern static public inline function print(output:Dynamic):Void { untyped __fcpp__("cout << {} << endl", output); }
	extern static public inline function printErr(output:Dynamic):Void {  untyped __fcpp__("cerr << {} << endl", output); }
	extern static public inline function readline( varName:Dynamic ):Void { untyped __fcpp__("cin >> {}; cin.ignore();", varName); }
	#elseif sys
	static public function print(output:Dynamic):Void { Sys.println(output); }
	static public function printErr(output:Dynamic):Void { Sys.println(output); }
	static public inline function readline():String { return Sys.stdin().readLine(); }
	#else
	static public function print(output:Dynamic):Void { trace(output); }
	static public function printErr(output:Dynamic):Void { trace(output); }
	static public inline function readline():String { return ""; }
	#end
}