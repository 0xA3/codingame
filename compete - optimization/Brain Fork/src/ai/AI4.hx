package ai;

import xa3.MathUtils.abs;

using Converter;
using Distance;

// add loop move to next space
// score local  5850
// score online 5842
class AI4 extends AI {
	
	public function process( magicPhrase:String ) {
		
		final charCodes = magicPhrase.separate( charMap );
	
		var position = 0;
	
		final zoneValues = [for( _ in 0...numZones ) 0];
		final posOffsets = [1, -1, 0, 2, -2, 3, -3, 4, -4, 5, -5, 6, -6, 7, -7, 8, -8, 9, -9, 10, -10, 11, -11, 12, -12, 13, -13, 14, -14, 15];
	
		for( c in charCodes ) {
			// trace( 'char $c ${charCodeMap[c] )}' );
			var dPos = numZones;
			var dValue = alphabet.length;
			var minDistance = dPos + dValue;
			for( posOffset in posOffsets ) {
				if( posOffset > minDistance ) break;
				final zone = ( numZones + position + posOffset ) % numZones;
				final valueOffset = zoneValues[zone].getDistance( c, alphabet.length );
				final sum = abs( posOffset ) + abs( valueOffset );
				if( sum < minDistance ) {
					minDistance = sum;
					dPos = posOffset;
					dValue = valueOffset;
				}
			}

			if( c == 0 && minDistance > 3 ) { // char is space and distance > 3
				commands.push( "[" );
				commands.push( ">" );
				commands.push( "]" );
				while( zoneValues[position] != 0 ) {
					position++;
					if( position >= numZones ) position = 0;
				}
			} else {
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
			}
			commands.push( "." );
			// trace( commands.join( "" ));
		}
	
		return commands.join( "" );
	}
}