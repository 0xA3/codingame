import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

using StringUtils;

function main() {

	final urlbar = readline();
	
	if( urlbar.contains( "http://" ) || urlbar.contains( "ftp://" ) || urlbar.contains( "https://" )) print( urlbar );
	else if( urlbar.contains( "." )) print( 'http://$urlbar' );
	else print( 'ftp://$urlbar' );
}

