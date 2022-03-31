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
				.replace('class Std{static parseInt(e){if(null!=e){let t=0,r=e.length;for(;t<r;){let r=t++,n=e.charCodeAt(r);if(n<=8||n>=14&&32!=n&&45!=n){let t=e.charCodeAt(r+1),n=parseInt(e,120==t||88==t?16:10);return isNaN(n)?null:n}}}return null}}', "" )
				.replace('class haxe_iterators_ArrayIterator{constructor(e){this.current=0,this.array=e}hasNext(){return this.current<this.array.length}next(){return this.array[this.current++]}}', "" )
				.replace('"undefined"!=typeof performance&&"function"==typeof performance.now&&(HxOverrides.now=performance.now.bind(performance)),', "" )
				.replace('.charAt(0)', "[0]")
				.replace( "Std.parseInt", "parseInt");

			// overwrite output
			sys.io.File.saveContent(outPath, outContent);
			var sizeAfter = outContent.length;
			trace("JavaScript size minified: " + kilobyte(sizeAfter) + " (" + percentage(sizeAfter, sizeBefore) + "% smaller)");
		});
	}
}
