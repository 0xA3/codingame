enum Instruction {
	Set( keyValuePairs:Array<KeyValuePair> );
	Get( k:Array<String> );
	Exists( k:Array<String> );
	Keys;
}
