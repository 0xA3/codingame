package game.move;

import haxe.Int64;
import xa3.MathUtils;

using xa3.ArrayUtils;

class CellData {
	public final cell:Cell;
	public var ants:Int64;
	public var beacons:Int64;
	public var wiggleRoom = 0i64;

	public function new( cell:Cell, playerIdx:Int ) {
		this.cell = cell;
		this.ants = cell.getAntsId( playerIdx );
		this.beacons = cell.getBeaconPowerId( playerIdx );
	}
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
		final allocations:Array<AntAllocation> = [];
		var antSum = 0i64;
		for( cell in antCells ) {
			antSum += cell.ants;
		}

		var beaconSum = 0i64;
		for( cell in beaconCells ) {
			beaconSum += cell.beacons;
		}

		final scalingFactor = antSum / beaconSum;
		for( cell in beaconCells ) {
			final highBeaconValue = cell.beacons * scalingFactor; // TODO Math.ceil(cell.beacons * scalingFactor)
			final lowBeaconValue = cell.beacons * scalingFactor;
			cell.beacons = MathUtils.max( 1, lowBeaconValue );
			cell.wiggleRoom = highBeaconValue - cell.beacons;
			//XXX: wiggleRoom will equals 1 if the beaconValue got rounded down
		}

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


		var stragglers = false;
		while( allPairs.length != 0 ) {
			for( pair in allPairs ) {
				final antCell = pair.getAnt();
				final antCount = antCell.ants;
				final beaconCell = pair.getBeacon();
				final beaconCount = beaconCell.beacons;
				final wiggleRoom = beaconCell.wiggleRoom;

				final maxAlloc = stragglers ? MathUtils.min( antCount, beaconCount + wiggleRoom ) : MathUtils.min( antCount, beaconCount );
				if( maxAlloc > 0 ) {
					allocations.push(
						new AntAllocation(
							antCell.cell.getIndex(), beaconCell.cell.getIndex(), Int64.toInt( maxAlloc )
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

		return allocations;
	}
}