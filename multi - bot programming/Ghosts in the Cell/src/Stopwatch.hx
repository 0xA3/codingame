import haxe.Timer;

class Stopwatch {
	
	var start:Float;

	public function new() {
		start = Timer.stamp();
	}

	public function stamp() {
		final end = Timer.stamp();
		final delta = end - start;
		start = end;
		return delta;
	}

	public static function d( delta:Float ) {
		return '${Math.round( delta * 1000 )}ms';
	}
}