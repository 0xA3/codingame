import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

using Lambda;
using NumberFormat;
using StringUtils;

function main() {

	final result = process( readline() );
	print( result );
}

function process( s:String ) {
	final a = s.toUpperCase().split( "" );
	final charIndices = a.filter( char -> char.charCodeAt( 0 ) >= "A".code && char.charCodeAt( 0 ) <= "Z".code )
	.map( char -> char.charCodeAt( 0 ) - "A".code );
	
	final counts = [for( i in 0...26 ) 0];
	for( index in charIndices ) counts[index] += 1;

	final total = counts.fold(( v, sum ) -> sum + v, 0 );
	final percentages = counts.map( count -> count / total * 100 );
	final roundedPercentages = percentages.map( percentage -> Math.round( percentage ) );

	final lines = [getLineSeparator( 0, roundedPercentages[0] )];
	for( i in 0...percentages.length ) {
		final char = String.fromCharCode( i + "A".code );
		final percentage = percentages[i];
		final roundedPercentage = roundedPercentages[i];
		
		final lineCenter = '$char |'
		+ ( roundedPercentage > 0 ? " ".repeat( roundedPercentage ) + "|" : "" )
		+ NumberFormat.number( percentage, 2 ) + "%";
		
		lines.push( lineCenter );

		final values = [roundedPercentages[i], i < roundedPercentages.length - 1 ? roundedPercentages[i + 1] : 0];
		values.sort(( a, b ) -> a - b );
		final lineSeparator = getLineSeparator( values[0], values[1] );
		lines.push( lineSeparator );
	}

	return lines.join( "\n" );
}

function getLineSeparator( v1:Int, v2:Int ) {
	final r1 = v1 > 0 ? v1 : 0;
	final r2 = v2 > v1
		? v1 == 0
			? v2 - v1
			: v2 - v1 - 1
		: 0;

	return "  +"
	+ "-".repeat( r1 ) + ( r1 > 0 ? "+" : "" )
	+ "-".repeat( r2 ) + ( v2 > v1 ? "+" : "" );
}
