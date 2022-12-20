package types;

@:structInit
class CellDto {
	public final durability:Int;
	public final x:Int;
	public final y:Int;
	public final ownerIdx:Int;
  
	/* Computed client side */
	public final rand:Int;
	public final fight = false;
	public final history:Array<String>;
	public final lastAngle:Map<Int, Int>;
  }