package ai;

import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import ai.CurrentAis;
import ai.data.CellDataset;
import ai.data.FrameCellDataset;

class MainAi {

	static final inputLines:Array<String> = [];

	static function main() {
		
		final ai = CurrentAis.aiMe;
		final numberOfCells = parseInt( readline() ); // amount of hexagonal cells in this map
		final cellDatasets = [for( i in 0...numberOfCells ) parseCellDataset( readline())];
		
		final numberOfBases = parseInt( readline() );
		
		final inputs = readline().split(' ');
		final myBaseIndices = [for( i in 0...numberOfBases ) parseInt( inputs[i] )];
		
		final inputs = readline().split(' ');
		final oppBaseIndices = [for( i in 0...numberOfBases ) parseInt( inputs[i] )];
		
		ai.setGlobalInputs( cellDatasets, myBaseIndices, oppBaseIndices );
		
		// game loop
		while( true ) {
			final scores = readline().split(' ').map( s -> parseInt( s ));
			final frameCellDatasets = [for( _ in 0...numberOfCells ) parseFrameCellDataset( readline())];
			ai.setInputs( scores[0], scores[1], frameCellDatasets );

			final outputs = ai.process();
			print( outputs );
		}
	}

	static function parseCellDataset( line:String ) {
		var inputs = line.split(' ');
		final type = parseInt( inputs[0] ); // 0 for empty, 1 for eggs, 2 for crystal
		final initialResources = parseInt( inputs[1] ); // the initial amount of eggs/crystals on this cell

		// the index of the neighbouring cell for each direction
		final neighbors = [for( i in 2...8 ) if( inputs[i] != "-1" ) parseInt( inputs[i] )];

		final cellDataset:CellDataset = {
			type: type,
			neighbors: neighbors,

			resources: initialResources,
			myAnts: 0,
			oppAnts: 0,
		}
		
		return cellDataset;
	}

	static function parseFrameCellDataset( line:String ) {
		final inputs = line.split(' ');
		final frameCellDataset:FrameCellDataset = {
			resources: parseInt( inputs[0] ),  // the current amount of eggs/crystals on this cell
			myAnts: parseInt( inputs[1] ), // the amount of your ants on this cell
			oppAnts: parseInt( inputs[2] ), // the amount of opponent ants on this cell
		}

		return frameCellDataset;
	}
}