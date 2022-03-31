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
				.replace('var $$global="undefined"!=typeof window?window:"undefined"!=typeof global?global:"undefined"!=typeof self?self:this;', "")
				.replace('class haxe_iterators_ArrayIterator{constructor(t){this.current=0,this.array=t}hasNext(){return this.current<this.array.length}next(){return this.array[this.current++]}}', "")
				// .replace('class e{static f(t){print(t)}}', "")
				// .replace('e.f', "print")
				// .replace("class _${static main(){", "")
				// .replace("}}_$.main();", "")
				.replace('.charAt(0)', "[0]")
				.replace( "Std.parseInt", "parseInt")
				.replace( "class Std{static parseInt(t){if(null!=t){let e=0,r=t.length;for(;e<r;){let r=e++,a=t.charCodeAt(r);if(a<=8||a>=14&&32!=a&&45!=a){let e=t.charCodeAt(r+1),a=parseInt(t,120==e||88==e?16:10);return isNaN(a)?null:a}}}return null}}", "");

			// overwrite output
			sys.io.File.saveContent(outPath, outContent);
			var sizeAfter = outContent.length;
			trace("JavaScript size minified: " + kilobyte(sizeAfter) + " (" + percentage(sizeAfter, sizeBefore) + "% smaller)");
		});
	}
}
