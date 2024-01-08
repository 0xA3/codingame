package ai.data;

@:structInit class PathDataset {
	final paths:Array<Array<Int>> = [];
	final width:Int;

	public function getPath( start:Int, end:Int ) return paths[getPathIndex( start, end, width )];

	public function getDistance( start:Int, end:Int ) return paths[getPathIndex( start, end, width )].length;
	
	public static inline function getPathIndex( start:Int, end:Int, width:Int ) return start * width + end;
}