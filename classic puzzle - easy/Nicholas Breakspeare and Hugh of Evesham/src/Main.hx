import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import Std.int;
import Math.min;

using Lambda;

class Main {
	
	static final numbers = ["", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen" ];
	
	static final tens = ["", "", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"];

	static final powers = ["", "thousand", "million", "billion", "trillion", "quadrillion", "quintillion"];

	static function main() {
		
		final n = parseInt( readline());
		final numbers = [for( i in 0...n ) readline()];
		
		final result = process( numbers );
		print( result );
	}

	static function process( lines:Array<String> ) {
		final results = lines.map( s -> getNumber( s ));
		return results.join( "\n" );
	}

	static function getNumber( s:String ) {
		
		if( s == "0" ) return "zero";

		final isNegative = s.charAt( 0 ) == "-";
		final sign = isNegative ? "negative " : "";
		final number = isNegative ? s.substr( 1 ) : s.substr( 0 );
		final numberParts = divide( number );

		final cardinalForms = numberParts.mapi((i, part ) -> {
			final hundredsOfPart = getHundreds( part );
			final tensOfPart = getTens( part );
			final powersOfPart = part == "000" ? "" : powers[numberParts.length - i - 1];
			[hundredsOfPart, tensOfPart, powersOfPart];
		});

		
		return sign + cardinalForms.flatten().filter( s -> s != "" ).join(" ");

	}

	static function divide( number:String ) {
		
		var i = 0;
		var numberPart = number;
		var numberParts = [];
		while( numberPart.length > 0 ) {
			i += 3;
			final max = int( min( numberPart.length, 3 ));
			final part = number.substr( numberPart.length - max, max );
			numberParts.push( part );
			numberPart = numberPart.substr( 0, numberPart.length - max );
			// trace( 'i $i max $max part $part' );
		}

		numberParts.reverse();
		return numberParts;
	}

	static function getHundreds( s:String ) {
		return s.length == 3 && s.charAt( 0 ) != "0" ? numbers[parseInt( s.charAt( 0 ))] + " hundred" : "";
	}

	static function getTens( s:String ) {
		final withoutHundreds = s.length == 3 ? s.substr( 1 ) : s;
		final number = parseInt( withoutHundreds );
		if( number == 0 ) return "";
		if( number < numbers.length ) return numbers[number];
		
		final first = parseInt( withoutHundreds.charAt( 0 ));
		final second = parseInt( withoutHundreds.charAt( 1 ));
		
		return tens[first] + ( second == 0 ? "" : "-" + numbers[second] );
	}
}
