function cbrt( x:Float ) {
	if( x == 0 ) return 0.0;
	if( x < 0 ) return -cbrt( -x );

	var r = x;
	var ex = 0;

	while( r < 0.125 ) { r *= 8; ex--; }
	while( r > 1 ) { r *= 0.125; ex++; };

	r = ( -0.46946116 * r + 1.072302 ) * r + 0.3812513;

	while( ex < 0 ) { r *= 0.5; ex++; }
	while( ex > 0 ) { r *= 2; ex--; }

	r = (2.0 / 3.0) * r + (1.0 / 3.0) * x / (r * r);
	r = (2.0 / 3.0) * r + (1.0 / 3.0) * x / (r * r);
	r = (2.0 / 3.0) * r + (1.0 / 3.0) * x / (r * r);
	r = (2.0 / 3.0) * r + (1.0 / 3.0) * x / (r * r);

	return r;
}