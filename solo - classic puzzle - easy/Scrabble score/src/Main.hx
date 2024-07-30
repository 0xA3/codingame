import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using ArrayUtils;
using Lambda;
using StringTools;

function main() {
	var nbTiles:Int = parseInt( readline() ); // Number of tiles in the tile set
	final tiles:Map<String, Int> = [for( i in 0...nbTiles ) {
		final inputs = readline().split(" ");
		inputs[0] => parseInt( inputs[1] );
	}];
	var inputs:Array<String> = readline().split(" ");
	var width:Int = parseInt( inputs[0] );
	var height:Int = parseInt( inputs[1] );
	final emptyBoardRows = [for (i in 0...height) readline().split("")]; // Empty board with special cells
	final previousWordBoardRows = [for (i in 0...height) readline().split("")]; // Words already played
	final playedWordBoardRows = [for (i in 0...height) readline().split("")]; // Words after you play
	
	final result = process( tiles, width, height, emptyBoardRows, previousWordBoardRows, playedWordBoardRows );
	print( result );
}

function process( tiles:Map<String, Int>, width:Int, height:Int, emptyBoardRows:Array<Array<String>>, previousWordBoardRows:Array<Array<String>>, playedWordBoardRows:Array<Array<String>> ) {
	final tileMultipliers = getMultipliers( width, height, emptyBoardRows, "l", "L" );
	final wordMultipliers = getMultipliers( width, height, emptyBoardRows, "w", "W" );
	final diffGrid = getDiffGrid( width, height, previousWordBoardRows, playedWordBoardRows );
	
	final numTilesPlayed = diffGrid.flatten().sum();
	// trace( "TileMultipliers: " + tileMultipliers.join( "" ));
	// trace( "WordMultipliers: " + wordMultipliers.join( "" ));
	// trace( "diffGrid\n" + diffGrid.map( row -> row.join( "" )).join( "\n" ) );
	// trace( "played\n" + playedWordBoardRows.join( "\n" ) );

	final words = [
		getHorizontalWords( width, height, diffGrid, playedWordBoardRows ),
		getVerticalWords( width, height, diffGrid, playedWordBoardRows )
	].flatten();

	words.sort(( a, b ) -> {
		if( a.word < b.word ) return -1;
		if( a.word > b.word ) return 1;
		return 0;
	});

	final scores = words.map( word -> word.getScore( width, tiles, tileMultipliers, wordMultipliers ));
	final total = scores.sum() + ( numTilesPlayed == 7 ? 50 : 0 );
	
	final outputs = [for( i in 0...words.length ) '${words[i].word} ${scores[i]}'];
	if( numTilesPlayed == 7 ) outputs.push( "Bonus 50" );
	outputs.push( 'Total ${total}' );
	
	return outputs.join( "\n" );
}

function getMultipliers( width:Int, height:Int, emptyBoardRows:Array<Array<String>>, doubleChar:String, tripleChar:String ) {
	return [for( y in 0...height ) for( x in 0...width ) emptyBoardRows[y][x] == tripleChar ? 3 : emptyBoardRows[y][x] == doubleChar ? 2 : 1];
}

function getDiffGrid( width:Int, height:Int, previousWordBoardRows:Array<Array<String>>, playedWordBoardRows:Array<Array<String>> ) {
	return [for( y in 0...height ) [for( x in 0...width ) previousWordBoardRows[y][x] != playedWordBoardRows[y][x] ? 1 : 0]];
}

function getHorizontalWords( width:Int, height:Int, diffGrid:Array<Array<Int>>, playedWordBoardRows:Array<Array<String>> ) {
	final words = [];
	for( y in 0...height ) {
		var chars = [];
		var isNewWord = false;
		for( x in 0...width ) {
			if( playedWordBoardRows[y][x] == "." ) {
				if( chars.length > 1 && isNewWord ) {
					words.push( new Word( chars ));
					// trace( 'new Word ${words[words.length - 1]}' );
				}
				chars = [];
				isNewWord = false;
			} else {
				final isJustPlayed = diffGrid[y][x] != 0;
				final char = new Char( playedWordBoardRows[y][x], isJustPlayed, x, y );
				chars.push( char );
				// trace( 'new Char: $char' );
			}
			if( diffGrid[y][x] != 0 ) isNewWord = true;
		}
		if( chars.length > 1 && isNewWord ) {
			words.push( new Word( chars ));
			// trace( 'new Word ${words[words.length - 1]}' );
		}
	}
	return words;
}

function getVerticalWords( width:Int, height:Int, diffGrid:Array<Array<Int>>, playedWordBoardRows:Array<Array<String>> ) {
	final words = [];
	for( x in 0...width ) {
		var chars = [];
		var isNewWord = false;
		for( y in 0...height ) {
			if( playedWordBoardRows[y][x] == "." ) {
				if( chars.length > 1 && isNewWord ) {
					words.push( new Word( chars ));
					// trace( 'new Word ${words[words.length - 1]}' );
				}
				chars = [];
				isNewWord = false;
			} else {
				final isJustPlayed = diffGrid[y][x] != 0;
				final char = new Char( playedWordBoardRows[y][x], isJustPlayed, x, y );
				chars.push( char );
				// trace( 'new Char: $char' );
			}
			if( diffGrid[y][x] != 0 ) isNewWord = true;
		}
		if( chars.length > 1 && isNewWord ) {
			words.push( new Word( chars ));
			// trace( 'new Word ${words[words.length - 1]}' );
		}
	}
	return words;
}