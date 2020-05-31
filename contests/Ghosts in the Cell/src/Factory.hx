import CodinGame.printErr;

class Factory {
	
	public final id:Int;
	public var cyborgs = 0;
	public var production = 0;
	public var value = 0.0;

	public function new( id:Int ) {
		this.id = id;
	}

	public function update( cyborgs:Int, production:Int ) {
		this.cyborgs = cyborgs;
		this.production = production;
	}

	public function setValue( pathsThrough:Int ) {
		value = production + 0.01 * Math.pow( pathsThrough, 0.5 ) + 0.1;
		// printErr( 'factory $id cybs $cyborgs prod $production value $value' );
	}
}