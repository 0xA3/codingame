package ai;

import js.Node.process;

using StringTools;
using tink.CoreApi;

// below is a mechanism that connects nodejs standard input with something that resembles the readline()
@await class MainAiLocal {
	
	static var inputLines:Array<String> = [];
	static var promises:Array<(String)->Void> = [];
	static var buffer:String = "";

	static function main() {

		process.stdin.setEncoding("utf8");
		
		process.stdin.on( "data", ( data:String ) -> {
			buffer += data;
			var lines:Array<String> = buffer.split( "\n" );
			if( lines.length > 1 ) {
				for( i in 0...lines.length - 1 ) inputLines.push( lines[i].trim() );
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
			if( inputLines.length == 0 ) break;
			var prom = promises.shift();
			var str = inputLines.shift();
			
			prom( str );
		}
	}

	static function readline() {
		// trace( "readline" );
		var resolve:(String)->Void;

		final initFunc = function( r:(String)->Void ):Void {
			resolve = r;
			// trace( 'initFunc resolve: ${resolve}' );
			promises.push( resolve );
			onReadline();
		}

		// var prom:js.lib.Promise<String> = new js.lib.Promise( initFunc );
		final prom = Future.irreversible( initFunc );
		
		return prom;
	}

	@await static function asyncMain() {
		// actual code, but must use (await readline()) instead of readline() - for example
		// trace( "asyncMain" );
		var input1 = @await readline();
		trace( 'input1: ${input1}' );
		var input2 = @await readline();
		trace( 'input2: ${input2}' );
		
		
		trace( "WAIT" );
	}
}
