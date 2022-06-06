import Std.int;

using xa3.MathUtils;

@:structInit class Interval {
	public var min:Int;
	public var max:Int;
	public var length(get, never):Int;
	function get_length() return max - min + 1;
	
	public function center() return min + ( max - min ) / 2;
	public function inside( v:Int ) return v >= min && v <= max;
	public function outside( v:Int ) return v < min || v > max;
	public function onBorder( v:Int ) return v == min || v == max;
	public function mirror( v:Int ) {
		final center = center();
		final distance = center - v;
		return int( center + distance );
	}
	public function getNearestBorder( v:Int ) {
		final distMin = ( min - v ).abs();
		final distMax = ( max - v ).abs();
		return distMin < distMax ? min : max;
	}

	public function toString() return '$min-$max';
}