class Test {
	
	public static function main() {
		
		final extReg = ~/\.[0-9a-z]+$/i;

		extReg.match( "hello world.png" );
		trace( extReg.matched( 0 ));
	}
}