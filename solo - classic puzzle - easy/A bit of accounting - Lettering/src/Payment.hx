using Lambda;

class Payment {
	
	final id:String;
	public final amount:Int;
	public final invoices:Array<Int> = [];

	public var isComplete = false;

	public function new( id:String, amount:Int ) {
		this.id = id;
		this.amount = amount;
	}

	public function tryAssignInvoices( inputInvoices:Array<Int> ) {
		final sum = inputInvoices.fold(( v, sum ) -> sum + v, 0 );
		if( sum == amount ) {
			for( i in inputInvoices ) inputInvoices.push( i );
			isComplete = true;
		}

		return isComplete;
	}

	public function toString() return '$id $amount - ${invoices.join( " " )}';
}