package game;

class Field {
	
	public final width:Int;
	public final height:Int;
	public final cells:Array<Cell> = [];

	public function new( width:Int, height:Int ) {
		this.width = width;
		this.height = height;
	}
}