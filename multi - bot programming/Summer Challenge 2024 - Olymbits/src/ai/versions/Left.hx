package ai.versions;

import CodinGame.printErr;
import CodinGame.readline;
import ai.IAi;

using Lambda;

class Left implements IAi {
	public var aiId = "Wait";
	
	public function new() { }
	
	public function setGlobalInputs( playerIdx:Int, nbGames:Int ) { }
	
	public function setInputs(
		scoreInfos:Array<String>,
		gpu:String,
		reg0:Int,
		reg1:Int,
		reg2:Int,
		reg3:Int,
		reg4:Int,
		reg5:Int,
		reg6:Int
	) {	}

	public function init() { }

	// MOVE <x> <y> <light (1|0)> | WAIT <light (1|0)>
	public function process() {
		return "LEFT";
	}
}
