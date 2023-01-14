package test;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			it( "X", { Main.process( x ).should.be( xResult ); });
			it( "Square", { Main.process( square ).should.be( squareResult ); });
			it( "Coding Games", { Main.process( codinGames ).should.be( codinGamesResult );	});
			it( "ASCII", { Main.process( ascii ).should.be( asciiResult ); });
		});
			
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		return [for( i in 1...lines.length) lines[i].split( "" )];
	}
	
	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}
	
	static function compare( output:String, result:String) {
		final oLines = output.split( "\n" );
		final rLines = result.split( "\n" );
		if( oLines.length != rLines.length ) throw 'Error: lines number doesn\'t match: output ${oLines.length}  result ${rLines.length}';
		for( i in 0...oLines.length ) {
			if( oLines[i] != rLines[i] ) trace( 'difference in line $i\noutput\n${oLines[i]}\nresult\n${rLines[i]}' );
		}
	}

	final x = parseInput(
		"7
		  #     #
		   #   #
		    # #
		     #
		    # #
		   #   #
		  #     #"
	);

	final xResult = parseResult(
		"  #     #
		   #   # -
		    # # - `
		     # - `
		    # # `
		   # - #
		  # - ` #
		   - `   -
		    `     `"
	);

	final square = parseInput(
		"5
		###########
		##       ##
		##       ##
		##       ##
		###########"
	);

	final squareResult = parseResult(
		"###########
		##-------##-
		##-``````##-`
		##-`     ##-`
		###########-`
		 -----------`
		  ```````````"
	);
	
	final codinGames = parseInput(
		"15
		 ######   #######  ########  #### ##    ##  ######
		##    ## ##     ## ##     ##  ##  ###   ## ##    ##
		##       ##     ## ##     ##  ##  ####  ## ##
		##       ##     ## ##     ##  ##  ## ## ## ##   ####
		##       ##     ## ##     ##  ##  ##  #### ##    ##
		##    ## ##     ## ##     ##  ##  ##   ### ##    ##
		 ######   #######  ########  #### ##    ##  ######
	   
		 ######      ###    ##     ## ########  ######
		##    ##    ## ##   ###   ### ##       ##    ##
		##         ##   ##  #### #### ##       ##
		##   #### ##     ## ## ### ## ######    ######
		##    ##  ######### ##     ## ##             ##
		##    ##  ##     ## ##     ## ##       ##    ##
		 ######   ##     ## ##     ## ########  ######"
	);
	
	final codinGamesResult = parseResult(
		" ######   #######  ########  #### ##    ##  ######
		##----## ##-----## ##-----##  ##--###   ##-##----##
		##-````--##-````##-##-````##- ##-`####  ##-##-````--
		##-`    `##-`   ##-##-`   ##-`##-`##-## ##-##-` ####`
		##-`     ##-`   ##-##-`   ##-`##-`##-`####-##-`  ##--
		##-`  ## ##-`   ##-##-`   ##-`##-`##-` ###-##-`  ##-``
		 ######-- #######--########--####`##-`  ##-`######--`
		  ------`` -------``--------``---- --`   --` ------``
		 ######``   `###``` ##`````## ########  ######``````
		##----##    ##-##   ###   ###-##-------##----##
		##-````--  ##--`##  #### ####-##-``````##-````--
		##-` ####`##--`` ## ##-###-##-######    ###### ``
		##-`  ##--#########-##-`---##-##-----    ----##
		##-`  ##-`##-----##-##-` ``##-##-````` ## ```##-
		 ######--`##-````##-##-`   ##-########  ######--`
		  ------`` --`    --`--`    --`--------  ------``
		   ``````   ``     `` ``     `` ````````  ``````"
	);

	final ascii = parseInput(
		"7
		      db       .M\"\"\"bgd   .g8\"\"\"bgd `7MMF'`7MMF'
		     ;MM:     ,MI    \"Y .dP'     `M   MM    MM
		    ,V^MM.    `MMb.     dM'       `   MM    MM
		   ,M  `MM      `YMMNq. MM            MM    MM
		   AbmmmqMA   .     `MM MM.           MM    MM
		  A'     VML  Mb     dM `Mb.     ,'   MM    MM
		.AMA.   .AMMA.P\"Ybmmd\"    `\"bmmmd'  .JMML..JMML."
	);
	
	final asciiResult = parseResult(
		"      db       .M\"\"\"bgd   .g8\"\"\"bgd `7MMF'`7MMF'
		     ;MM:     ,MI----\"Y-.dP'-----`M- -MM----MM---
		    ,V^MM.    `MMb.```--dM'--``````-` MM-```MM-```
		   ,M--`MM-    -`YMMNq.`MM--``     -` MM-`  MM-`
		   AbmmmqMA`  . `---`MM-MM.``       ` MM-`  MM-`
		  A'-----VML  Mb  ```dM-`Mb.     ,'   MM-`  MM-`
		.AMA.```.AMMA.P\"Ybmmd\"--`-`\"bmmmd'--.JMML..JMML.
		 -----   --------------`` `--------``------------
		  `````   ``````````````    ````````  ````````````"
	);

}

