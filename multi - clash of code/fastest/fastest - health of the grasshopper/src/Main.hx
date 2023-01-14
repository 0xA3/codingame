import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import Std.parseFloat;
import xa3.MathUtils;
import xa3.MathUtils.eval;

using Lambda;
using StringTools;
using xa3.ArrayUtils;
using xa3.NumberConvert;
using xa3.NumberFormat;
using xa3.RegexUtils;
using xa3.StringUtils;

/*
During the summer days. The ants work very hard to collect food for winter, and the grasshopper just sleeps all day. When winter comes the ants stay in their houses, they share and eat food, but the grasshopper has nothing to eat.

The grasshopper's health is g. Day by day his health decreases by e, and eating 1 piece of some food increases his health by 1.

Now your task is to find the health of the grasshopper after d days. If his health is below or equal to 0, output Dead

Note: Each day the ants give the same amount of food to the grasshopper

Input
1
100 10 20

Output
110
*/

function main() {

	final d = parseInt( readline());
	final inputs = readline().split(" ").map( s -> parseInt( s ));

	var health = inputs[0] - ( inputs[1] - inputs[2] ) * d;

	print( health > 0 ? '$health' : "Dead" );
}
