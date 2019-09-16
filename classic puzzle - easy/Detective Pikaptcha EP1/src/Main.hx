class Main {
	
	static function main() {
		
		final inputs = CodinGame.readline().split(' ');
		final width = Std.parseInt( inputs[0] );
		final height = Std.parseInt( inputs[1] );
		final lines = [for( i in 0...height) CodinGame.readline()];
		final side = CodinGame.readline();

		CodinGame.printErr( 'width $width  height $height' );
		for( line in lines ) CodinGame.printErr( line );
		CodinGame.printErr( 'side $side' );
	}

}
