class Simulator {
	
	final alphabet:String;
	final zones:Array<Zone>;

	public function new( alphabet:String, numZones:Int ) {
		this.alphabet = alphabet;
		zones = [for( _ in 0...numZones ) new Zone( alphabet.length )];
	}

	function execute( solution:String ) {
		final chars = solution.split( "" );
		var position = 0;
		for( char in chars ) {
			switch char {
				case "+": zones[position].plus();
				case "-": zones[position].minus();
				case ".": 
				case ">":
				case "<":
			}
		}
	}
}