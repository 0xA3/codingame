package test;

import Main;
import Std.parseInt;

using buddy.Should;
using StringTools;
using Lambda;

@:access(Main)
class Tests extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			
			it( "encode ab", {
				Main.process( -1, "ab" ).should.be( "ba" );
			});
			
			it( "decode ab", {
				Main.process( 1, "ba" ).should.be( "ab" );
			});
			
			it( "encode abc", {
				Main.process( -1, "abc" ).should.be( "bca" );
			});
			
			it( "encode abcd", {
				Main.process( -1, "abcd" ).should.be( "bcad" );
			});
			
			it( "Example encoding", {
				Main.process( -1, "abcdefghi" ).should.be( "ghibcadef" );
			});
			
			it( "Simple decoding", {
				Main.process( 1, "ghibcadef" ).should.be( "abcdefghi" );
			});
			
			it( "Simple encoding", {
				Main.process( -1, "hello world" ).should.be( "worlelhlo d" );
			});
			
			it( "Multiple decoding", {
				Main.process( 5, "hitoeplmu eneicldts aide  tsxt " ).should.be( "this is a mutliple encoded text" );
			});
			
			it( "Multiple encoding", {
				Main.process( -6, "hello worlds" ).should.be( "hrlellwo ods" );
			});
			
			it( "Long string", {
				Main.process( 3,
					" rius lorem. Duis risus nunc, condimentum at metun lacinia id. Pellentebortis. Suspendttis sed , maxis ornare nipulvinar. In v aliquam erat maximus bibenetus neque, tempus lovarius ipsnare vel. Donec , vitae sx enim. Sed vitaes sed nei ipFusces t. e at sum. Alt nibhgittidisse eu eteger id cursumque vel dui et libs.Maecenash. Suspendisse tristiqueeu condcondimentum atec orDui sitipsuorLem m dolteger quismus eget i ssim lacuss. Suspum feron arcu idvinar id eula elit in effiuspenlor. in blandem solm ne i psuc lorlicitudit ut acSIn luctus vcitur vae pulat arcu ferment maximus. Integerendisse hendrim. Inmentum nibh non dum.  amet, tur adlit. Fusceci pretium iacsi ut felibm neque, quis dignis orligsx nec sagi aliquam do maximuaodo nulla. isi quis, iquam esdu, npretium comMauris as. Ins elitque a mattittis. Morbi volutpat eroegestas irit vel ante ac dignisss nes scing elitconsecteoripi. Quisque msagiel puruuli mollis n enim est, ac bibendumissmentum. Ut dictum mi vel luctus rhoncus.tempor id."
					).should.be(
					"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque metus neque, sagittis sed condimentum at, maximus eget elit. Fusce condimentum nibh non erat maximus bibendum. Duis ornare nisi ut felis aliquam pulvinar. In vel purus nec orci pretium iaculis. Suspendisse hendrerit vel ante ac dignissim. Integer quis mollis nibh. Suspendisse tristique enim est, ac bibendum metus ornare vel. Donec egestas non arcu id maximus. Integer varius ipsum neque, quis dignissim lacus lacinia id. Pellentesque vel dui et libero tempus lobortis. Suspendisse pulvinar id ex nec sagittis. Morbi volutpat ligula at arcu fermentum fermentum. Ut maximus sed neque a mattis.Maecenas dictum mi vel luctus rhoncus. Suspendisse eu ex enim. Sed vitae aliquam dolor. In luctus velit in efficitur varius. Integer id cursus elit, vitae sagittis lorem. Duis risus nunc, condimentum at nisi quis, pretium commodo nulla. Mauris a ipsum nec lorem sollicitudin blandit ut ac est. Fusce at dui ipsum. Aliquam est nibh, tempor id."
					);
			});
			
		});
	}

}
