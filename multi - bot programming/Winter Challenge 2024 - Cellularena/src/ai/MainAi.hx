package ai;

import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import ai.data.Entity;

class MainAi {
	
	static function main() {
		final ai = new ai.versions.Wait();
		final inputs = readline().split(' ');
		final width = parseInt( inputs[0] );
		final height = parseInt( inputs[1] );
		// printErr( 'width: $width' );
		// printErr( 'height: $height' );
		ai.setGlobalInputs( width, height );
		
		// game loop
		while( true ) {
			final entityCount = parseInt( readline() );
			// printErr( 'entityCount: $entityCount' );
			final myEntities = [];
			final oppEntities = [];
			final neitherEntities = [];
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

				final entity = new Entity( x, y, type, owner, organId, organDir, organParentId, organRootId );

				if( owner == 1 ) myEntities.push( entity );
				else if( owner == 0 ) oppEntities.push( entity );
				else neitherEntities.push( entity );
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
			
			ai.setInputs( requiredActionsCount, myEntities, myA, myB, myC, myD );

			final outputs = ai.process();
			printErr( outputs );
			print( outputs );
		}
	}
}