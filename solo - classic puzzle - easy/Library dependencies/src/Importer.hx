class Importer {
	
	final imports:Array<String>;
	final dependencies:Map<String, Array<String>>;

	public var errorPosition = -1;
	public var errorLibrary = "";
	public var missingDependency = "";

	public function new( imports:Array<String>, dependencies:Map<String, Array<String>> ) {
		this.imports = imports;
		this.dependencies = dependencies;
		// trace( 'new Importer $imports' );
	}

	public function process() {
		final imported:Map<String, Bool> = [];
		
		for( i in 0...imports.length ) {
			final library1 = imports[i];
			// trace( '$i import $library1' );
			imported.set( library1, true );
			if( dependencies.exists( library1 )) {
				// trace( 'dependencies ${dependencies[library1]}' );
				for( library2 in dependencies[library1] ) {
					if( !imported.exists( library2 )) {
						// trace( 'missing dependency $library2' );
						errorPosition = i;
						errorLibrary = library1;
						missingDependency = library2;
						
						return;
					}
				}
			}
		}
	}
}