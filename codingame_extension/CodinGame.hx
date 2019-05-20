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
	#if js
	static public function print(output:Dynamic):Void { untyped __js__('print(output)'); }
	static public function printErr(output:Dynamic):Void { untyped __js__('printErr(output)'); }
	static public inline function readline():String { return untyped __js__('readline()'); }
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
	#else
	static public function print(output:Dynamic):Void { trace(output); }
	static public function printErr(output:Dynamic):Void { trace(output); }
	static public inline function readline():String { return ""; }
	#end
}