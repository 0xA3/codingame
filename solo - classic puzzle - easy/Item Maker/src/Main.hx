import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;

using Lambda;
using Main;
using StringTools;

typedef ItemConfig = {
	final borderTop:String;
	final corners:Array<String>;
	final nameBorder:Array<String>;
	final attributeBorder:String;
	final borderBottom:String;
}

final configs:Map<String, ItemConfig> = [
	"Common"=> {
		borderTop: "#",
		corners: ["#"],
		nameBorder: ["#"],
		attributeBorder: "#",
		borderBottom: "#"
	},
	"Rare"=> {
		borderTop: "#",
		corners: ["/", "\\"],
		nameBorder: ["#"],
		attributeBorder: "#",
		borderBottom: "#"
	},
	"Epic"=> {
		borderTop: "-",
		corners: ["/", "\\"],
		nameBorder: ["|"],
		attributeBorder: "|",
		borderBottom: "_"
	},
	"Legendary"=> {
		borderTop: "-",
		corners: ["X"],
		nameBorder: ["[", "]"],
		attributeBorder: "|",
		borderBottom: "_"
	}
];

function main() {

	final data = readline();

	final result = process( data );
	print( result );
}

function process( data:String ):String {
	final attributes = data.split( "," );

	final name = '-${attributes[0]}-';
	final rarity = attributes[1];
	final more = attributes.slice( 2 ).map( s -> s.replace( ":", " " ) );
	final c = configs.exists( rarity ) ? configs[rarity] : throw 'Error: invalid rarity $rarity';


	final width = [name].concat( more ).maxLength();

	final header = switch ( rarity ) {
		case "Legendary":
			final headerCenter = width % 2 == 0 ? "\\__/" : "\\_/";
			'${c.corners[0]}${headerCenter.alignCenter( width + 2, c.borderTop )}${c.corners.nth( 1 )}';
		default: '${c.corners[0]}${c.borderTop.repeat( width + 2 )}${c.corners.nth( 1 )}';
	}
	
	final lines = [
		header,
		'${c.nameBorder[0]} ${name.alignCenter( width )} ${c.nameBorder.nth( 1 )}',
		'${c.attributeBorder} ${rarity.alignCenter( width )} ${c.attributeBorder}',
	].concat( more.map( s ->
		'${c.attributeBorder} ${s.alignLeft( width )} ${c.attributeBorder}'
	)).concat([
		'${c.corners.nth( 1 )}${c.borderBottom.repeat( width + 2 )}${c.corners[0]}'
	]);

	return lines.join( "\n" );
}

function min(v1:Int, v2:Int ) return v1 < v2 ? v1 : v2;

function maxLength( a:Array<String> ) {
	var max = 0;
	for ( e in a ) if ( e.length > max ) max = e.length;
	
	return max;
}

function repeat( s:String, n:Int ) {
	if( n == 0 ) return "";
	
	final buf = new StringBuf();
	for ( _ in 0...n ) buf.add( s );
	return buf.toString();
}

function alignCenter( s:String, width:Int, char = " " ) {
	final half = ( width - s.length ) / 2;
	final l = char.repeat( Math.round( half ));
	final r = char.repeat( int( half ));
	return l + s + r;
}

function alignLeft( s:String, width:Int ) {
	return s + " ".repeat( width - s.length );
}

function nth<T>( a:Array<T>, n:Int ) {
	return a[min( a.length - 1, n )];
}

