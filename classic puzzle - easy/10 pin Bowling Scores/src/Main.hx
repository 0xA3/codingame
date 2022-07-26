import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;
using StringTools;

final zero:Frame = { pinIds: [], isSpare: false, strikes: [] }

function main() {

	final n = parseInt( readline() );
	final games = [for( _ in 0...n ) readline()];

	final result = process( games );
	print( result );
}

function process( games:Array<String> ) {
	final frames = games.map( game -> processFrames( game.split(" ")));
	
	final output = frames.map( frame -> frame.join(" ")).join( "\n" );
	return output;
}

function processFrames( frameStrings:Array<String> ) {
	final frames:Array<Frame> = [];
	final pins:Array<Int> = [];
	
	var pinId = 0;
	for( i in 0...frameStrings.length ) {
		final pinIds = [];
		final strikes = [];
		final attempts = frameStrings[i].replace( "-", "0" ).split( "" );
		for( i in 0...attempts.length ) {
			final frame = attempts[i] == "X" ? 10 : attempts[i] == "/" ? 10 - pins[pins.length - 1] : parseInt( attempts[i] );
			pinIds.push( pinId );
			strikes.push( attempts[i] == "X" );
			pins[pinId] = frame;
			pinId++;
		}
		final isSpare = attempts.contains( "/" );

		final frame:Frame = { pinIds: pinIds, isSpare: isSpare, strikes:strikes }
		frames[i] = frame;
		
		final totals = getTotals( frames, pins );
		// trace( '${frames[i].pinIds.map( pinId -> pins[pinId] )} ${( frames[i].isSpare ? "spare " : "" )}' + totals.join( " " ));
	}

	final totals = getTotals( frames, pins );
	// trace( "Totals: " + totals.join( " " ));
	// final totals = frames.map( frame -> frame.total );
	// trace( totals.join(" "));
	return totals;
}

function getTotals( frames:Array<Frame>, pins:Array<Int> ) {
	final totals = [];
	
	for( i in 0...frames.length ) {
		final frame = frames[i];
		
		var spareScore = 0;
		if( frame.isSpare && i < frames.length - 1 ) {
			final nextFrameFirstPinId = frames[i + 1].pinIds[0];
			spareScore = pins[nextFrameFirstPinId];
		}

		var pinScoreSum = 0;
		var strikeScore = 0;
		for( p in 0...frame.pinIds.length ) {
			final pinId = frame.pinIds[p];
			final pinScore = pins[pinId];
			pinScoreSum += pinScore;
			
			if( i < 9 && frame.strikes[p] ) {
				if( pins.length > pinId + 1 ) strikeScore += pins[pinId + 1];
				if( pins.length > pinId + 2 ) strikeScore += pins[pinId + 2];
			}
		}
		final prevTotal = i > 0 ? totals[i - 1] : 0;
		totals[i] = prevTotal + spareScore + strikeScore + pinScoreSum;
		// trace( '$i  prevTotal $prevTotal  spareScore $spareScore  strikeScore $strikeScore  pinScoreSum $pinScoreSum : ${totals[i]}' );
	}

	return totals;
}

function getNext2Pins( frames:Array<Frame>, i:Int, p:Int ) {
	var offset = 1;

}

// function outputFrame( frame:Frame ) return '${frame.pins} ${(frame.isSpare ? "spare" : "" )}${(frame.strikes > 0 ? "strike" : "")}';

typedef Frame = {
	final pinIds:Array<Int>;
	final isSpare:Bool;
	final strikes:Array<Bool>;
}

