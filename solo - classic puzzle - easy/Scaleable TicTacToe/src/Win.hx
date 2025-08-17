@:structInit class Win {
	public static final NO_WIN:Win = { player: "", x: -1, y: -1, direction: TDirection.None };
	
	public final player:String;
	public final x:Int;
	public final y:Int;
	public final direction:TDirection;

	public function toString() return 'player: $player, x: $x, y: $y, direction: $direction';
}