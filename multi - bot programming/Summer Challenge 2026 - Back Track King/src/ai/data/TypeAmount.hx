package ai.data;

import ai.data.TResource;

class TypeAmount {
	
	public var type:TResource;
	public var amount:Int;

	public function new( type:TResource, amount:Int ) {
		this.type = type;
		this.amount = amount;
	}

	public static function sort( a:TypeAmount, b:TypeAmount ) return a.amount - b.amount;
	public static function sortReverse( a:TypeAmount, b:TypeAmount ) return b.amount - a.amount;
}