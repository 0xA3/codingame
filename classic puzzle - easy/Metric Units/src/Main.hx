import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseFloat;

using Lambda;
using StringUtils;
using MathUtils;
#if lua
using StringTools;
#end

final units = [
	"km" => 1000000000,
	"m" => 1000000,
	"dm" => 100000,
	"cm" => 10000,
	"mm" => 1000,
	"um" => 1
];

function main() {
	final expression = readline();
	final result = process( expression );
	print( result );
}

function process( expression:String ) {

	#if lua // no regular expressions for lua in codinGame
	final chunks = expression.split( " + " );
	final lengths = chunks.map( chunk -> parseChunk( chunk ) );
	#else
	final lengths = parseExpression( expression );
	#end
	final smallerId = units[lengths[0].unit] < units[lengths[1].unit] ? 0 : 1;

	final smallerLength = lengths[smallerId];
	final largerLength = lengths[1 - smallerId];

	final multiplier = units[largerLength.unit] / units[smallerLength.unit];
	final sum = ( largerLength.amount * multiplier + smallerLength.amount ).round( 8 );

	// trace( 'smallerUnit ${smallerLength.unit}  largerUnit ${largerLength.unit}  multiplier $multiplier  sum $sum' );
	#if lua
	final sumString = Std.string( sum );
	final sumFormated = sumString.substr( sumString.length - 2 ) == ".0" ? sumString.substr( 0, sumString.length - 2 ) : sumString;
	return '$sumFormated${smallerLength.unit}';
	#else
	return '$sum${smallerLength.unit}';
	#end
}

#if lua // no regular expressions for lua in codinGame
function parseChunk( chunk:String ):Length {
	if( chunk.contains( "km" ) ) return {amount: getValue2( chunk ), unit: "km"}
	if( chunk.contains( "dm" ) ) return {amount: getValue2( chunk ), unit: "dm"}
	if( chunk.contains( "cm" ) ) return {amount: getValue2( chunk ), unit: "cm"}
	if( chunk.contains( "mm" ) ) return {amount: getValue2( chunk ), unit: "mm"}
	if( chunk.contains( "um" ) ) return {amount: getValue2( chunk ), unit: "um"}
	if( chunk.contains( "m" ) ) return {amount: getValue1( chunk ), unit: "m"}

	throw 'Error: parsing chunk $chunk';
}
#else
function parseExpression( input:String ) {
	final ereg = ~/([\d.]+)([cdkmu]?m)/;

	final lengths:Array<Length> = [];
	while( ereg.match( input ) ) {
		lengths.push({
			amount: parseFloat( ereg.matched( 1 ) ),
			unit: ereg.matched( 2 ),
		} );
		input = ereg.matchedRight();
	}
	return lengths;
}
#end

function getValue1( s:String ) return parseFloat( s.substr( 0, s.length - 1 ) );
function getValue2( s:String ) return parseFloat( s.substr( 0, s.length - 2 ) );

typedef Length = {
	final amount:Float;
	final unit:String;
}
