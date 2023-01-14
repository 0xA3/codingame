/**
 * Auto-generated code below aims at helping you parse
 * the standard input according to the problem statement.
 **/

class Main {
	
	static function main() {
		
		final robbersQuantity = Std.parseInt( CodinGame.readline());
		final vaultsQuantity = Std.parseInt( CodinGame.readline());
		// CodinGame.printErr( 'robbersQuantity: $robbersQuantity' );
		// CodinGame.printErr( 'vaultsQuantity: $vaultsQuantity' );
		
		final vaultDurations:Array<Float> = [];
		for ( i in 0...vaultsQuantity ) {
			
			var inputs =  CodinGame.readline().split(' ');
			final characters = Std.parseInt(inputs[0]);
			final digits = Std.parseInt(inputs[1]);
			final vovels = characters - digits;
			// CodinGame.printErr( 'vault $i -  digits: ${digits}  vovels: ${vovels}' );
			final timeForVault = Math.pow( 10, digits ) * Math.pow( 5, vovels );
			vaultDurations.push( timeForVault );
		}

		final robbersTimes = [for( i in 0...robbersQuantity) 0.0 ];
		
		var vaultId = 0;
		while( vaultId < vaultDurations.length ) {
			final robberIdWithLowestTime = minIndex( robbersTimes );
			robbersTimes[robberIdWithLowestTime] += vaultDurations[vaultId];
			vaultId++;
		}

		robbersTimes.sort(( a, b ) -> {
			if (a < b) return -1;
  			else if (a > b) return 1;
  			return 0;
		});

		CodinGame.print( robbersTimes[robbersTimes.length - 1]);

	}

	static function minIndex( robbersTimes:Array<Float> ):Int {
		
		final times = robbersTimes.copy();
		times.sort(( a, b ) -> {
			if (a < b) return -1;
  			else if (a > b) return 1;
  			return 0;
		});
		
		return robbersTimes.indexOf( times[0] );
	}

}
