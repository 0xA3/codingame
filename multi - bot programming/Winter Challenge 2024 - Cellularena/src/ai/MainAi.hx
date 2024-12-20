package ai;

import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import ai.data.Entity;
import ai.data.Pos;

class MainAi {
	
	static function main() {
		final ai = new ai.versions.Ai1();
		final inputs = readline().split(' ');
		final width = parseInt( inputs[0] );
		final height = parseInt( inputs[1] );
		final grid = [for( _ in 0...height ) [for( _ in 0...width ) -1]];
		final positions = [for( y in 0...height ) [for( x in 0...width ) new Pos( x, y )]];
		// printErr( 'width: $width' );
		// printErr( 'height: $height' );
		ai.setGlobalInputs( grid, width, height, positions );
		
		final entities = [];
		final myEntities = [];
		// final oppEntities = [];
		// final neitherEntities = [];
	
		// game loop
		while( true ) {
			entities.splice( 0, entities.length );
			myEntities.splice( 0, myEntities.length );
			final entityCount = parseInt( readline() );
			// printErr( 'entityCount: $entityCount' );
			for ( i in 0...entityCount ) {
				final inputs = readline().split(' ');
				// printErr( 'Entity: ${inputs.join(" ")}' );
				final x = parseInt( inputs[0] );
				final y = parseInt( inputs[1] ); // grid coordinate
				final type = inputs[2]; // WALL, ROOT, BASIC, TENTACLE, HARVESTER, SPORER, A, B, C, D
				final owner = parseInt( inputs[3] ); // 1 if your organ, 0 if enemy organ, -1 if neither
				final organId = parseInt( inputs[4] ); // id of this entity if it's an organ, 0 otherwise
				final organDir = inputs[5]; // N,E,S,W or X if not an organ
				final organParentId = parseInt( inputs[6] );
				final organRootId = parseInt( inputs[7] );

				// if( grid[y][x] == -1 ) {
					// final gridEntityId = grid[y][x];
					// final gridEntity = entities[gridEntityId];
					// if( !checkEntityMatch( gridEntity, type, owner, organId, organDir, organParentId, organRootId ) ) {
					// 	printErr( "Grid entity mismatch: $gridEntityId" );
					// }
					final entity = new Entity( positions[y][x], type, owner, organId, organDir, organParentId, organRootId );

					entities.push( entity );
					grid[y][x] = entities.length - 1;

					if( owner == 1 ) myEntities.push( entity );
					// else if( owner == 0 ) oppEntities.push( entity );
					// else neitherEntities.push( entity );
				// }
			}
			final inputs = readline().split(' ');
			// printErr( 'my inputs: ${inputs.join(" ")}' );
			final myA = parseInt( inputs[0] );
			final myB = parseInt( inputs[1] );
			final myC = parseInt( inputs[2] );
			final myD = parseInt( inputs[3] ); // your protein stock
			final inputs = readline().split(' ');
			// printErr( 'opp inputs: ${inputs.join(" ")}' );
			final oppA = parseInt( inputs[0] );
			final oppB = parseInt( inputs[1] );
			final oppC = parseInt( inputs[2] );
			final oppD = parseInt( inputs[3] ); // opponent's protein stock
			final requiredActionsCount = parseInt( readline() ); // your number of organisms, output an action for each one in any order
			// printErr( 'requiredActionsCount: $requiredActionsCount' );
			
			ai.setInputs( requiredActionsCount, entities, myEntities, myA, myB, myC, myD );

			final outputs = ai.process();
			// printErr( outputs );
			print( outputs );
		}
	}

	static function checkEntityMatch( entity:Entity, type:String, owner:Int, organId:Int, organDir:String, organParentId:Int, organRootId:Int ) {
		if( entity.type != type ) return false;
		if( entity.owner != owner ) return false;
		if( entity.organId != organId ) return false;
		if( entity.organDir != organDir ) return false;
		if( entity.organParentId != organParentId ) return false;
		if( entity.organRootId != organRootId ) return false;
		return true;
	}
}