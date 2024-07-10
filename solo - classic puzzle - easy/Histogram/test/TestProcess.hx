package test;

import CompileTime.readFile;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Test 1", {
				Main.process( "A" ).should.be( readFile( "test/Test_1_result.txt" ).replace( "\r", "" ));
			});
			it( "Test 2", {
				Main.process( "A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z." ).should.be( readFile( "test/Test_2_result.txt" ).replace( "\r", "" ));
			});
			it( "Test 3", {
				Main.process( "Coding game" ).should.be( readFile( "test/Test_3_result.txt" ).replace( "\r", "" ) );
			});
			it( "Test 4", {
				Main.process( "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum." ).should.be( readFile( "test/Test_4_result.txt" ).replace( "\r", "" ) );
			});
		});
	}
}
