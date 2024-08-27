import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

function main() {

	final n = parseInt( readline() );
	final m = parseInt( readline() );
	final invoices = [for( _ in 0...n ) parseInt( readline() )];
	final paymentEntries = [for( _ in 0...m ) parseInt( readline() )];

	final result = process( invoices, paymentEntries );
	print( result );
}

function process( invoices:Array<Int>, paymentEntries:Array<Int> ) {
	final payments = [for( i in 0...paymentEntries.length ) new Payment( String.fromCharCode( "A".code + i ), paymentEntries[i] )];
	
	final unassignedInvoices = invoices.copy();
	var maxDepth = 1;
	while( unassignedInvoices.length > 0 && maxDepth <= invoices.length ) {
		for( payment in payments ) {
			if( payment.isComplete ) continue;
			
			final matches = findMatches( payment.amount, 1, maxDepth, unassignedInvoices );
			if( matches.length != 0 ) {
				for( match in matches ) payment.invoices.push( match );
				payment.isComplete = true;
				for( match in matches ) unassignedInvoices.remove( match );
			}
		}
		maxDepth++;
	}
	
	return payments.map( p -> p.toString()).join( "\n" );
}

function findMatches( restValue:Int, depth:Int, maxDepth:Int, invoices:Array<Int> ) {
	// trace( 'findMatches  restValue: $restValue depth: $depth maxDepth: $maxDepth, invoices: [${invoices.join( ", " )}]' );
	if( depth > maxDepth ) return [];

	for( i in 0...invoices.length ) {
		final value = invoices[i];
		if( restValue - value == 0 ) return [value];

		if( restValue - value > 0 ) {
			final matches = findMatches( restValue - value, depth + 1, maxDepth, invoices.slice( i + 1 ) );
			if( matches.length == 0 ) return [];

			return [value].concat( matches );
		}
	}

	return [];
}
