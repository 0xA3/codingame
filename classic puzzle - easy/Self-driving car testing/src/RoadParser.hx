import Std.parseInt;

class RoadParser {
	
	final roadPatterns:Array<RoadPattern>;

	var id = 0;
	var currentRoadPattern:RoadPattern;

	public function new( road:Array<String> ) {
		
		this.roadPatterns = road.map( s -> {
			final parts = s.split( ";" );
			{ amount: parseInt( parts[0] ), piece: parts[1] }
		});
		currentRoadPattern = { amount: roadPatterns[0].amount, piece: roadPatterns[0].piece };
	}

	public function getPiece() {
		if( currentRoadPattern.amount == 0 ) {
			id++;
			currentRoadPattern = { amount: roadPatterns[id].amount, piece: roadPatterns[id].piece };
		}
		final piece = currentRoadPattern.piece;
		currentRoadPattern.amount--;
		// trace( 'id $id amount ${currentRoadPattern.amount}' );
		// trace( currentRoadPattern.piece );
		return piece;
	}

}

typedef RoadPattern = {
	var amount:Int;
	final piece:String;
}