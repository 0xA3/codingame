class Main {
	
	@:topLevel
	static function main():Int {
		while( true ) {
			var enemy1:String = "";
			CodinGame.readline( enemy1 ); // name of enemy 1
			var dist1:Int = 0;
			CodinGame.readline( dist1 ); // distance to enemy 1
			
			var enemy2:String = "";
			CodinGame.readline( enemy2 ); // name of enemy 2
			var dist2:Int = 0;
			CodinGame.readline( dist2 ); // distance to enemy 2

			final enemy = dist1 < dist2 ? enemy1 : enemy2;
			CodinGame.print( enemy );
		}
	}
}
