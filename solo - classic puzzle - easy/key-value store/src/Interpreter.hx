using Lambda;

class Interpreter {
	
	static final keys:Array<String> = [];
	static final keyValues:Map<String, String> = [];

	public static function execute( instructions:Array<Instruction> ) {
		keys.splice( 0, keys.length );
		keyValues.clear();

		final outputs:Array<String> = [];

		for( instruction in instructions ) {
			switch instruction {
				case Set( keyValuePairs ): keyValuePairs.iter( set );
				case Get( k ): outputs.push( get( k ));
				case Exists( k ): outputs.push( existsKeys( k ));
				case Keys: outputs.push( getKeys() );
				default: // nothing
			}
		}

		return outputs.join( "\n" );
	}

	static function set( keyValuePair:KeyValuePair ) {
		if( !keyValues.exists( keyValuePair.key )) keys.push( keyValuePair.key );
		keyValues.set( keyValuePair.key, keyValuePair.value );
	}

	static function get( k:Array<String> ) {
		return [for( key in k ) keyValues.exists( key ) ? keyValues[key] : "null" ].join(" ");
	}

	static function existsKeys( k:Array<String> ) {
		return [for( key in k ) keyValues.exists( key ) ? "true" : "false" ].join(" ");
	}

	static function getKeys() {
		return keys.length == 0 ? "EMPTY" : keys.join(" ");
	}
	
}