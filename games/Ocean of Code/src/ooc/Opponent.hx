package ooc;

class Opponent {
	
	final width:Int;
	final height:Int;
	final map:ooc.Map;

	var possiblePositions:Array<Position> = [];

	public function new( width:Int, height:Int, map:ooc.Map ) {
		this.width = width;
		this.height = height;
		this.map = map;
	}

	public function init() {
		possiblePositions = map.validPositions;
	}

	public function update( oppLife:Int, sonarResult:String, opponentOrders:String ) {
		CodinGame.printErr( 'life $oppLife  sonar $sonarResult  orders $opponentOrders' );
		if( opponentOrders.indexOf( "SURFACE" ) != -1 ) {
			
		}
	}
}