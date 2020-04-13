import ooc.Position;

using ooc.EnumToString;

class Main {
	
	static function main() {
		
		final inputs = CodinGame.readline().split( ' ' );
		final width = Std.parseInt( inputs[0] );
		final height = Std.parseInt( inputs[1] );
		final myId = Std.parseInt( inputs[2] );
		// CodinGame.printErr( 'width $width  height $height  myId $myId' );
		
		final map:Array<Array<Bool>> = [];
		for( i in 0...height ) {
			final line = CodinGame.readline();
			map.push( line.split( "" ).map( s -> s == "." ? true : false ));
			// CodinGame.printErr( line );
		}
		
		final start = ooc.PlaceSubmarine.place( width, height, map );
		// start coordinate
		CodinGame.print( '${start.x} ${start.y}' );
		
		final me = new ooc.Submarine( width, height, map );

		// game loop
		while ( true ) {
			final inputs = CodinGame.readline().split( ' ' );
			final x = Std.parseInt( inputs[0] );
			final y = Std.parseInt( inputs[1] );
			final myLife = Std.parseInt( inputs[2] );
			final oppLife = Std.parseInt( inputs[3] );
			final torpedoCooldown = Std.parseInt( inputs[4] );
			final sonarCooldown = Std.parseInt( inputs[5] );
			final silenceCooldown = Std.parseInt( inputs[6] );
			final mineCooldown = Std.parseInt( inputs[7] );
			final sonarResult = CodinGame.readline();
			final opponentOrders = CodinGame.readline();
		
			// Write an action using console.log()
			// To debug: console.error( 'Debug messages...' );

			me.update( x, y, myLife, torpedoCooldown, sonarCooldown, silenceCooldown, mineCooldown );
			final moveAction = me.getMoveAction();
			final powerAction = me.getPowerAction();

			// CodinGame.printErr( action );
			switch moveAction {
				case Move(d):
					switch powerAction {
						case Charge(c): CodinGame.print( 'MOVE ${d.mString()} ${c.cString()}' );
						case Execute(e): CodinGame.print( 'MOVE ${d.mString()} | ${e.eString()}' );
					}
					
				case Surface: CodinGame.print( 'SURFACE' );
			}

		}

	}

}
