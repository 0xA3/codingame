import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

function main() {

	final stack1Data = readline();
	final stack2Data = readline();

	final result = process( stack1Data, stack2Data );
	print( result );
}

function process( stack1Data:String, stack2Data:String ) {
	final stack1 = parseDataset( stack1Data );
	final stack2 = parseDataset( stack2Data );

	var tempStacks = [stack1, stack2];
	final outputs = [];
	var counter = 0;
	while( tempStacks[0].unitHealths.length > 0 && tempStacks[1].unitHealths.length > 0 ) {
		final totalDamage = tempStacks[0].unitHealths.length * tempStacks[0].damage;
		var tempTotalDamage = totalDamage;
		final nextUnitHealths = [];
		for( unitHealth in tempStacks[1].unitHealths ) {
			final nextUnitHealth = max( 0, unitHealth - tempTotalDamage );
			if( nextUnitHealth > 0 ) nextUnitHealths.push( nextUnitHealth );
			tempTotalDamage = max( 0, tempTotalDamage - unitHealth );
		}
		final perished = tempStacks[1].unitHealths.length - nextUnitHealths.length;
		
		final roundText = counter % 2 == 0 ? 'Round ${int( counter / 2 + 1 )}\n' : "";
		final endSeparator = counter % 2 == 0 ? "----------" : "##########";
		
		outputs.push( '$roundText${tempStacks[0].unitHealths.length} ${tempStacks[0].name}(s) attack(s) ${tempStacks[1].unitHealths.length} ${tempStacks[1].name}(s) dealing $totalDamage damage\n${perished} unit(s) perish\n$endSeparator' );

		tempStacks[1] = {
			name: tempStacks[1].name,
			unitHealths: nextUnitHealths,
			damage: tempStacks[1].damage
		};
		tempStacks.reverse();
		counter++;
	}
	final winner = tempStacks.filter( stackDataset -> stackDataset.unitHealths.length > 0 )[0];

	outputs.push( '${winner.name} won! ${winner.unitHealths.length} unit(s) left' );

	return outputs.join( "\n" );
}

function parseDataset( stackData:String ) {
	final parts = stackData.split( ";" );
	final amount = parseInt( parts[1] );
	final health = parseInt( parts[2] );
	final stackDataset:StackDataset = {
		name: parts[0],
		unitHealths: [for( i in 0...amount ) health],
		damage: parseInt( parts[3] )
	}
	
	return stackDataset;
}

function max( v1:Int, v2:Int ) return v1 > v2 ? v1 : v2;
function min( v1:Int, v2:Int ) return v1 < v2 ? v1 : v2;

typedef StackDataset = {
	final name:String;
	final unitHealths:Array<Int>;
	final damage:Int;
}
