package ai.versions;

import CodinGame.printErr;
import CodinGame.readline;
import ai.IAi;
import ai.data.RegisterDataset;

using Lambda;

class Left implements IAi {
	public var aiId = "Wait";
	
	public function new() { }
	
	public function setGlobalInputs( playerIdx:Int, nbGames:Int ) { }
	
	public function setInputs( scoreInfos:Array<String>, registerDataset:Array<RegisterDataset>) {	}

	// MOVE <x> <y> <light (1|0)> | WAIT <light (1|0)>
	public function process() {
		return "LEFT";
	}
}
