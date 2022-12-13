package agent;

import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import game.Config;
import game.GameEntity;
import game.Player;
import game.Vector;
import haxe.ds.GenericStack.GenericCell;

using Lambda;
using xa3.MathUtils;

class Agent implements IAgent {
	
	var width:Int;
	var height:Int;

	var field:Field;
	var me:Player;
	var opp:Player;
	public var players:Array<Player>;

	final actions = [];
	
	var turn = 0;
	public var agentId = "";
	var spentMana = 0;

	public function new() { }
	
	public function init( inputLines:Array<String> ) {
		// trace( 'init agent $agentId\n' + inputLines.join( "\n" ) );
		final inputs = inputLines[0].split(' ');
		width = parseInt( inputs[0] );
		height = parseInt( inputs[1] );
		
		field = new Field( width, height );
		me = new Player( 0, "me" );
		opp = new Player( 1, "opponent" );
		players = [me, opp];
		
		var id = 0;
	}
	
	public function setInputs( inputLines:Array<String> ) {
		// trace( 'setInputs agent $agentId\n' + inputLines.join( "\n" ));
		
		final inputs = inputLines[0].split(' ');
		final myMatter = parseInt( inputs[0] );
		final oppMatter = parseInt( inputs[1] );

		for( y in 0...height ) {
			for( x in 0...width ) {
				final inputs = readline().split(" ");
				final cell:Cell = {
					scrapAmount: parseInt( inputs[0] ),
					owner: parseInt( inputs[1] ),
					units: parseInt( inputs[2] ),
					recycler: parseInt( inputs[3] ),
					canBuild: parseInt( inputs[4] ),
					canSpawn: parseInt( inputs[5] ),
					inRangeOfRecycler: parseInt( inputs[6] )
				}
				final index = y * width + x;
				field.cells[index] = cell;
			}
		}
	}
	
	public function process() {
		return "WAIT";
	}
	
	function printActions() {
		return actions.join( "\n" );
	}
}
