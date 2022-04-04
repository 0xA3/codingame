import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.round;
import Std.parseInt;
import Std.string;

class Main {
	
	static function main() {
		
		for( i in 1...parseInt( readline()) + 1 ) {
			var output = i % 3 == 0 ? "Fizz" : "";
			if( i % 5 == 0 ) output += "Buzz";
			if( i % 4 == 0 ) output += "Bar";
			print( output == "" ? string( i ) : output );
		}
	}
}

/*

input 62

output
1
2
Fizz
Bar
Buzz
Fizz
7
Bar
Fizz
Buzz
11
FizzBar
13
14
FizzBuzz
Bar
17
Fizz
19
BuzzBar
Fizz
22
23
FizzBar
Buzz
26
Fizz
Bar
29
FizzBuzz
31
Bar
Fizz
34
Buzz
FizzBar
37
38
Fizz
BuzzBar
41
Fizz
43
Bar
FizzBuzz
46
47
FizzBar
49
Buzz
Fizz
Bar
53
Fizz
Buzz
Bar
Fizz
58
59
FizzBuzzBar
61
62

*/
