package;

using StringTools;

/**
 * @author Mark Knol
 */
class BuildTool {
	public static function run() {
		// remove the Haxe toString function, normally to guarantee crossplatform logs
		// no.Spoon.bend('js.Boot', macro class {
		// 	static function __string_rec(o, s:String):String {
		// 		return s;
		// 	}
		// });

		// when Haxe is done with compiling
		haxe.macro.Context.onAfterGenerate(() -> {
			inline function kilobyte(size:Float, precision:Int = 1000) return Std.int(size / 1024 * precision) / precision + "Kb";
			inline function percentage(before:Float, after:Float, precision:Int = 1) return Std.int(after / before * 100 * precision) / precision;

			var outPath = haxe.macro.Compiler.getOutput();
			var sizeBefore = sys.io.File.getContent(outPath).length;
			trace("JavaScript size original: " + kilobyte(sizeBefore));
			#if !debug
			@:privateAccess UglifyJS.compileFile(outPath, outPath);
			#end

			var outContent = sys.io.File.getContent(outPath);

			// manually minify output even more
			outContent = outContent
				.replace('"use strict";', "")
				.replace('var $$global="undefined"!=typeof window?window:"undefined"!=typeof global?global:"undefined"!=typeof self?self:this;', "")
				.replace('class haxe_iterators_ArrayIterator{constructor(a){this.current=0,this.array=a}hasNext(){return this.current<this.array.length}next(){return this.array[this.current++]}}', "")
				.replace('.charAt(0)', "[0]")
				.replace( "Main_main()", "m()");
				// .replace(".prototype", "[$$0]")
				// .replace("Object.assign", "$$2")
				// .replace("Math.random", "$$1")
				// .replace("_hx_skip_constructor", "$$3")
				// .replace("_hx_constructor", "$$4")
				// .replace("_hx_index", "$$5")
				// .replace("__enum__", "$$6")
				// .replace("hx__closures__", "$$7")
				// .replace("__class__", "$$8")
				// .replace('e=function(){return js_Boot.__string_rec(this,"")},', "e=_=>{},")

			// outContent = "$$0='prototype';$$1=Math.random;$$2=Object.assign;" + outContent;

			// overwrite output
			sys.io.File.saveContent(outPath, outContent);
			var sizeAfter = outContent.length;
			trace("JavaScript size minified: " + kilobyte(sizeAfter) + " (" + percentage(sizeAfter, sizeBefore) + "% smaller)");
		});
	}
}
