package ga;

@:structInit class Gene {
	public var rotate:Int;
	public var power:Int;

	public static function getRandomRotate() return Std.random( 31 ) - 15;
	// public static function getRandomPower() return Std.random( 5 );
	public static function getRandomPower() return Std.random( 3 ) - 1;

	public function copy() {
		final copy:Gene = { rotate: rotate, power: power };
		return copy;
	}
}
