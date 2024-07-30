package test;

import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Easy", {
				final ip = easy;
				Main.process( ip.tiles, ip.width, ip.height, ip.emptyBoardRows, ip.previousWordBoardRows, ip.playedWordBoardRows ).should.be( easyResult );
			});
			it( "Double letter score", {
				final ip = doubleLetterScore;
				Main.process( ip.tiles, ip.width, ip.height, ip.emptyBoardRows, ip.previousWordBoardRows, ip.playedWordBoardRows ).should.be( doubleLetterScoreResult );
			});
			it( "Triple letter score", {
				final ip = tripleLetterScore;
				Main.process( ip.tiles, ip.width, ip.height, ip.emptyBoardRows, ip.previousWordBoardRows, ip.playedWordBoardRows ).should.be( tripleLetterScoreResult );
			});
			it( "Double word score", {
				final ip = doubleWordScore;
				Main.process( ip.tiles, ip.width, ip.height, ip.emptyBoardRows, ip.previousWordBoardRows, ip.playedWordBoardRows ).should.be( doubleWordScoreResult );
			});
			it( "Triple word score", {
				final ip = tripleWordScore;
				Main.process( ip.tiles, ip.width, ip.height, ip.emptyBoardRows, ip.previousWordBoardRows, ip.playedWordBoardRows ).should.be( tripleWordScoreResult );
			});
			it( "Multiple multiplicator", {
				final ip = multipleMultiplicator;
				Main.process( ip.tiles, ip.width, ip.height, ip.emptyBoardRows, ip.previousWordBoardRows, ip.playedWordBoardRows ).should.be( multipleMultiplicatorResult );
			});
			it( "Count the 2 words", {
				final ip = countThe_2Words;
				Main.process( ip.tiles, ip.width, ip.height, ip.emptyBoardRows, ip.previousWordBoardRows, ip.playedWordBoardRows ).should.be( countThe_2WordsResult );
			});
			it( "Special cell on 2 words", {
				final ip = specialCellOn_2Words;
				Main.process( ip.tiles, ip.width, ip.height, ip.emptyBoardRows, ip.previousWordBoardRows, ip.playedWordBoardRows ).should.be( specialCellOn_2WordsResult );
			});
			it( "Complete previous word", {
				final ip = completePreviousWord;
				Main.process( ip.tiles, ip.width, ip.height, ip.emptyBoardRows, ip.previousWordBoardRows, ip.playedWordBoardRows ).should.be( completePreviousWordResult );
			});
			it( "Combo", {
				final ip = combo;
				Main.process( ip.tiles, ip.width, ip.height, ip.emptyBoardRows, ip.previousWordBoardRows, ip.playedWordBoardRows ).should.be( comboResult );
			});
			it( "Blank is important", {
				final ip = blankIsImportant;
				Main.process( ip.tiles, ip.width, ip.height, ip.emptyBoardRows, ip.previousWordBoardRows, ip.playedWordBoardRows ).should.be( blankIsImportantResult );
			});
			it( "Multiple multiplicator 2", {
				final ip = multipleMultiplicator_2;
				Main.process( ip.tiles, ip.width, ip.height, ip.emptyBoardRows, ip.previousWordBoardRows, ip.playedWordBoardRows ).should.be( multipleMultiplicator_2Result );
			});
			it( "First word", {
				final ip = firstWord;
				Main.process( ip.tiles, ip.width, ip.height, ip.emptyBoardRows, ip.previousWordBoardRows, ip.playedWordBoardRows ).should.be( firstWordResult );
			});
			it( "Just for fun", {
				final ip = justForFun;
				Main.process( ip.tiles, ip.width, ip.height, ip.emptyBoardRows, ip.previousWordBoardRows, ip.playedWordBoardRows ).should.be( justForFunResult );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
			
		var nbTiles:Int = parseInt( lines[0] ); // Number of tiles in the tile set
		final tiles:Map<String, Int> = [for( i in 0...nbTiles ) {
			final inputs = lines[i + 1].split(" ");
			inputs[0] => parseInt( inputs[1] );
		}];
		var inputs:Array<String> = lines[nbTiles + 1].split(" ");
		var width:Int = parseInt( inputs[0] );
		var height:Int = parseInt( inputs[1] );
		final emptyBoardRows = [for (i in 0...height) lines[nbTiles + 2 + i].split("")]; // Empty board with special cells
		final previousWordBoardRows = [for (i in 0...height) lines[nbTiles + 2 + height + i].split("")]; // Words already played
		final playedWordBoardRows = [for (i in 0...height) lines[nbTiles + 2 + height * 2 + i].split("")]; // Words after you play
	
		return { tiles: tiles, width: width, height: height, emptyBoardRows: emptyBoardRows, previousWordBoardRows: previousWordBoardRows, playedWordBoardRows: playedWordBoardRows };
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final easy = parseInput(
		"27
		A 1
		B 3
		C 3
		D 2
		E 1
		F 4
		G 2
		H 4
		I 1
		J 8
		K 5
		L 1
		M 3
		N 1
		O 1
		P 3
		Q 8
		R 1
		S 1
		T 1
		U 1
		V 4
		W 4
		X 8
		Y 4
		Z 10
		_ 0
		4 4
		W..w
		....
		....
		l..L
		....
		.OR.
		....
		....
		....
		.OR.
		.F..
		...."
	);

	final easyResult = parseResult(
		"OF 5
		Total 5"
	);

	final doubleLetterScore = parseInput(
		"27
		A 1
		B 3
		C 3
		D 2
		E 1
		F 4
		G 2
		H 4
		I 1
		J 8
		K 5
		L 1
		M 3
		N 1
		O 1
		P 3
		Q 8
		R 1
		S 1
		T 1
		U 1
		V 4
		W 4
		X 8
		Y 4
		Z 10
		_ 0
		4 4
		W..w
		....
		....
		l..L
		....
		.O..
		.U..
		.T..
		....
		.O..
		.U..
		IT.."
	);

	final doubleLetterScoreResult = parseResult(
		"IT 3
		Total 3"
	);

	final tripleLetterScore = parseInput(
		"27
		A 1
		B 3
		C 3
		D 2
		E 1
		F 4
		G 2
		H 4
		I 1
		J 8
		K 5
		L 1
		M 3
		N 1
		O 1
		P 3
		Q 8
		R 1
		S 1
		T 1
		U 1
		V 4
		W 4
		X 8
		Y 4
		Z 10
		_ 0
		4 4
		W..w
		....
		....
		l..L
		....
		..S.
		..O.
		..N.
		....
		..S.
		..O.
		.ANY"
	);

	final tripleLetterScoreResult = parseResult(
		"ANY 14
		Total 14"
	);

	final doubleWordScore = parseInput(
		"27
		A 1
		B 3
		C 3
		D 2
		E 1
		F 4
		G 2
		H 4
		I 1
		J 8
		K 10
		L 1
		M 2
		N 1
		O 1
		P 3
		Q 8
		R 1
		S 1
		T 1
		U 1
		V 4
		W 10
		X 10
		Y 10
		Z 10
		_ 0
		4 4
		W..w
		....
		....
		l..L
		....
		....
		.ROI
		....
		...Q
		...U
		.ROI
		...."
	);

	final doubleWordScoreResult = parseResult(
		"QUI 20
		Total 20"
	);

	final tripleWordScore = parseInput(
		"27
		A 1
		B 3
		C 3
		D 2
		E 1
		F 4
		G 2
		H 4
		I 1
		J 8
		K 10
		L 1
		M 2
		N 1
		O 1
		P 3
		Q 8
		R 1
		S 1
		T 1
		U 1
		V 4
		W 10
		X 10
		Y 10
		Z 10
		_ 0
		10 8
		l........w
		..........
		..........
		..........
		..........
		..........
		..........
		W........L
		..........
		....F.....
		....R.....
		....O.....
		....M.....
		....A.....
		....G.....
		....E.....
		..........
		....F.....
		....R.....
		....O.....
		....M.....
		....A.....
		....G.....
		OMELETTE.."
	);

	final tripleWordScoreResult = parseResult(
		"OMELETTE 27
		Bonus 50
		Total 77"
	);

	final multipleMultiplicator = parseInput(
		"26
		A 1
		B 3
		C 3
		D 2
		E 1
		F 4
		G 2
		H 4
		I 1
		J 8
		L 1
		M 3
		N 1
		~ 8
		O 1
		P 3
		Q 5
		R 1
		S 1
		T 1
		U 1
		V 4
		X 8
		Y 4
		Z 10
		_ 0
		7 7
		W..w..W
		.w...w.
		..w.w..
		w..W..w
		..w.w..
		.w...w.
		W..w..W
		.......
		...T...
		...I...
		...E...
		.CAMINO
		...P...
		...O...
		.......
		...T...
		...I...
		...E..C
		.CAMINO
		...P..S
		...O..A"
	);
	
	final multipleMultiplicatorResult = parseResult(
		"COSA 36
		Total 36"
	);

	final countThe_2Words = parseInput(
		"27
		A 1
		B 3
		C 3
		D 2
		E 1
		F 4
		G 2
		H 4
		I 1
		J 8
		K 5
		L 1
		M 3
		N 1
		O 1
		P 3
		Q 8
		R 1
		S 1
		T 1
		U 1
		V 4
		W 4
		X 8
		Y 4
		Z 10
		_ 0
		7 7
		W..L..W
		.w...w.
		..l.l..
		L..w..L
		..l.l..
		.w...w.
		W..L..W
		.TEST..
		..A....
		..S....
		..T....
		.......
		.......
		.......
		.TESTS.
		..A..I.
		..S..C.
		..T..K.
		.......
		.......
		......."
	);
	
	final countThe_2WordsResult = parseResult(
		"SICK 20
		TESTS 5
		Total 25"
	);

	final specialCellOn_2Words = parseInput(
		"27
		A 1
		B 3
		C 3
		D 2
		E 1
		F 4
		G 2
		H 4
		I 1
		J 8
		K 5
		L 1
		M 3
		N 1
		O 1
		P 3
		Q 8
		R 1
		S 1
		T 1
		U 1
		V 4
		W 4
		X 8
		Y 4
		Z 10
		_ 0
		15 15
		W..l...W...l..W
		.w...L...L...w.
		..w...l.l...w..
		l..w...l...w..l
		....w.....w....
		.L...L...L...L.
		..l...l.l...l..
		W......w......W
		..l...l.l...l..
		.L...L...L...L.
		....w.....w....
		l..w...l...w..l
		..w...l.l...w..
		.w...L...L...w.
		W..l...W...l..W
		........BURGER.
		..........O....
		..........L....
		.........PLANTS
		..........I....
		..........N....
		.......GANG....
		.......O.......
		...............
		...............
		...............
		...............
		...............
		...............
		...............
		........BURGERS
		..........O...C
		..........L...I
		.........PLANTS
		..........I...S
		..........N...O
		.......GANG...R
		.......O.......
		...............
		...............
		...............
		...............
		...............
		...............
		..............."
	);
	
	final specialCellOn_2WordsResult = parseResult(
		"BURGERS 30
		SCISSOR 27
		Total 57"
	);

	final completePreviousWord = parseInput(
		"27
		A 1
		B 3
		C 3
		D 2
		E 1
		F 4
		G 2
		H 4
		I 1
		J 8
		K 10
		L 1
		M 2
		N 1
		O 1
		P 3
		Q 8
		R 1
		S 1
		T 1
		U 1
		V 4
		W 10
		X 10
		Y 10
		Z 10
		_ 0
		15 15
		W..l...W...l..W
		.w...L...L...w.
		..w...l.l...w..
		l..w...l...w..l
		....w.....w....
		.L...L...L...L.
		..l...l.l...l..
		W......w......W
		..l...l.l...l..
		.L...L...L...L.
		....w.....w....
		l..w...l...w..l
		..w...l.l...w..
		.w...L...L...w.
		W..l...W...l..W
		........C......
		........A......
		........R......
		.....VERTE.....
		.....I..E......
		.....A.........
		.....N.........
		.....D.Q.B.....
		....RECULE.....
		.......I.LYNX..
		......W..L.....
		.....TOMBEZ....
		......K.O......
		........U......
		........CLE....
		........C......
		........A......
		........R......
		.....VERTE.....
		.....I..E......
		.....A.........
		.....N.........
		.....D.Q.B.....
		....RECULE.....
		.......I.LYNX..
		......W..L.....
		.....TOMBEZ....
		......K.O......
		........U......
		......RACLETTE."
	);
	
	final completePreviousWordResult = parseResult(
		"RACLETTE 33
		Total 33"
	);

	final combo = parseInput(
		"27
		A 1
		B 3
		C 3
		D 2
		E 1
		F 4
		G 2
		H 4
		I 1
		J 8
		K 5
		L 1
		M 3
		N 1
		O 1
		P 3
		Q 8
		R 1
		S 1
		T 1
		U 1
		V 4
		W 4
		X 8
		Y 4
		Z 10
		_ 0
		15 15
		W..l...W...l..W
		.w...L...L...w.
		..w...l.l...w..
		l..w...l...w..l
		....w.....w....
		.L...L...L...L.
		..l...l.l...l..
		W......w......W
		..l...l.l...l..
		.L...L...L...L.
		....w.....w....
		l..w...l...w..l
		..w...l.l...w..
		.w...L...L...w.
		W..l...W...l..W
		........BURGER.
		..........O....
		..........L....
		.........PLANT.
		..........I....
		..........N....
		.......GANG....
		.......O.......
		...............
		...............
		...............
		...............
		...............
		...............
		...............
		........BURGERS
		..........O...A
		..........L...L
		.........PLANTS
		..........I...I
		..........N...F
		.......GANG...Y
		.......O.......
		...............
		...............
		...............
		...............
		...............
		...............
		..............."
	);
	
	final comboResult = parseResult(
		"BURGERS 30
		PLANTS 9
		SALSIFY 42
		Bonus 50
		Total 131"
	);

	final blankIsImportant = parseInput(
		"27
		A 1
		B 3
		C 3
		D 2
		E 1
		F 4
		G 2
		H 4
		I 1
		J 8
		K 10
		L 1
		M 2
		N 1
		O 1
		P 3
		Q 8
		R 1
		S 1
		T 1
		U 1
		V 4
		W 10
		X 10
		Y 10
		Z 10
		_ 0
		15 15
		W..l...W...l..W
		.w...L...L...w.
		..w...l.l...w..
		l..w...l...w..l
		....w.....w....
		.L...L...L...L.
		..l...l.l...l..
		W......w......W
		..l...l.l...l..
		.L...L...L...L.
		....w.....w....
		l..w...l...w..l
		..w...l.l...w..
		.w...L...L...w.
		W..l...W...l..W
		...............
		...............
		...............
		.......S.......
		....JUDO.......
		.......L...P...
		.......D..KA...
		.......EWE.R...
		........O..T...
		......MANQUE...
		......I..A.ZOOS
		......S..T....E
		......S.......X
		..............Y
		...............
		...............
		...............
		...............
		.......S.......
		....JUDO.......
		.......L...P...
		.......D..KA...
		.......EWE.R...
		........O..T...
		......MANQUE...
		......I..A.ZOOS
		......S..T....E
		......S.......X
		..............Y
		.............._"
	);
	
	final blankIsImportantResult = parseResult(
		"SEXY_ 66
		Total 66"
	);

	final multipleMultiplicator_2 = parseInput(
		"26
		A 1
		B 3
		C 3
		D 2
		E 1
		F 4
		G 2
		H 4
		I 1
		J 8
		L 1
		M 3
		N 1
		~ 8
		O 1
		P 3
		Q 5
		R 1
		S 1
		T 1
		U 1
		V 4
		X 8
		Y 4
		Z 10
		_ 0
		15 15
		W..l...W...l..W
		.w...L...L...w.
		..w...l.l...w..
		l..w...l...w..l
		....w.....w....
		.L...L...L...L.
		..l...l.l...l..
		W......w......W
		..l...l.l...l..
		.L...L...L...L.
		....w.....w....
		l..w...l...w..l
		..w...l.l...w..
		.w...L...L...w.
		W..l...W...l..W
		.........M.....
		.........A.....
		.......NI~O....
		.........A.....
		.......D.N.....
		....P.VIDA.....
		....A..N.......
		....L..E.......
		....A..R.......
		.TRABAJO.......
		....R..........
		....AMIGO......
		...............
		...............
		...............
		.......FAMILIAS
		.........A.....
		.......NI~O....
		.........A.....
		.......D.N.....
		....P.VIDA.....
		....A..N.......
		....L..E.......
		....A..R.......
		.TRABAJO.......
		....R..........
		....AMIGO......
		...............
		...............
		..............."
	);
	
	final multipleMultiplicator_2Result = parseResult(
		"FAMILIAS 126
		Bonus 50
		Total 176"
	);

	final firstWord = parseInput(
		"27
		A 1
		B 3
		C 3
		D 2
		E 1
		F 4
		G 2
		H 4
		I 1
		J 8
		K 10
		L 1
		M 2
		N 1
		O 1
		P 3
		Q 8
		R 1
		S 1
		T 1
		U 1
		V 4
		W 10
		X 10
		Y 10
		Z 10
		_ 0
		15 15
		W..l...W...l..W
		.w...L...L...w.
		..w...l.l...w..
		l..w...l...w..l
		....w.....w....
		.L...L...L...L.
		..l...l.l...l..
		W......w......W
		..l...l.l...l..
		.L...L...L...L.
		....w.....w....
		l..w...l...w..l
		..w...l.l...w..
		.w...L...L...w.
		W..l...W...l..W
		...............
		...............
		...............
		...............
		...............
		...............
		...............
		...............
		...............
		...............
		...............
		...............
		...............
		...............
		...............
		...............
		...............
		...............
		...............
		...............
		...............
		...............
		....PREMIER....
		...............
		...............
		...............
		...............
		...............
		...............
		..............."
	);
	
	final firstWordResult = parseResult(
		"PREMIER 20
		Bonus 50
		Total 70"
	);

	final justForFun = parseInput(
		"2
		0 1
		1 2
		15 15
		W..l...W...l..W
		.w...L...L...w.
		..w...l.l...w..
		l..w...l...w..l
		....w.....w....
		.L...L...L...L.
		..l...l.l...l..
		W......w......W
		..l...l.l...l..
		.L...L...L...L.
		....w.....w....
		l..w...l...w..l
		..w...l.l...w..
		.w...L...L...w.
		W..l...W...l..W
		...............
		...............
		...............
		...............
		........0......
		........1......
		........1......
		.....01010.....
		......0.1......
		......0........
		......1........
		...0001011.....
		...............
		...............
		...............
		...............
		...............
		...............
		...............
		........0......
		........1......
		........1......
		.....01010.....
		......0.1......
		......0........
		......1........
		...0001011.....
		......0110001..
		...............
		..............."
	);
	
	final justForFunResult = parseResult(
		"01 3
		0110001 26
		10 3
		100110 10
		11 6
		Bonus 50
		Total 98"
	);

}
