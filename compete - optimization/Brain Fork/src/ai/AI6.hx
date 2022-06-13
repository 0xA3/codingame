package ai;

import xa3.MathUtils.abs;

using Converter;
using Distance;

// add alphabet loop
// score local  5336
// score online
class AI6 extends AI {
	
	public function process( magicPhrase:String ) {
		
		final charCodes = magicPhrase.separate( charMap );
	
		final posOffsets = [1, -1, 0, 2, -2, 3, -3, 4, -4, 5, -5, 6, -6, 7, -7, 8, -8, 9, -9, 10, -10, 11, -11, 12, -12, 13, -13, 14, -14, 15];
	
		var charCounter = 0;
		while( charCounter < charCodes.length ) {
			final c = charCodes[charCounter];
			
			// trace( 'char $c ${charCodeMap[c] )} currentPos $position ${zoneValues[position]} (${charCodeMap[zoneValues[position]]})' );
			
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

			if( c == 0 && minDistance > 3 ) {
				addSpaceLoop(); // char is space and distance > 3
			} else {
				final loopToZLength = checkAlphabetLoop( charCodes, charCounter );
				final loopToALength = checkBackwardsAlphabetLoop( charCodes, charCounter );
				// trace( '$charCounter c $c (${charCodeMap[c])}) loopToZLength $loopToZLength' );
				// trace( '$charCounter char $c (${charCodeMap[c])}) loopToALength $loopToALength' );
				if( loopToZLength >= 4 ) {
					addAlphabetLoop();
					charCounter += loopToZLength;
					zoneValues[position] = 0;
					// trace( 'char zoneValues[$position] ${zoneValues[position]} $zoneValues' );
				} else if( loopToALength >= 4 ) {
					addBackwardsAlphabetLoop();
					charCounter += loopToALength;
					zoneValues[position] = 0;
					// trace( 'char zoneValues[$position] ${zoneValues[position]} $zoneValues' );
				} else {
					addPosCommands( dPos );
					addValueCommands( dValue );
					commands.push( "." );
					
					position = ( numZones + position + dPos ) % numZones;
					zoneValues[position] = ( alphabet.length + zoneValues[position] + dValue ) % alphabet.length;
				}
			}

			// trace( commands.join( "" ));
			charCounter++;
		}
		#if debug trace( commands.join( "" ) ); #end
		return commands.join( "" );
	}
	
	function addPosCommands( dPos:Int ) {
		final posCommand = dPos > 0 ? ">" : "<";
		for( _ in 0...abs( dPos ) ) commands.push( posCommand );
	}

	function addValueCommands( dValue:Int ) {
		final valueCommand = dValue > 0 ? "+" : "-";
		for( _ in 0...abs( dValue ) ) commands.push( valueCommand );
}

	function addSpaceLoop() {
		commands.push( "[" );
		commands.push( ">" );
		commands.push( "]" );
		commands.push( "." );
		while( zoneValues[position] != 0 ) {
			position++;
			if( position >= numZones ) position = 0;
		}
	}

	function checkAlphabetLoop( charCodes:Array<Int>, charCounter:Int ) {
		final currentValue = zoneValues[position];
		if( currentValue == 0 ) return -1;
		final remainingChars = charCodes.length - charCounter;
		final distanceToZ = alphabet.length - currentValue - 1;
		// if( currentValue == 1 ) trace( 'currentValue ${currentValue} (${charCodeMap[currentValue]})  charCounter $charCounter  remainingChars $remainingChars  distanceToZ $distanceToZ' );
		if( remainingChars < distanceToZ ) return -1; // not enough chars left to go to Z

		for( i in 0...distanceToZ ) {
			final necessaryChar = currentValue + i + 1;
			final realChar = charCodes[charCounter + i];
			// if( currentValue == 1 ) trace( 'necessaryChar $necessaryChar (${charCodeMap[necessaryChar]})  realChar $realChar (${charCodeMap[realChar]})' );
			if( necessaryChar != realChar ) return -1;
		}

		return distanceToZ - 1;
	}

	function checkBackwardsAlphabetLoop( charCodes:Array<Int>, charCounter:Int ) {
		final currentValue = zoneValues[position];
		if( currentValue == 0 ) return -1;
		final remainingChars = charCodes.length - charCounter;
		final distanceToA = currentValue - 1;
		// if( charCounter == 1 ) trace( 'checkBackwardsAlphabetLoop currentValue ${currentValue} (${charCodeMap[currentValue]})  remainingChars $remainingChars  distanceToA $distanceToA' );
		if( remainingChars < distanceToA ) return -1; // not enough chars left to go to Z

		for( i in 0...distanceToA ) {
			final necessaryChar = currentValue - i - 1;
			final realChar = charCodes[charCounter + i];
			// trace( 'necessaryChar $necessaryChar (${charCodeMap[necessaryChar]})  realChar $realChar (${charCodeMap[realChar]})' );
			if( necessaryChar != realChar ) return -1;
		}

		return distanceToA - 1;
	}

	function addAlphabetLoop() {
		commands.push( "+" );
		commands.push( "[" );
		commands.push( "." );
		commands.push( "+" );
		commands.push( "]" );
	}
	function addBackwardsAlphabetLoop() {
		commands.push( "-" );
		commands.push( "[" );
		commands.push( "." );
		commands.push( "-" );
		commands.push( "]" );
	}
}