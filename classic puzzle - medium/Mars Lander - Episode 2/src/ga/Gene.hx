package ga;

@:structInit class Gene {
	public var rotate:Int;
	public var power:Int;

	public static function getRandomRotate() return Std.random( 31 ) - 15;
	public static function getRandomPower() return Std.random( 5 );
}
