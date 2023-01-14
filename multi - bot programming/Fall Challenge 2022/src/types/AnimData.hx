package types;

@:structInit
class AnimData {
	
	public static final NO_ANIM_DATA:AnimData = { start: -1, end: -1 }
	
	public final start:Int;
	public final end:Int;
}