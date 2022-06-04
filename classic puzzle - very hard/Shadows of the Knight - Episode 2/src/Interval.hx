import Std.int;

@:structInit class Interval {
	public var min:Int;
	public var max:Int;

	public function center() return min + ( max - min ) / 2;
	public function inside( v:Int ) return v >= min && v <= max;
	public function outside( v:Int ) return v < min || v > max;
	public function onBorder( v:Int ) return v == min || v == max;
	public function mirror( v:Int ) {
		final center = center();
		final distance = center - v;
		return int( center + distance );
	}

	public function toString() return '$min-$max';
}