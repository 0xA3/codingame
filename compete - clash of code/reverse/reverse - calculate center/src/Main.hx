import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import xa3.MathUtils.max;
import xa3.MathUtils.min;

using xa3.StringUtils;

function main() {

	var inputs = readline().split(' ');
	final w = parseInt(inputs[0]);
	final h = parseInt(inputs[1]);
	final lines = [for( _ in 0...h ) readline()];
	
	var minX = w;
	var maxX = 0;	
	var minY = h;
	var maxY = 0;	

	var isFirst = true;
	for( y in 0...lines.length ) {
		final line = lines[y];
		if( line.contains( "#" )) {
			minX = min( minX, line.indexOf( "#" ));
			maxX = max( maxX, line.lastIndexOf( "#" ));
			
			if( isFirst ) {
				minY = y;
				isFirst = false;
			}
			maxY = y;
		}
	}
	
	final centerX = minX + ( maxX - minX ) / 2;
	final centerY = minY + ( maxY - minY ) / 2;

	print( '$centerX $centerY' );
}
