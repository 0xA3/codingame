import Std.parseInt;
import ai.IAi;
import ai.MainAi;

class AiConnector {
	
	final ais:Array<IAi>;
	final inputStream:haxe.ds.List<String>;

	var turn = 0;
	var numberOfCells:Int;
	var nextPlayerInputLines = new haxe.ds.List<String>();

	public function new( ais:Array<IAi>, inputStream:haxe.ds.List<String> ) {
		this.ais = ais;
		this.inputStream = inputStream;
	}

	public function reset() {
		turn = 0;
	}

	public function handleNextPlayerInfo( s:String ) {
		final infoLines = s.split( "\n" );
		final nextPlayer = parseInt( infoLines[0] );
		
		if( turn == 0 ) {
			numberOfCells = parseInt( readline() ); // amount of hexagonal cells in this map
			final cellDatasets = [for( _ in 0...numberOfCells ) MainAi.parseCellDataset( readline())];
			
			final numberOfBases = parseInt( readline() );
			
			final inputs = readline().split(' ');
			final myBaseIndices:Array<Int> = [];
			for( i in 0...numberOfBases ) myBaseIndices.push( parseInt( inputs[i] ));
			
			final inputs = readline().split(' ');
			final oppBaseIndices:Array<Int> = [];
			for( i in 0...numberOfBases ) oppBaseIndices.push( parseInt( inputs[i] ));
			
			ais[nextPlayer].setGlobalInputs( cellDatasets, myBaseIndices, oppBaseIndices );

			// trace( 'numberOfCells $numberOfCells' );
			// trace( 'cellDatasets ${cellDatasets.length}' );
			// trace( 'numberOfBases $numberOfBases' );
			// trace( 'oppBaseIndices ${oppBaseIndices.length}' );
		}

		final scores = readline().split(' ').map( s -> parseInt( s ));
		// trace( 'scores ${scores.join(" ")}' );
		final frameCellDatasets = [for( _ in 0...numberOfCells ) MainAi.parseFrameCellDataset( readline())];
		ais[nextPlayer].setInputs( scores[0], scores[1], frameCellDatasets );

		final outputs = ais[nextPlayer].process();
		// trace( 'player $nextPlayer: $outputs' );
		inputStream.add( outputs );
		
		inputStream.add( "GET_GAME_INFO" );
		// trace( 'inputStream.add( GET_GAME_INFO )' );
		inputStream.add( "SET_PLAYER_OUTPUT 1" );
		// trace( 'inputStream.add( SET_PLAYER_OUTPUT 1 )' );

		if( nextPlayer == ais.length - 1 ) turn++;
	}

	public function handleNextPlayerInput( s:String ) {
		nextPlayerInputLines.clear();
		final lines = s.split( "\n" );
		for( line in lines ) nextPlayerInputLines.add( line );
	}

	function readline() {
		if( nextPlayerInputLines.length == 0 ) throw 'Error: nextplayerInputLines is empty';
		return nextPlayerInputLines.pop();
	}
}