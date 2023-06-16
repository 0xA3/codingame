package gameengine.core;

using StringTools;

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
		final sb:Array<String> = [];
		for( line in this ) {
			sb.push( '$line\n' );
		}
		final content = sb.toString().trim();
		final length = content.length > 0 ? content.split( "\n" ).length : 0;

		return 'length $length\n$content';
	}
}