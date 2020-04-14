package ooc;

using ooc.ArrayUtils;

class OpponentManager {
	
	final width:Int;
	final height:Int;
	final map:ooc.Map;

	var possibleOpponents:Array<Opponent> = [];

	public function new( width:Int, height:Int, map:ooc.Map ) {
		this.width = width;
		this.height = height;
		this.map = map;
	}

	public function init() {
		possibleOpponents = map.validPositions.map( position -> new Opponent( width, height, map, position ));
	}

	public function update( oppLife:Int, sonarResult:String, opponentOrders:String ) {
		CodinGame.printErr( 'life $oppLife  sonar $sonarResult  orders $opponentOrders' );
		final orderArray = opponentOrders.split( " " );
		switch orderArray[0] {
			case "SURFACE":
				final sector = Std.parseInt( orderArray[1] );
				final positionsOfSector = map.positionsOfSector( sector );
				for( opponent in possibleOpponents ) opponent.surface( positionsOfSector );
			case "MOVE":
				final direction = StringToEnum.direction( orderArray[1] );
				for( opponent in possibleOpponents ) opponent.move( direction );
			case "TORPEDO":
				final x = Std.parseInt( orderArray[1] );
				final y = Std.parseInt( orderArray[2] );
				for( opponent in possibleOpponents ) opponent.torpedo( x, y );
			default: // no-op
		}
		possibleOpponents = possibleOpponents.filter( opponent -> opponent.isValid );
		possibleOpponents.sort( Opponent.sort );
		CodinGame.printErr( 'possiblePositions\n$possibleOpponents' );
	}

}