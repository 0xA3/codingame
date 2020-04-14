package ooc;

using ooc.ArrayUtils;

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
		final orderArray = opponentOrders.split( " " );
		switch orderArray[0] {
			case "SURFACE":
				final sector = Std.parseInt( orderArray[1] );
				unionPositions( map.positionsOfSector( sector ));
			case "MOVE":
				final direction = StringToEnum.direction( orderArray[1] );
				removeBorderPositions( direction );
				removePositionsWithInvalidPrevious( direction );
				move( direction );
			default: // no-op
		}
		possiblePositions.sort( positionSort );
		CodinGame.printErr( 'possiblePositions\n${map.pos2String( possiblePositions )}' );
	}

	function move( direction:Direction ) {
		final nextPossiblePositions = possiblePositions.map( position -> map.getNextPosition( position, direction )).filter( position -> map.isValid( position.x, position.y ));
		addPositions( nextPossiblePositions );
	}

	function removeBorderPositions( direction:Direction ) {
		final borderPositions = possiblePositions.filter( position -> !possiblePositions.contains( map.getPreviousPosition( position, direction )));
		CodinGame.printErr( 'borderPositions\n${map.pos2String( borderPositions )}' );
		removePositions( borderPositions );
	}

	function removePositionsWithInvalidPrevious( direction:Direction ) {
		final invalidPositions = possiblePositions.filter( position -> !map.isPositionValid( map.getPreviousPosition( position, direction )));
		CodinGame.printErr( 'invalidPositions\n${map.pos2String( invalidPositions )}' );
		removePositions( invalidPositions );
	}

	function removePositions( positionsToRemove:Array<Position> ) {
		possiblePositions = possiblePositions.filter( position -> !positionsToRemove.contains( position ));
	}

	function addPositions( positionsToAdd:Array<Position> ) {
		for( position in positionsToAdd ) {
			if( !possiblePositions.contains( position )) possiblePositions.push( position );
		}
	}

	function unionPositions( positionsToUnionize:Array<Position> ) {
		final resultPositions:Array<Position> = [];
		for( position in possiblePositions ) if( positionsToUnionize.contains( position )) resultPositions.push( position );
		possiblePositions = resultPositions;
	}

	function positionSort( a:Position, b:Position ) {
		if( a.y < b.y ) return -1;
		if( a.y > b.y ) return 1;
		if( a.x < b.x ) return -1;
		if( a.x > b.x ) return 1;
		return 0;
	}

}