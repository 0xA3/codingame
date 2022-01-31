class Zone {

	final alphabetLength:Int;

	public var value = 0;

	public function new( alphabetLength:Int ) {
		this.alphabetLength = alphabetLength;
	}

	public function plus() value = ( value + 1 ) % alphabetLength;
	public function minus() value = ( alphabetLength + ( value - 1 )) % alphabetLength;

	public function getDistance( charCode:Int ) {
		final distanceLeft = distanceLeft( charCode );
		final distanceRight = distanceRight( charCode );
		return distanceLeft < distanceRight ? -distanceLeft : distanceRight;
	}

	inline function distanceRight( charCode:Int ) return charCode >= value ? charCode - value : alphabetLength - value + charCode;
	inline function distanceLeft( charCode:Int ) return charCode <= value ? value - charCode : value + alphabetLength - charCode;

}