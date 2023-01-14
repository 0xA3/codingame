enum Direction {
	None;
	Left;
	Right;
}

class Clone {

	static inline var BLOCK = "BLOCK";
	static inline var WAIT = 'WAIT';

	public final drive:InfiniteImprobabilityDrive;

	public var floor = 0;
	public var pos = 0;
	public var direction = Right;

	public function new( drive:InfiniteImprobabilityDrive ) {
		this.drive = drive;
	}

	public function update( line:String ) {
		final inputs = line.split(' ');
		floor = Std.parseInt( inputs[0] ); // floor of the leading clone
		pos = Std.parseInt( inputs[1] ); // position of the leading clone on its floor
		direction = switch inputs[2] { // direction of the leading clone: NONE, LEFT or RIGHT
			case "LEFT": Left;
			case "RIGHT": Right;
			default: None;
		}

		CodinGame.printErr( 'floor: $floor pos: $pos direction: $direction' );
	}

	public function getAction() {
		if( direction == None) return WAIT;
		final targetPosition = drive.getTargetPosition( floor ); CodinGame.printErr( 'targetPosition $targetPosition' );
		return switch direction {
			case Left: targetPosition > pos ? BLOCK : WAIT;
			case Right: targetPosition < pos ? BLOCK : WAIT;
			case None: WAIT;
		}
	
	}
}