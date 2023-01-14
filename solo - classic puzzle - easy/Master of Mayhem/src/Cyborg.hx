class Cyborg {
	
	public final name:String;
	public final attributes:Map<String, String> = [];
	public final words:Array<String> = [];

	public function new( name:String ) {
		this.name = name;
	}

	public function addAttribute( type:String, attribute:String ) {
		attributes.set( type, attribute );
	}

	public function addWords( words:Array<String> ) {
		for( word in words ) this.words.push( word );
	}

	public function toString() {
		return 'name: $name,attributes: {${attributesToString()}},words: [${words.join(",")}]';
	}

	function attributesToString() {
		return [for( type => name in attributes ) 'type: $type,name: $name'].join( "," );
	}

}