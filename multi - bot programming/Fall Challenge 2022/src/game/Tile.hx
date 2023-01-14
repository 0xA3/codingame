package game;

@:structInit class Tile {
	public final x:Int;
	public final y:Int;
	public final scrapAmount:Int;
	public final owner:Int;
	public final units:Int;
	public final recycler:Bool;
	public final canBuild:Bool;
	public final canSpawn:Bool;
	public final inRangeOfRecycler:Bool;

	public function toString() {
		return 'x: $x, y: $y, scrapAmount: $scrapAmount, owner: $owner, units: $units, recycler: $recycler, canBuild: $canBuild, canSpawn: $canSpawn, inRangeOfRecycler: $inRangeOfRecycler';
	}
}