import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.ceil;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final inputs = readline().split(' ');
	final s = parseInt( inputs[0] );
	final m = parseInt( inputs[1] );
	final inputs = readline().split(' ');
	final maxClients = [for( i in 0...s ) parseInt( inputs[i] )];
	final clients = [for( i in 0...m ){
		final inputs = readline().split(' ');
		[for( j in 0...s ) parseInt( inputs[j] )];
	}];	
	
	final result = process( maxClients, clients );
	print( result );
}

function process( maxClients:Array<Int>, clients:Array<Array<Int>> ) {
	
	final clientsRunning = clients.map( connections -> connections.mapi(( i, connection ) -> ceil( connection / maxClients[i] )));
	final diffClientsRunning = clientsRunning.mapi(( i, connections ) -> i == 0 ? connections.copy() : connections.mapi(( o, connection ) -> connection - clientsRunning[i - 1][o] ));
	final output = diffClientsRunning.map( connections -> connections.join(" ")).join( "\n" );
	
	return output;
}
