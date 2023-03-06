class Main {
	
	@:topLevel
	static function main():Int {
		while( true ) {
			var enemy1:String = "";
			CodinGame.readline( enemy1 ); // name of enemy 1
			var dist1Str = "";
			CodinGame.readline( dist1Str ); // distance to enemy 1
			final dist1 = Std.parseInt( dist1Str );

			var enemy2:String = "";
			CodinGame.readline( enemy2 ); // name of enemy 2
			var dist2Str:String = "";
			CodinGame.readline( dist2Str ); // distance to enemy 2
			final dist2 = Std.parseInt( dist2Str );

			final enemy = dist1 < dist2 ? enemy1 : enemy2;
			CodinGame.print( enemy );
		}
	}
}
