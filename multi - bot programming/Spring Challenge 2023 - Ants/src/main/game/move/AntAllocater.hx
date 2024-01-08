package main.game.move;

using xa3.ArrayUtils;

class CellData {
	public final cell:Cell;
	public var ants:Float;
	public var beacons:Float;
	public var wiggleRoom = 0.0;

	public function new( cell:Cell, playerIdx:Int ) {
		this.cell = cell;
		this.ants = cell.getAntsId( playerIdx );
		this.beacons = cell.getBeaconPowerId( playerIdx );
	}

	public function toString() return 'ants: $ants, beacons: $beacons, wiggleRoom $wiggleRoom';
}

class AntBeaconPair {
	final ant:CellData;
	final beacon:CellData;

	public function new( ant:CellData, beacon:CellData ) {
		this.ant = ant;
		this.beacon = beacon;
	}

	public function getAnt() {
		return ant;
	}

	public function getBeacon() {
		return beacon;
	}

	public function toString() return 'ant: $ant, beacon: $beacon';
}

class AntAllocater {
	
	static function convert( cells:Array<Cell>, playerIdx:Int ) {
		return cells.map( cell -> new CellData( cell, playerIdx ));
	}

	public static function allocateAnts( antCells:Array<Cell>, beaconCells:Array<Cell>, playerIdx:Int, board:Board ) {
		return innerAllocateAnts(
            convert( antCells, playerIdx ),
            convert( beaconCells, playerIdx ),
            playerIdx,
            board
        );
	}

	static function getDistance( p:AntBeaconPair, playerIdx:Int, board:Board ) {
		return board.getDistance( p.getAnt().cell.getIndex(), p.getBeacon().cell.getIndex() );
	}

	static function innerAllocateAnts( antCells:Array<CellData>, beaconCells:Array<CellData>, playerIdx:Int, board:Board ) {
		if( beaconCells.length == 0 ) return [];
		
		var antSum = 0.0;
		for( cell in antCells ) {
			antSum += cell.ants;
		}

		var beaconSum = 0.0;
		for( cell in beaconCells ) {
			beaconSum += cell.beacons;
		}

		final scalingFactor = antSum / beaconSum;
		for( cell in beaconCells ) {
			final highBeaconValue = Math.ceil( cell.beacons * scalingFactor );
			final lowBeaconValue = cell.beacons * scalingFactor;
			cell.beacons = Math.max( 1, lowBeaconValue );
			cell.wiggleRoom = highBeaconValue - cell.beacons;
			//XXX: wiggleRoom will equals 1 if the beaconValue got rounded down
		}

		// trace( 'antSum $antSum  beaconSum $beaconSum  scalingFactor $scalingFactor' );
		// for( cell in beaconCells ) trace( cell );

		final allPairs:Array<AntBeaconPair> = [];

		for( antCell in antCells ) {
			for( beaconCell in beaconCells ) {
				final pair = new AntBeaconPair( antCell, beaconCell );
				if( getDistance( pair, playerIdx, board ) != -1 ) {
					allPairs.push( pair );
				}
			}
		}

		allPairs.sort(( a, b ) -> {
			final distanceA = getDistance( a, playerIdx, board );
			final distanceB = getDistance( b, playerIdx, board );
			if( distanceA < distanceB ) return -1;
			if( distanceA > distanceB ) return 1;

			// Tie-breakers
			final antIndexA = a.getAnt().cell.getIndex();
			final antIndexB = b.getAnt().cell.getIndex();
			if( antIndexA < antIndexB ) return -1;
			if( antIndexA > antIndexB ) return 1;
			
			final beaconIndexA = a.getBeacon().cell.getIndex();
			final beaconIndexB = b.getBeacon().cell.getIndex();
			if( beaconIndexA < beaconIndexB ) return -1;
			if( beaconIndexA > beaconIndexB ) return 1;
			
			return 0;
		});

		// trace( 'allPairs: $allPairs' );

		final allocations:Array<AntAllocation> = [];
		
		var stragglers = false;
		while( allPairs.length > 0 ) {
			for( pair in allPairs ) {
				final antCell = pair.getAnt();
				final antCount = antCell.ants;
				final beaconCell = pair.getBeacon();
				final beaconCount = beaconCell.beacons;
				final wiggleRoom = beaconCell.wiggleRoom;

				final maxAlloc = Std.int( stragglers ? Math.min( antCount, beaconCount + wiggleRoom ) : Math.min( antCount, beaconCount ));
				if( maxAlloc > 0 ) {
					allocations.push(
						new AntAllocation(
							antCell.cell.getIndex(), beaconCell.cell.getIndex(), maxAlloc
						)
					);

					antCell.ants -= maxAlloc;
					if( !stragglers ) {
						beaconCell.beacons -= maxAlloc;
					} else {
						beaconCell.beacons -= maxAlloc - wiggleRoom;
						beaconCell.wiggleRoom = 0;
					}
				}
				allPairs.removeIf( pair -> pair.getAnt().ants <= 0 );
				stragglers = true;
			}
		}
		// if( playerIdx == 0 ) trace( allocations );
		return allocations;
	}
}