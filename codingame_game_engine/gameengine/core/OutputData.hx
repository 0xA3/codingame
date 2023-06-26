package gameengine.core;

using StringTools;
using Lambda;

class OutputData extends haxe.ds.List<String> {
	
	final command:OutputCommand;

	public function new( command:OutputCommand ) {
		super();
		this.command = command;
	}

	override public function add( s:Null<String> ) {
		if( s != null )
			return super.add( s );
	}

	public function addAll( data:Null<Array<String>> ) {
		if( data != null )
			for( s in data ) super.add( s );
	}

	override function toString() {
		final sb = Lambda.array( this );
		final content = sb.join( "\n" ).trim();

		return content;
	}
}