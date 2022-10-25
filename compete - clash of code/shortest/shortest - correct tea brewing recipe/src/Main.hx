import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;


/*
Output the correct tea brewing recipe as per Grandpa Crow's recommendations.
There are four possible Tea Types, with each type resulting in different Steeping Times. In addition, Grandpa Crow also likes to maintain a specific Water-To-Tea Ratio for his brews. Lastly, the Strength of tea requested will alter both the Steeping Times and Water-To-Tea Ratio accordingly.

First, determine the correct steeping times for the given tea type (tt); certain teas can be steeped three times, while some can only be steeped two times. The number of integers in the chart below will reflect how many times the tea can be steeped.
Next, use Grandpa Crow's tea-to-water ratio to output the correct amount of tea for the given amount of water (w).
Finally, alter both of the results depending on the strength of tea requested (st). There are three different strengths of tea: strong, normal, and weak.

Grandpa Crow's Tea Steeping Guide (in seconds):
Green Tea (g): 60, 30, 120
White Tea (w): 90, 45, 180
Black Tea (b): 90, 180
Herbal Tea (h): 300, 600

Grandpa Crow's Tea-To-Water Ratio:
1.25 grams of tea for every 1oz of water (water)

Strength of Tea:
Strong Tea (strong): Steep the tea for 4/3 the recommended time and use 6/5 the recommended amount of tea.
Medium Tea (medium): Do not change any of the parameters.
Weak Tea (weak): Steep the tea for 2/3 the recommended time and use 4/5 the recommended amount of tea.

Input
g
6
medium

Output
60, 30, 120
7.5
*/

class Main {
	
	static function main() {
		
		final tt = readline();
		final water = parseInt( readline());
		final st = readline();
		var t = water * 1.25;
	
		// strong 4/3 time, 6/5 tea
		// normal
		// weak 2/3 time, 4/5 tea
		var f = 1.0;
		
		if( st == "strong" ) {
			t *= 6 / 5;
			f = 4 / 3;
		} else if( st == "weak" ) {
			t *= 4 / 5;
			f = 2 / 3;
		}
		
		final steepingTimes = switch tt {
			case "g": [60, 30, 120];
			case "w": [90, 45, 180];
			case "b": [90, 180];
			case "h": [300, 600];
			default: throw "error";
		}
		
		final times = [for( time in steepingTimes ) Math.round( time * f )];
		
		print( times.join(", "));
		print( Math.round( t * 10 ) / 10 );
	}
}
