package ai;

import js.Node.process;

using StringTools;
using tink.CoreApi;

// below is a mechanism that connects nodejs standard input with something that resembles the readline()
@await class MainAiLocal {
	
	static var stdInLines:Array<String> = [];
	static var promises:Array<Dynamic> = [];
	static var buffer:String = "";

	static function main() {

		process.stdin.setEncoding("utf8");
		
		process.stdin.on( "data", ( data:String ) -> {
			buffer += data;
			var lines:Array<String> = buffer.split( "\n" );
			if( lines.length > 1 ) {
				for( i in 0...lines.length - 1 ) stdInLines.push( lines[i].trim() );
				buffer = lines[lines.length - 1];
				onReadline();
			}
		});

		// Start the async function
		asyncMain();
	}

	static function onReadline() {
		while( true ) {
			if( promises.length == 0 ) break;
			if( stdInLines.length == 0 ) break;
			var prom = promises.shift();
			var str = stdInLines.shift();
			prom( str );
		}
	}

	static function readline() {
		var resolve:Dynamic;

		final initFunc = function( resolveFunc, rejectFunc ):Void {
			resolve = resolveFunc;
		}

		var prom:js.lib.Promise<String> = new js.lib.Promise( initFunc );
		promises.push( resolve );
		onReadline();
		
		return prom;
	}

	@await static function asyncMain() {
		// actual code, but must use (await readline()) instead of readline() - for example
		var input = @await readline();
		trace( "WAIT" );
	}
}
