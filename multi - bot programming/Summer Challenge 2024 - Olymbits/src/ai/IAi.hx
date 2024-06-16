package ai;

import ai.data.RegisterDataset;

interface IAi {
	function setGlobalInputs( playerIdx:Int, nbGames:Int ):Void;
	function setInputs(	scoreInfos:Array<String>, registerDataset:Array<RegisterDataset> ):Void;
	function process():String;
}