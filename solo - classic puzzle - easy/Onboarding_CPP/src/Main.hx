import CodinGame.readline;

class Main {
	
	@:topLevel
	static function main():Int {
		while( true ) {
			var enemy1 = readline(); // name of enemy 1
			final dist1 = Std.parseInt( readline() );

			var enemy2:String = readline();
			final dist2 = Std.parseInt( readline() );

			final enemy = dist1 < dist2 ? enemy1 : enemy2;
			CodinGame.print( enemy );
		}
	}
}
