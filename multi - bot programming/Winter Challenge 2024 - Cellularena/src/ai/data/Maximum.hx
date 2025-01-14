package ai.data;

class Maximum {
	
	public static final NO_MAXIMUM = new Maximum( 0, -1 );

	public final max:Int;
	public final index:Int;
	
	public function new( max:Int, index:Int ) {
		this.max = max;
		this.index = index;
	}

	public function toString() return 'max: $max, index: $index';
}