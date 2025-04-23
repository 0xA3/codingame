class Rectangle {
	
	public final column:Int;
	public final row:Int;
	public final width:Int;
	public final height:Int;

	public function new( column:Int, row:Int, width:Int, height:Int ) {
		this.column = column;
		this.row = row;
		this.width = width;
		this.height = height;
	}

	public function toOutput() return '$row $column $width $height';

	public static function sort( a:Rectangle, b:Rectangle ) {
		if( a.row < b.row ) return -1;
		if( a.row > b.row ) return 1;
		if( a.column < b.column ) return -1;
		if( a.column > b.column ) return 1;
		if( a.width < b.width ) return -1;
		if( a.width > b.width ) return 1;
		return 0;
	}
}