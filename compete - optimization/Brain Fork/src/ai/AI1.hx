package ai;

import xa3.MathUtils.abs;

using Converter;
using Distance;

class AI1 extends AI {
	
	public function process( magicPhrase:String ) {
		
		final charCodes = magicPhrase.separate( charMap );
	
		var position = 0;
	
		final zoneValues = [for( _ in 0...numZones ) 0];
		final commands = [];
	
		for( c in charCodes ) {
			// trace( 'char $c ${charCodeMap[c] )}' );
			var dPos = numZones;
			var dValue = alphabet.length;
			var minDistance = dPos + dValue;
			for( z in 0...numZones ) {
				final posOffset = position.getDistance( z, numZones );
				final valueOffset = zoneValues[z].getDistance( c, alphabet.length );
				final sum = abs( posOffset ) + abs( valueOffset );
				if( sum < minDistance ) {
					minDistance = sum;
					dPos = posOffset;
					dValue = valueOffset;
				}
			}
			position = ( numZones + position + dPos ) % numZones;
			zoneValues[position] = ( alphabet.length + zoneValues[position] + dValue ) % alphabet.length;
			// trace( 'dPos $dPos  dValue $dValue' );
			final posCommand = dPos > 0 ? ">" : "<";
			final distancePos = abs( dPos );
			for( _ in 0...distancePos ) {
				commands.push( posCommand );
			}
			
			final valueCommand = dValue > 0 ? "+" : "-";
			final distanceValue = abs( dValue );
			for( _ in 0...distanceValue ) commands.push( valueCommand );
			commands.push( "." );
			// trace( commands.join( "" ));
		}
	
		return commands.join( "" );
	
	}
}