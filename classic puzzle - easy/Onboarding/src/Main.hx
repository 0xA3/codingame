class Main {
	
	static function main() {
		
		while( true ) {

			final enemy1 = CodinGame.readline(); // name of enemy 1
			final dist1 = Std.parseInt( CodinGame.readline()); // distance to enemy 1

			final enemy2 = CodinGame.readline(); // name of enemy 2
			final dist2 = Std.parseInt( CodinGame.readline()); // distance to enemy 2

			CodinGame.print( dist1 < dist2 ? enemy1 : enemy2 );
		}
	}
}
