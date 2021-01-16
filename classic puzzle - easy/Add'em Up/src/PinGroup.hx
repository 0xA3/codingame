class PinGroup {
	
	public static inline var PINS = 12;

	public final score:Int;

	public function new( score = 0 ) {
		this.score = score;
	}

	public function getChildPinGroups() {
		final singleHitPinGroups = [for( pin in 0...PINS ) new PinGroup( score + pin + 1 )];
		final multipleHitPinGroups = [for( pins in 1...PINS ) new PinGroup( score + pins + 1 )];
		return singleHitPinGroups.concat( multipleHitPinGroups );
	}

}