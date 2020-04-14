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
				intersectPositions( map.positionsOfSector( sector ));
			case "MOVE":
				final direction = StringToEnum.direction( orderArray[1] );
				subtractBorderPositions( direction );
				subtractPositionsWithInvalidPrevious( direction );
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

	function subtractBorderPositions( direction:Direction ) {
		final borderPositions = possiblePositions.filter( position -> !possiblePositions.contains( map.getPreviousPosition( position, direction )));
		CodinGame.printErr( 'borderPositions\n${map.pos2String( borderPositions )}' );
		subtractPositions( borderPositions );
	}

	function subtractPositionsWithInvalidPrevious( direction:Direction ) {
		final invalidPositions = possiblePositions.filter( position -> !map.isPositionValid( map.getPreviousPosition( position, direction )));
		CodinGame.printErr( 'invalidPositions\n${map.pos2String( invalidPositions )}' );
		subtractPositions( invalidPositions );
	}

	function subtractPositions( positionsToRemove:Array<Position> ) {
		possiblePositions = possiblePositions.filter( position -> !positionsToRemove.contains( position ));
	}

	function addPositions( positionsToAdd:Array<Position> ) {
		for( position in positionsToAdd ) {
			if( !possiblePositions.contains( position )) possiblePositions.push( position );
		}
	}

	function intersectPositions( positionsToUnionize:Array<Position> ) {
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