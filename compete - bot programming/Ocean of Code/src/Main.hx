import ooc.Opponent;
import ooc.Position;

using ooc.EnumToString;

class Main {
	
	static function main() {
		
		final inputs = CodinGame.readline().split( ' ' );
		final width = Std.parseInt( inputs[0] );
		final height = Std.parseInt( inputs[1] );
		final myId = Std.parseInt( inputs[2] );
		// CodinGame.printErr( 'width $width  height $height  myId $myId' );
		
		final cells:Array<Array<Bool>> = [];
		for( i in 0...height ) {
			final line = CodinGame.readline();
			cells.push( line.split( "" ).map( s -> s == "." ? true : false ));
			// CodinGame.printErr( line );
		}
		
		final map = new ooc.Map( width, height, cells );
		map.init();

		final submarine = new ooc.Submarine( width, height, map );
		final opponentManager = new ooc.OpponentManager( width, height, map );
		opponentManager.init();

		final startPosition = map.getRandomValidPosition();
		// CodinGame.printErr( map );
		// start coordinate
		CodinGame.print( '${startPosition.x} ${startPosition.y}' );
		
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
		
			submarine.update( x, y, myLife, torpedoCooldown, sonarCooldown, silenceCooldown, mineCooldown );
			opponentManager.update( oppLife, sonarResult, opponentOrders );
			
			final moveAction = submarine.getMoveAction();
			final chargeAction = submarine.getChargeAction();
			final executeAction = submarine.getExecuteAction();

			var command = "";
			// CodinGame.printErr( action );
			switch moveAction {
				case Move(d):
					switch executeAction {
						case None: // no-op
						case FireTorpedo(e): command += '${executeAction.eString()} | ';
					}
					command += 'MOVE ${d.mString()} ${chargeAction.cString()}';	
				case Surface: command = 'SURFACE';
			}
			CodinGame.print( command );
		}

	}

}
