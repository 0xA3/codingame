package ai;

interface IAi {
	function setGlobalInputs( playerIdx:Int, nbGames:Int ):Void;
	function setInputs(
		scoreInfos:Array<String>,
		gpu:String,
		reg0:Int,
		reg1:Int,
		reg2:Int,
		reg3:Int,
		reg4:Int,
		reg5:Int,
		reg6:Int
	):Void;
	function process():String;
}