import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

class Main {
	
	static function main() {
		
		final c = parseInt( readline() );
		final wirings = [for( _ in 0...c ) readline()];
		
		final a = parseInt( readline() );
		final switches = [for( _ in 0...a ) readline()];
		
		final result = process( wirings, switches );
		print( result );
	}

	static function process( wirings:Array<String>, actions:Array<String> ) {
		
		final switches:Map<String, Bool> = [];
		final devices:Array<Device> = [];
		for( wiring in wirings ) {
			
			final tokens = wiring.split(" ");
			final equipmentName = tokens[0];

			var method = Undefined;
			
			var sequence:Array<Array<String>> = [];
			var parallelSwitches:Array<String> = [];
			for( i in 1...tokens.length ) {
				final token = tokens[i];
				switch( token ) {
					case "-": method = Series;
					case "=":
						method = Parallel;
						if( parallelSwitches.length > 0 ) sequence.push( parallelSwitches );
						parallelSwitches = [];
					case label:
						if( !switches.exists( label )) switches.set( label, false );
						switch method {
							case Undefined: throw "Error: method cannot be Undefined.";
							case Series: sequence.push( [label] );
							case Parallel: parallelSwitches.push( label );
						}
				}
			}
			if( parallelSwitches.length > 0 ) sequence.push( parallelSwitches );
			devices.push({ name: equipmentName, sequence: sequence });
		}
		
		for( action in actions ) switches[action] = !switches[action];

		// trace( 'switches ${switches}' );
		// trace( 'devices ${devices}' );

		final outputs:Array<String> = [];
		for( device in devices ) {
			var hasPower = true;
			for( parallelSwitches in device.sequence ) {
				var connection = false;
				for( s in parallelSwitches ) {
					if( switches[s] ) {
						connection = true;
						break;
					}
				}
				if( !connection ) {
					hasPower = false;
					break;
				}
			}
			outputs.push( device.name + " is " + ( hasPower ? "ON" : "OFF" ));
		}

		// trace( outputs );

		return outputs.join( "\n" );
	}

}

typedef Device = {
	final name:String;
	final sequence:Array<Array<String>>;
}

enum Method {
	Undefined;
	Series;
	Parallel;
}