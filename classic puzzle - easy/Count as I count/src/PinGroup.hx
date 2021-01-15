class PinGroup {
	
	public final score:Int;
	final pins = [for( i in 0...12 ) i + 1];

	public function new( score = 0 ) {
		this.score = score;
	}

	public function getChildPinGroups() {
		final singleHitPinGroups = [for( i in 0...pins.length ) getSingleHitPinGroup( i + 1 )];
		final multipleHitPinGroups = [for( i in 1...pins.length ) getMultipleHitPinGroup( i + 1 )];
		return singleHitPinGroups.concat( multipleHitPinGroups );
	}

	function getSingleHitPinGroup( pin:Int ) {
		final nextScore = score + pin;
		return new PinGroup( nextScore );
	}

	function getMultipleHitPinGroup( pins:Int ) {
		final nextScore = score + pins;
		return new PinGroup( nextScore );
	}

}