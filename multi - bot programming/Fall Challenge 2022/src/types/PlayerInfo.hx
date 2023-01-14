package types;

import h2d.Tile;

@:structInit
class PlayerInfo {
	public final name:String;
	public final avatar:Tile;
	public final color:Int;
	public final index:Int;
	public final isMe:Bool;
	public final number:Int;
	public final type = "";
}