import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

final trigraphTable = [
	"=" => "#",
	"/" => "\\",
	"'" => "^",
	"(" => "[",
	")" => "]",
	"!" => "|",
	"-" => "~"
];

final htmlEntityTable = [
	"&amp;" => "&",
	"&lt;" => "<",
	"&gt;" => ">",
	"&bsol;" => "\\"
];

function main() {

	final text = readline();

	final result = process( text );
	print( result );
}

function process( text:String ) {
	
	final t1 = new TrigraphParser( trigraphTable ).parse( text );
	final t2 = new EscapeSequenceParser().parse( t1 );
	final t3 = new HtmlEntityParser( htmlEntityTable ).parse( t2 );

	return t3;
}

