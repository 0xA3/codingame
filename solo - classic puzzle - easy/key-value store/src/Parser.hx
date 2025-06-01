class Parser {
	
	public static function parseInstruction( instruction:String ) {
		final parts = instruction.split( " " );
		if( parts.length == 0 ) throw "Invalid instruction: " + instruction;
		
		final command = parts[0];
		switch command {
			case "SET":
				final keyValuePairs:Array<KeyValuePair> = [];
				for( i in 1...parts.length ) {
					final keyValue = parts[i].split( "=" );
					keyValuePairs.push( { key: keyValue[0], value: keyValue[1] } );
				}
				return Instruction.Set( keyValuePairs );
			
			case "GET":
				final keys:Array<String> = [];
				for( i in 1...parts.length ) keys.push( parts[i] );
				return Instruction.Get( keys );
			
			case "EXISTS":
				final keys:Array<String> = [];
				for( i in 1...parts.length ) keys.push( parts[i] );
				return Instruction.Exists( keys );
			
			case "KEYS": return Instruction.Keys;
			default: throw "Invalid instruction: " + instruction;
		}
	}
}