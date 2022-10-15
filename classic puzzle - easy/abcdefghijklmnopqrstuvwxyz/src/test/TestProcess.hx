package test;

import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Test 1", {
				Main.process( test1 ).should.be( test1Result );
			});
			it( "Test 2", {
				Main.process( test2 ).should.be( test2Result );
			});
			it( "Test 3", {
				Main.process( test3 ).should.be( test3Result );
			});
			it( "Test 4", {
				Main.process( test4 ).should.be( test4Result );
			});
			it( "Test 5", {
				Main.process( test5 ).should.be( test5Result );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		return lines.slice( 1 ).map( s -> s.split( "" ));
	}
	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final test1 = parseInput(
	"10
	vkbjbzmbgb
	abcccpzouv
	fedopwlmcl
	glmnqrszyw
	hkrhiutymj
	ijqcmvwxoc
	pcvlpqzphl
	hsgvoklcxy
	urdjusmbmz
	rchbcausnp" );

	final test1Result = parseResult(
	"----------
	abc-------
	fedop-----
	glmnqrsz--
	hk---uty--
	ij---vwx--
	----------
	----------
	----------
	----------" );

	final test2 = parseInput(
	"15
	xoikvoybwhvhkqs
	abcdpjzteanhnot
	wonezupfvoeetfc
	qpmfxfndfiqafpb
	rklgqyyltzvnugs
	sjihujprijqzvap
	tsoxsaoraruyqwk
	uwwonqolepmuqyy
	vwxwksnuizgbiht
	feyihffuvkbrfjw
	eezqukiqyzqjies
	uarhhcdjvpfwvck
	drtgqmroaaumyaq
	cbntlwlibaavsdc
	jpvogyiibfawjbn" );

	final test2Result = parseResult(
	"---------------
	abcd-----------
	-one-----------
	qpmf-----------
	rklg-----------
	sjih-----------
	t--------------
	u--------------
	vwx------------
	--y------------
	--z------------
	---------------
	---------------
	---------------
	---------------" );

	final test3 = parseInput(
	"15
	qrnwxqufaqpmehg
	gqpsdpeqovfjtbv
	azdizzjbedhsyzt
	mzbegprlfcbaxwv
	hoibquzhgbdrggu
	gynohfmijkdgpqt
	lwemjvulqlmnors
	eckkhvwucrblxwc
	hxunydbmsxdmpkh
	drdzvbronvfjlwz
	npnjnjqkfvupezb
	hvdaqvyrwhdtxbb
	nfpgaffyuefppae
	forhbqkezipkinq
	usxszgnwvwndzrl" );

	final test3Result = parseResult(
	"---------------
	---------------
	--------ed--yz-
	--------fcbaxwv
	-------hg-----u
	-------ijk--pqt
	---------lmnors
	---------------
	---------------
	---------------
	---------------
	---------------
	---------------
	---------------
	---------------" );

	final test4 = parseInput(
	"20
	qaytksajbfggzscxlwss
	avotuqnvgvmnghnwchnu
	aceglpwkcwyxqnjxetag
	ilddvpjguotxrnvkznkc
	wnbquhpzgpjjvaxblckl
	blyccpjqkwosrjvcouyt
	dlattqnvvgawdkcyhbhx
	alvpqxspvbeizbxaubby
	xtvxhvgfjiiffcynzfdo
	xlroyrcwaydggabiodrq
	hydaxaveuuextqzcgewo
	dcvbvqmsvebmbghclgbs
	izpesrsutapzuvrapkzg
	ratpfqwmokaujqhihdei
	jaabcvxvwpwozvoiwvya
	pdnedstuxrbxjuqnqfat
	xhgfqrezyiabcrupxwpi
	dijopgmxgezbgnyhwzih
	ceknitwldqjbxdgnbgbu
	yllmerzjxqjzrqlwfjwi" );

	final test4Result = parseResult(
	"--------------------
	--------------------
	--------------------
	--------------------
	--------------------
	--------------------
	--------------------
	--------------------
	--------------------
	--------------------
	--------------------
	--------------------
	--------------------
	--------------------
	--abc--vw-----------
	---edstux-----------
	-hgfqr-zy-----------
	-ijop---------------
	--kn----------------
	--lm----------------" );

	final test5 = parseInput(
	"30
	enzronekzsmncqrupfjkzokzutbibz
	ddxkntwwwuriunbkfxwpsarujlkrhn
	unfsatsydaagxqhbfrzeigawsewixb
	kwmmudxpneowrxhzzicwrybmrawqhu
	gfyxpdnironminfhsevmvlxbriunky
	xkoaqlnzawcyyjpngycidgzqnjbgeh
	zjtxaqigtbpqhpkmdbghfwfawxvzeo
	tqoehzynwngzhfwouurpnfjzesgksn
	urmgqhukjplzvaumvrjuszkjruvoee
	cbwubfptjhefhqcwrtooikwtawavnr
	okphckdqkmvpcktenlevtwdwakzpvk
	quqoqveedzotxslsmxwnyojfxzrbgp
	svdymebhpuzgcfhulhnnptgsrijwkv
	zggdylnbarhonzkewlnmbnfimjvsou
	mguhqcbcdegftxmfvixspurjjbramw
	ldyrykyryfrlmzlwauatxcmtzalrtx
	udgepapmugnrzlcyothsdlbohzrnyj
	cscmdpkjihcvmocjqxxmeovkbkngbk
	fkqzdhloppadpaazoanoizuqlhyeqa
	xextdlmnqvbefgiujrihhmcviymbrn
	tpyjnutsrwvipotvcoexyrowabbcns
	imkyxvficculyqlipcvbiuygnaxwup
	yzodmwdbwtijkpolrdqwkwvbrivhrd
	hbquqxyzuqqynrgppitablcsxxvjya
	amzrkgnvijaohgapixspodcsbhphqg
	zijfoehygareiidyltgscqojnsolvu
	cnosdtngtetlvcriosgfzzbtsgqfjq
	flarkqdnisdjzwjjsshmxydorltxau
	bdmeahzediqhokktuasaxywkkjwali
	cclixxfhozajhkawqdzoilwwsvyzyl" );

	final test5Result = parseResult(
	"------------------------------
	------------------------------
	------------------------------
	------------------------------
	------------------------------
	------------------------------
	------------------------------
	------------------------------
	------------------------------
	------------------------------
	------------------------------
	------------------------------
	------------------------------
	-------ba---------------------
	-------cde--------------------
	---------f--------------------
	---------g--------------------
	------kjih--------------------
	------lop---------------------
	------mnq---------------------
	-----utsr---------------------
	-----v------------------------
	-----w------------------------
	-----xyz----------------------
	------------------------------
	------------------------------
	------------------------------
	------------------------------
	------------------------------
	------------------------------" );
}
