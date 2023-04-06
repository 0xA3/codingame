package test;

import Main;
import Std.parseInt;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			it( "Two", { Main.process( two ).should.be( twoResult ); });
			it( "Three", { Main.process( three ).should.be( threeResult ); });
			it( "Easy", { Main.process( easy ).should.be( easyResult ); });
			it( "15", { Main.process( _15 ).should.be( _15Result ); });
			it( "30", { Main.process( _30 ).should.be( _30Result ); });
			it( "60", { Main.process( _60 ).should.be( _60Result ); });
			it( "Long Queue", { Main.process( longQueue ).should.be( longQueueResult ); });

		});
			
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		return lines.slice( 1 );
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}
	
	final two = parseInput(
		"1
		BA"
	);

	final twoResult = parseResult(
		"1"
	);

	final three = parseInput(
		"1
		AB"
	);

	final threeResult = parseResult(
		"2"
	);

	final easy = parseInput(
		"5
		A
		CBACBACBACBACBACBA
		CCCCCBBBBBAAAAA
		BDNIDPD
		CODINGAME" );
	
	final easyResult = parseResult(
		"1
		3
		1
		4
		4" );
	
	final _15 = parseInput(
		"15
		C
		JS
		VB
		CPP
		PHP
		JAVA
		PERL
		RUBY
		MYSQL
		PYTHON
		GROOVY
		PASCAL
		POSTGRES
		HIBERNATE
		KUBERNETES" );
	
	final _15Result = parseResult(
		"1
		2
		1
		2
		2
		2
		2
		3
		2
		2
		4
		3
		3
		4
		4" );
		
	final _30 = parseInput(
		"30
		L
		CBB
		XXTX
		TMDNU
		OOOOO
		DTUUTT
		ENEENL
		KOKKKOKK
		EQJCCQQQ
		NNNNNNNNN
		LLLLLLLLLL
		JNFAEGMCEWC
		BBBPBBPPPPPB
		VVVMVTFMHHMM
		WRARVTRANRAW
		MQLNLQLLQMLNLON
		GELGGLSTWZEHCHGLG
		MIWEWESTEWEMEMIMEW
		JJBYHJRHJYZQHWWTBBHB
		WNYRNRYRRRNYNYFDRFRNF
		OZSYFMSSZLQOFPFCLFLEWCA
		HHJXJJXHXXXHHHJXJXHHXHJH
		NNFNNUXQWWXTGHWDSFHQTJDGN
		WOTDRNAYBWISURBXVMBFQJHEPO
		ZEMAROWQMECRUOWUPEWMOORMAREP
		CMMNOOVOSNVMNCCCVCICSMCMIVVI
		ZILJCMABQPNLMLIEEAAEBQMVCPIZJB
		JXFFXLXFFFFFFSCXXFJCCSXSFFFJFX
		SSSKMSPKPPPMKKMMPMSPPKKSSSMPKMPM
		FHSDNARRCTCRNARSTDRHRHAHDSNFDFFHNCAT" );
	
	final _30Result = parseResult(
		"1
		1
		2
		3
		1
		3
		2
		2
		3
		1
		1
		5
		2
		3
		4
		4
		7
		4
		6
		3
		5
		3
		5
		6
		7
		6
		7
		5
		4
		7" );

	final _60 = parseInput(
		"60
		JTJ
		CKK
		SAS
		BBDOC
		FXFFY
		LLLLLLL
		MMNNNNNM
		DZZLSIWSZ
		OSOVSBCOCV
		WAWGPJGLVSL
		CKZZTQTCCVQZ
		QQKPKQQKPPPP
		JWCUJSJEUCQH
		JPLRJPHBLHPJ
		XLMXLMAXLMLL
		TZZTTZZTZZTTZT
		QBBQQBBBBQBBQB
		SZXXXSXXZXZSZSX
		SNGSVWIYNISCNVDN
		GZTCDUCBUTJDJNNBE
		OWVOAAXVAAWWVXWXWO
		FFDDFFDDDFFFFFDDFF
		RTCVCBTRCRBCRBBVVRBT
		OBEJMAIDUPSSWXFXFNHML
		IDQVHVVIIDQHIHQQIDHIIQDDD
		CCNXACOTTOLLBLXOTCXOOLLXOOX
		POZPCCPOPBZBOTTTBCBCBTPZPOPTTP
		XBOUUXGSJTGRFARGXXJOJJAOSWSROW
		XMCZRZSBXZRZBSFICABFXKMBICRKFZCMF
		FAAFAOVFCOOEQGXOGOAXJXVJOQXCCFFEJ
		INCSIACCCYCACAHZZNFUQYZINASFUNCSZ
		KKKZTHLKLHDDHLLZOZZZKLKTKHTKHLZDKDZ
		FRROIWQAPPZNMOPZPANAMSQPMIAQPFQMQQPA
		RRFPMMNZYOZNEMWNFPZOPYSLNNFSRLNWRROE
		QZENNNEEQQESQZESSSQEQSNFNNFSSQNSEZNZ
		LUSMLZXMKBIXSHHKMLHMZUIVMVUVMXXMHXXS
		YUHEFNNAUZVFUBUVEYUVZNBBTCTVCEYZUCZT
		ZZEPXXFFCMEOCXEWPWZCMCWOPFFWWOMWOCEX
		PQKWHLPQHKHLWQWWKHZKQZQZPKHPZHHWZKLLLPLQQZ
		QEKHCQQKQKQQKHNQNNECNCKEEKKNNNQHEQNKCECCKN
		WXTPXZTFIPWQRCGXIJJZGIGHQZFOWYTAVRBMTGAGFKHC
		JUWZQHQHQQVLFQGUBUQZOGWQALZHBOFPQHPCWQHCUFQUPWMF
		IXKVIKEEEGGGIVIGGIGGGGKXEIGIXIIXEGIXXXGXXEGKEGGE
		MVWZBAENIHTIJJJAKCPFBKNLSLAXSOHTBDOFAIRDZGPBLLIDDX
		TQCBTSKOUGOTYJYJSPCSPMDBMIIMPCTDJMKBZYXYDGKCSPIBOSC
		FLQQDLFFBEDDQLLDDEDEDEDBQQQDFQDDEFEDEQDFEBBQEQFFBEEBEB
		JWKQSRBZQFJSSBFBRBSKZFQKRKRKKJWRFKBWZQQZBBWJKBWKRZQJZF
		LTDBTTKSCLLBNKBTNDKCKSCSCTSDSCSSNDBTKTBBSSNLLDDLNLTBNDSB
		ADYYDHNIFWEDLCIHCMIWINMMFLATITNHMNDELECXIHHXMEHHHYLNWXFL
		VKLHGBODYCOXLPCLLLOJYNGRYDNZCVIIBCPUCZYIGHJGPWLBRHLWYLIKR
		XVCGNTDVYNUYMDYYCXGGXGTXCUVBYMYMTUYBVMBCGVNUYTYXUXXGGCETDTTY
		EWOVDJXVSFVJGVGCXDSOTUGWUFOFODFLJGDUGWFCJLZSFFTOJFCUVDSQELDZGLWJ
		NMSSSXNGGMNSXZNNXIGMISIXZXGZSINZMMIIZMGGIMZGYMGGINNSNZYNMISYXSSI
		LOVFIHLCWVKVDSKSWLKOIFSHLOVCKSFHCWHVFIFDVFLVKOIDHOWVSKKSKFLSSFDVDO
		KPCKKGPCGQCQAQSSCJPFFICKSSPGAQGFFSPCGKWQPQFCPWCICQJPJFQICAQQJGSAQW
		ERCOUKJNJFJMIMUXAFLOSVRHALAQOGQGSAVJNCKFXJLFOJJUCWSPORAUEKPXAHAXJCWOM
		UUDOUSBEBOXUNNNSPEDPUUOBUUDUBXBNPXOSYOOSXPDNNXYNEYUNUSPDENUBPODYOESBNP
		LCWLIJKLXCKTPPJYKYQIIQWHJYPWWILPYKLTYHPHTLIAKPAXTHTVXCIQJJYQQQXIKCTQHH
		XMOXNJVOMSSONFKSOVXOXJOVSMVFXNJSSOVOMMOVFMSFKMNONOOVNJFKJXMXXFNSFXKXFSFS
		HIOAAWWDROQGRIDWARHQRROHRHHRODRODGWWAWWWHQGIOOWDWRHRWHHODROQQQRGGWQRGRHQ" );
	
	final _60Result = parseResult(
		"2
		2
		2
		3
		3
		1
		2
		5
		4
		5
		6
		3
		4
		3
		3
		2
		2
		3
		5
		4
		4
		2
		4
		8
		4
		6
		5
		7
		7
		8
		8
		6
		6
		7
		6
		8
		8
		7
		6
		5
		7
		8
		5
		10
		9
		5
		8
		7
		10
		10
		9
		11
		7
		9
		10
		11
		8
		11
		8
		9" );

	final longQueue = parseInput(
		"30
		RCCMBQZDGNKCPCRNYBRFQPNZKGOBSFYWDNZYMVSBCSBHIBIRCVORNBWQGVQIGCMCTQNRRIWIYFSCOBSKDKVSWYODPWHYZCDQPBHTDOCFHOPKNSZKPGCQWOYYSNBZYFOMKKWZFTFROFDI
		ONPYPGPNWOXWUIOMIMYWHSSPLVPLPVPAYPSAHNYMXWASXYUGXXNGXOPUIAMYPSSNSWPHPSPYOUWSUOUXPUVUNIGOOAUUGLVLGYXOIYIHLIUWNSNMNSXVWVNSLPSSASVAAOXOUOGMXHAVHWAAXYVNLW
		PVVBPCMFUXVKVILYALPYVCFVPIUKAKMDFPYVUVFUIMILYKDLVVAIDXBBVXDAVBVVIKKIBYFVCVVBLVMDPYAUDMVNPYNPCIFDLUVVKXXPYMMUXKKDBAFFFLAKCKVFCXAYNUUDDPKABDBMXBMAIKDLBN
		ZBYFAYFDAWQFSJFOZGGDWJEQQDGFQMZGFDNKKUMKKMJYDOGNOAUJZBQQGWOEGQJSEQMKWWNKYSEZYSZDANYQDMMNMAOJWSEAWESKAKZOASGOYSYENJGSKJDFBBQSUZGBYMJOYDKAKZNQSSQSOZJUMOGMQ
		AASLMHXNAWOXLWFYHEEPOXOXMFAYZQQNZBNBAWZRWFFPQRPRHLZWFZAQLEMLHBHRYYMREQSOBYNXYXRHBFWBSHPRAORFWVVLTFMRPSGGZPQPVETWFYTQEAYWHZEZVVHXSFGYSXMMQWEARQLXZEFBPWYAAWLNXNLG
		FDWYNMXHTHBSHCTXXSKXSGPBACHNFPKTHWEXIWTCSNYMWYHXSJTWPKTTTAHWPIXBGABCJJAXJCXXBNPFXHGHGAMLSAFSGCKKMNEGIGWIEKEBGHBYKJYTCTKSFPNHTLMKPEBSDDCEEBIISWDGGLJBNHTCBEILSDMW
		JEWTOTOGJFEZSWGUOVQGJEZWIXSEJSIFFOOYZSVFSQFOQLIZRFFOUBQILUVXEFTQQKTYLKLVLZZWFTBACECIILEIFJBYKZKUIOKJZQYQYSYVGOLFECJXRSQVSGGIKFBABKKKFQWISAXZAWGBVLSAJKGUOSAIVBCFXEQUZJOY
		QLMVXSGRRPRSVXNAQWBVHIMGENPZJWLRNRGLCGIAWVSARJCZUUNUXRNGUMYPSGRWRAUQYIEOOJABOHAOOMHIIDXDVNKUJEBXJUWPMSPLXGOGKNZCBMIKRWPQGAZOWBZJNJNSKOKPISNGYDDLOIQKXDZBCSNJCUPYMQZLNYHZ
		MJTYRUPEMWOHTYHHBUNRFFKNMWJLUFJNFAPBBSOFOMPCIZBBHLLRWYGNMWTDPBLYDMHBTBCMUPAJBUGHWOLKJKZBJWXRYOXXSSXUKHIHUOYSKBURMFBHURZGOOHTCMJPNDAWHEWBUYUCZYKNOZBRTTLACBTHJMGZOXIUTFPU
		TFRDQTJQTQAWRZHHKFWIEWRQNKNIPFFPHKTHLLJDQRZJKQTQQHRAFRAAARZZNWVJNJWQKNJFJFQDTFQJQJEAIKRTWFFLWLKNVQAQDZIJDFNIINLPVVZDTENALLWPVADFITNAFZKLFLPQEETRDWHEPELIDWJDHWLIZKWWKVZHVP
		IEEQGWVWZBZGWBZZTQCFXSPYRXHDBGDBTIYZTFEOHDFFWXOPGRIDZEIXTHEFPROSGGDSVZFFFGFZTIICBYEZVPBOTGGZDXGFWERQOYIVHRBQBFQIOGFDEYTIOGBVOYZXOVPPBWBZGEBDCISWXXPEVYDHGFIPRZFGCTDXWXTVTDR
		IJNTFQUAVOWFEJGIGOXRXKEEPVETJKUUWHBOMMASWGMIAXSNDIMVJFRGUDRSUFRRSNDBFWTQUSSNKHWWNGGDBWNGDVVAKBFEQOKHVRIBAVKWOBUMFOKONKHXQGBXTXSEIGGPNNBGFFKAJISTGOUUDNAXAIFHVDNPAIOFBPHNNOJRRVII
		XFZXIUABPFWEWVWKAVPRJARYHPPTPNNJDEZIIXBCYABKKHJAPRVPXNFXZQZBKQZVZITPZEIHJAEPBXISAPVYXJKRYWJJUUZHFXNYACQKEAEEJVUZQJSURIEEDNQVEQYVARJHYAFSIJNIBNBVUFUEDCHRVEZVHZTPWJXVYYPVZSSZTQAXFJETDTNJCNWNKYHTPJFVKA
		UQAPHCABCNHNEVEQYPSEKZGPEKWWDZCZZCEZJLHJENUSQWLFQGJKNUCEYVYEZUEYCAGUPNKIQZKBZDSENCZVIDVCLSSVPCOWLBHWQZBGNOZJHVSFJSJGCANJPGGOOHEUDENHYIGCWNAJDWALSFASFYSBHJZVCWUBGUEEIENOLNBGVKPPLIVPCAYPVJSZQLEGZYSDZV
		ICDIDLTRIZJASAHPUVJBDUNQTGXRJOUKESWENEIAHLANELPDFAJHTXGBOKJBDABMOFCQQPBKNSFWVBLRWGJOMDJBDIEQPHHEIIZZMAXZKCQCLCDJIHWWAMBAQROGSQQVZZZPBKXGSUIFIMZOWIFTXMEORKLNUWAACXRKDELCCOOGVUAIPDABVVZHXDRUAWXPGRTBPQEP
		DPKZYYSLCWTQKDLYTTSWPSLBTQCICIBOYSNVPSKRNFANITYKVNYSFZKORINPSGSTWROSVSGPOKTGGKOYQDOIPBLBLTVCQKCCSSAKKDZFSZZFGRDRBDWWVNPCQLQQQOFIGFNRYNOADKWZYPZQFNIRQYCRTKGITIWSLRFRVKTBCPBVGDDBZFINZZSKKKGCOKQSNIOTDFGV
		PFTELFHYYFTFVESFXHSJRTYNAESVJAPUWLBHLDFJWFQHRSPAXYNTXHPPBHWAGHMELUALLQMQJBHJXXBLPDMXBKVLMUGXGOOTGRULNHWBEFRUQWOKPHFVLSRHELOONNUKPVDXVGQESNUMXONYHPOYDVUNBLXDOXMXGBJRNWOTRDXOAGPBTJVPPUYHBNAWJHSDHYGBASJOPGOAMOV
		CQIJOFOZIFAMXYFIWBWYUCZUDZDBDDMULUBDRXVQUFWYJKAPIRMINKLFDGLGFXVRHJVHOVFOBRXXZLIGFOINQIOJJURQHULZGHPKRYDQHHOHIPVUXUKURKZDMKRKDAFPBIRYRRMPZNGQBFHAWBFKYMWODMCBMXLHRRKRDUKAFJYQRWHLAIXWXCDVDCUXKUHJICUOUHHRHJWCPHV
		KYUWCSEYOXYULIDKZAYHYSYUXOYKSISWCELJIEHHKZALINKJJLZFFMOUARSBYXIJVOJNBFBZNDXASSZROENUUDLUZCZSCDCCQEVMRUXQSCWWMLYFMDMZSYLUMKOKEDCSESNHXODSULDZXLVXEFEWAOWHZRNZQOFUKMQILXUNLNRSONADNZDQNMKHASZAJOZXUYWUCEWRFKHCFKX
		SXHDIVAJQVHWMRHQSONIHFMSAKPZBABOFOVXMHXSANIHZFHVNVHHADVXMQNZZXLODAHNZOFKXSIWOOWQAIYQMOBHJVVZFBQWDSPIVNVLZLDFVRFIXLJWMXIAWLIILOVJZVNOZNMJAVMIDJMWQPDDHOHPWADSKZVIPRKNRWXBLOXBPDMAIHDKZXFKQQAILLKLBZHZJBDOAAHSBAFKWO
		OBOYGWFOWBBTCNLKAFJPNJDDFFMTLQYQMJXOLKMDLNCMTASJYTLNMVKSSJNPORQGDJWXPRWPPCSYABTTJGXROWXQGBYQVYQKRQXGPBTROYQOOQKAQNFYKBJKCQCBCOBAYSBMQFSKRSCPTPQCTOMFKASCDTRNOLSSTTYFMXMFOYJOGFRNTQVNPRWBJTOMGTQQQMDQQYDFYJNCTPCGKT
		VBPXTJGKIKWJJBCPVJYRXYIGTIOXIYYKWTJBRIMHQISVHVHCPKJWLHXPPILYGYVTYYVKSTMPWTPYDVDSMMBOLKXIMDPLXUWKXHVTYRMDTOYKQPTRTWMOJVVPDQOPGWMCYDDTYUDTMWHKIWQRIVGJKVVXWDDXBCIWKUBTLDTDIUCVUWUICCSXJUWXHCVXRBTGWTYSXQUUBJGHSDMQBS
		CTPGBWNOHVGDTCWWPIWDYBXYGXITMMYLBHPDDLOXTBDBGEXALIVREWWIXDOYLNHXBHMWTHGXRHXBATZMPHGOTOPWNTFYOYWTTENARCTLEBNNCEOBIBOTVTLVWZVRFTBNYLTATZRPONZIOEZMEPINTRLFBNVDRGBFZCFNNETIMGOFXWBZMHRAERZGVNAODHZMIFXMMYPMBVVWGBCIDV
		OSXQNNEPVRBIVMGVSRYFLDCYBAGPYCHDZXOMUWROQWEOORXPGGNGBHCGAVCCEALWUCBOGNGLQZDUEHORWAZKIKBANRUAOZMXWZLHOZDEYAEBQBSIBLNLLFFHMPLYPYZQDBADWPHQCVKHHDFCZOORRVMSVGEYVQWRSHGKYZZPUDQXHQCLRIVOSDYVVZOPQLQHCCDGWGHUKBPBDKWVYYAXPUVB
		BUILVRRRIEFJYRZQTZFVGPNUUWYLYPNAGJABTPIUWZZLUJZTTPPGKVGBKIEHUYAPHWLXQGFTNEERRZQBPFNVPLQXIMQQXXHLIKMLJIQVXZUQPJQWZDHPUPLRLHURWIMAXHHPMFLJYYUJFAMXPLQRNWXJXTUAMBKGPIPJHPGBRBNQLUVFULYGLAPQTVNBZLEQBKZJDEUJTKZTHTJAFJQGWZKEHDRDHTMFZUWVLX
		PDOMUCEOQEVUMMXUJDSNFLMJSKKQIERJXKIGDIFORDJUJPTRUUTOWKJNVCFKFBXDEBJAOOTIANSDEGOFUMEPVETTCNWWQOTIPMPGIVCFDRARIJJWCCVBELMQOUULEVVCUNKRCNPDAQDVWLRFWKTEELNTFOXIJKEAGIMJDDTKCQIOCXILFNILSRIBBDVJGJPSGVPFUBGBRFBREVOIITVFXEFBQGQKKCQUKCPBIX
		TZPAIWRTTAUNXIKEBKJPHBUHYSBEEKCVMUBMJXSSDASOUHTNIWYROBSIDDKOPSHRHTTHITYWDCNLHTKSYFNARWRHFPZYYBNDCULFLEFBPZUFNPPJHCSXZPAFYKYUWDDBRTLKUPDDILZDXHSXIYIIWNFLYZRXXWYUTNEMXYKXZKZZAXYSADYNYFPBVXBPJBELOYXFNPMKLDFDITOJBBBZJRLIZKYRCIICDDARBVCESODFJECE
		UQXKIMAHCBARYEZCXGCZVMHDGMKDTJWOTFCTMNKFYZNKYACPSQNKVWHFGOZUNVQNNKPFQEGYYTNKSEKZZNKDRCGIIVNYMEIADITDUWPGRCAKTHWIUPIECSTKXBEODIPGJCTWAMBZTAZAUSEDOPCCRFYGDTSIUKHFQHGXOBVCGFIWXPQTKKMJCCGOAUSZHUBXTTSRJPRHEWSVOKNECRUDJYSIQDCWZEZKKORXXGNMZWXNXDGDETMUFUYWRU
		TXCQIMAOMNZNTEXAUHXXUDUETWRBTQZKVYOQPYCYEQSCMJJBGMOXTKXAKLONOFHKTWIBJDEBWCECQJWDPHJCBFTUHHHZQBSLDTAXWXZXBOMWHLGMQBMBDPOSESOOOKPXUBVOTHQIWGGDVSXFBOWKDVSLKAFHYBDDGFAROFMDFQPAJQKLILGUNAMLYMBPIUFSWXHSHUDOXOBVSFFRDKSPQYTORPQSCNEEDTUSCHHAONIUPYLVQWUGOIWTELNVAJEDNFHQ
		AFVQWZVHOENPVWCTIMHILQNPMEMUIHYLULOCOOEAPUMZHPTABRZLWVBDNMKYVCSIAZGPPIXHBWWJXWFBZXHDITTDUJAPHOICUTJWZWGBXXLCTJYJCNSNBVUDQEPHXCVMFIBXQYFTTGYFIABQZOZYECRRDEUQDRLDRCDIIHHSHNIEPHYXHIKRDRNTFUBDWKIBDCFCKTEVBMWYZTUTABSGYURRXDVRCELKIAESQRHBTHGTZVGKBUZWVHABBQNCQTAWLAZR" );
		
	final longQueueResult = parseResult(
		"15
		14
		14
		15
		15
		15
		15
		17
		14
		13
		17
		15
		19
		18
		19
		16
		20
		17
		18
		16
		18
		19
		16
		19
		17
		17
		17
		20
		22
		19"	);
}
