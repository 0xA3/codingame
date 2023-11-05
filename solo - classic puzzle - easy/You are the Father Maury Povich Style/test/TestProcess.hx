package test;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Example", {
				final ip = example;
				Main.process( ip.mother, ip.child, ip.possibleFathers ).should.be( "Winner, you are the father!" );
			});
			it( "Test 1", {
				final ip = test1;
				Main.process( ip.mother, ip.child, ip.possibleFathers ).should.be( "Scott, you are the father!" );
			});
			it( "Test 2", {
				final ip = test2;
				Main.process( ip.mother, ip.child, ip.possibleFathers ).should.be( "Chris, you are the father!" );
			});
			it( "Test 3", {
				final ip = test3;
				Main.process( ip.mother, ip.child, ip.possibleFathers ).should.be( "Jose, you are the father!" );
			});
			it( "Test 4", {
				final ip = test4;
				Main.process( ip.mother, ip.child, ip.possibleFathers ).should.be( "Tate, you are the father!" );
			});
			it( "Test 5", {
				final ip = test5;
				Main.process( ip.mother, ip.child, ip.possibleFathers ).should.be( "Zachariah, you are the father!" );
			});
			it( "Test 6 - That was close", {
				final ip = test6;
				Main.process( ip.mother, ip.child, ip.possibleFathers ).should.be( "Zion, you are the father!" );
			});
			it( "Test 7 -- so close for so many", {
				final ip = test7;
				Main.process( ip.mother, ip.child, ip.possibleFathers ).should.be( "Merrick, you are the father!" );
			});
			it( "Test 8 - - everything from Mother in some pairs??", {
				final ip = test8;
				Main.process( ip.mother, ip.child, ip.possibleFathers ).should.be( "Kevin, you are the father!" );
			});
			it( "Test 9 - they're all 95%+ matches", {
				final ip = test9;
				Main.process( ip.mother, ip.child, ip.possibleFathers ).should.be( "Harvey, you are the father!" );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );

		final mother = lines[0];
		final child = lines[1];
		final possibleFathers = lines.slice( 3 );
	
		return { mother: mother, child: child, possibleFathers: possibleFathers };
	}

	final example = parseInput(
		"Mother Betty:        ab cd
		Child Howie:          aw cy
		4
		Winner:               wx yz
		No q:                 aq cy
		Nothing of first:     ab cy
		Not first:            az cy" );

	final test1 = parseInput(
		"Mother Julie:        Uj $7
		Child Brandon:       Wj =$
		5
		Garrett:             #; wc
		Macallister:         P2 zv
		Jeffrey:             KI J&
		Scott:               WW :=
		Angus:               Xm N1" );

	final test2 = parseInput(
		"Mother Leighssa:     QU Na iw GV ?I 0s 6b
		Child Chance:        1Q cN i7 lG K? s2 6-
		3
		Lawson:              oX On b! ,- p- <q e4
		Chris:               10 cP )7 l8 bK )2 -;
		Amare:               \"j 'R =X 5n Lf Ao PY" );

	final test3 = parseInput(
		"Mother Shirley:      PW %k N4 Om )p Yi oM WI
		Child Alexander:     WQ k\" kN 8O zp YH Ho Io
		5
		Victor:              4p Ci 2n zs nX k2 oa +O
		Benedict:            Qy E2 VO =Q gO f( *R Ez
		Walker:              Sh t> &. yJ cU #3 y/ f,
		Jose:                Qu h\" kw w8 zH H: HC Jo
		Tate:                e? :. k% #E ,, Bc W= KF" );

	final test4 = parseInput(
		"Mother Taylor:       :3 Ko N< u1 87 P% NJ U1 1. $n 2+ v, Cw vE k9 %8 uf 6e /3 RG jB \"' i9 if
		Child Camila:        D3 KB NS ,u Z7 %n dJ UO 9. I$ +A vm w: jE Q9 %s if M6 /y RE Hj \"; 9$ :f
		4
		Rhodes:              hD Ba S% ,9 dZ nD dC cO 9! I. 'A Wm &: jY TQ 2d )< rR ec A( <e e1 &g 7#
		Jordan:              I, 7l )j x) jP G4 Fo =M +O Nm s6 VL D8 xi dS m= aw ?. ap ,t 7r m1 9P F:
		Booker:              AH ed Es #X <O /i 7p -g K6 ?, .T +/ jy GS 8C lx ;Y Eb :Z -' g, W= m4 R.
		Tate:                aD BM yS ,B .Z ns d4 OO 9E I- AH mT y: j8 ;Q (s mi JM y% \"E >H ;l U$ :V" );

	final test5 = parseInput(
		"Mother Louise:       &R %N ;; GE p2 *j 7U 5b 3y BY 6S gC NN 9R mJ TC d/ G< xv 3J w+ 3i Zw 4< C$ -F X% wB I2 Mi <B rU !# -; p6
		Child Samantha:      MR %I ;h E6 Gp *f a7 75 :y eB 6= mC zN 9# md Cm Rd <3 xo ;3 hw X3 wK <J L$ -\" %L Bd I# i$ vB Br #u C- +p
		6
		Lawrence:            ZM BI h; c6 VG fi ax 7b :n (e (= mQ Nz !# id m! &R 3U ov K; hk UX =K Jr Lx \"% L7 Ed 7# G$ >! pU N1 Zv \"'
		Zachariah:           hM ID hp 6, G\" fj Ga 7k C: eb Y= 0m z* &# d7 Im Rk o3 (o h; hP XK lK J1 'L t\" L, dv #Y :$ v> B= Bu Ci +t
		Calvin:              ;l v. ;m %j P! 6! z< vW A. kq N6 D? Vu (> au mB ,N 1% mK uP R3 y7 <a NI IJ CR VF /O Yw IQ =x O- Kn +I p,
		Angus:               oM I2 8h v6 G* fS a? P7 N: Le E= =m !9 7< ', x6 C( Bj Up W% &- Q0 uP +T ,Z 3h x6 XY Bf :. l3 b: xn Mi Y8
		Elliot:              3M I# h3 6t YG fV ae h7 :& 'e == mk Nz #\" 5d #m /R 3t (o 5; Ch XY aK >H iM fo >X '# 62 k- hO Py i. .% +U
		Frank:               '9 .5 1% -g ;' mC HY .: cX Q, c* FD 2w nB YJ ;- mZ <; 0, C; B9 #C xn :5 Bx &D c/ %- IU !T Kc ,a u- -r 9#" );

	final test6 = parseInput(
		"Mother Fiona:        ;L KR O* \"X </ 5, JC hG *2 nh 2? y/ p& J. QX rQ ?k ,E vP /M lj :2 ?g ws #y nd Xe 97 YY SU E: pb t% i& I0 0m
		Child Delia:         #L RR Oy -\" /% 51 C? bh 2p -h ?R y; Ip *J XQ rN kA E$ P) MG jD 32 <g ,s #C nK XO 7/ MY UY EO >b %S &) e0 Pm
		8
		Theodore:            t# kR Ey )- %! F1 s? b0 kp -l $R E; ?I ,* Xw Nv jA $Z t) Gh D! o3 <M d, CC Kf Oj /6 fM Yj On a> FS E) O5 8u
		Michael:             T# !R Wy -z %F c1 v? b4 p$ -O Rs ,; I; *; Xl 2N A= $6 )N Gz !D 3q 4< ,T C? kK y# Qy J( )- =H +9 F8 ij Bv )i
		Jordan:              a# R< yU \"- <% ;1 D? bR &p I- jR 6; Ir 5* kX TN AD o$ )2 G. sD s3 >< ,\" C* KZ OV /q GM Yi .O L> (S b) eO 9U
		David:               #o R> y' !- #% >1 o? b; pP (- 1R ;8 OI *P zQ Np WA ,$ <) hG LD 3/ <8 h, CN BK %O /P LM SY OI !> CS 3A aH O(
		Jonathan:            #y 'R vy =- %b 91 ?? 8b f9 NI uj C; Zd *, !m Hk 2S IP I7 +0 8r vS Vy 6o Ne /( v? !: s& K) rH A# Ru T- 93 9h
		Ronald:              z# RP y< (- d% \"& Tp JF ;5 b< $g md 6y Va IP ex z& qz Pk :4 cY x: :M 4s (# n, r( Mj i( 1s c1 \"= sV BF #N :2
		Zion:                #' bR yh -0 %o !1 7? &b p$ *- R0 ;Z XI *\" &X NA UA $l )T =G D1 F3 <J ,M C* kK sO !/ 1M KY O# >4 S, Z) 9e PY
		James:               #8 Rk yC 4< +l zR +f )j GD x* Zw R- FN Uz Y% k) J' u4 nw 3$ 5/ 4' A. rl iz d* vr uO #s t, <x y3 1! /r pN lR" );

	final test7 = parseInput(
		"Mother Lori:         #( ;A F. PP >v lz 4m kc jq PY yG T. 0< D! jJ rn !R :A 3r LK c? D5 Wx xE Wy 2- :g .i RD 4N iN t5 vu
			Child Cassandra:     <( A( .z Pp Cv 8z l4 #c q> YN ye WT <7 !? Hj $r bR AR 93 wL G? 5I Kx x* W9 2? %g iv R0 94 NM %5 v*
			4
			Whittaker:           <X (5 zC Up C9 8i 8l #e >D Nh We ab F7 ?p &H k$ bW R* c9 wM nG I# Ke r* 9+ <? %o kv ;0 r9 M$ %j **
			Colin:               .< ($ ?z pE ab 84 la #6 R> Nc eE jW 7E ?u sH ($ wb Re 99 ,w MG I5 K> 1* 9k 7? v% vV 0O 9U GM 5% 7*
			Merrick:             =< y( kz p, CS 8l gl #H -> MN er W\" 7p S? H6 $x jb Rg 9j wU fG IC xK b* 9A ?r %? vY 0! 98 M/ i% 5*
			Macallister:         <l (O zg 8p Cb 78 lq i# >8 <N pe W> c7 ?h sH $C b: sR 9C Gw sG IW .K *T 9S B? %W ve 00 9Z ab '% d*" );

	final test8 = parseInput(
		"Mother Patricia:     eK 5o v5 s, l3 ND A7 << CE hD N? o< ## ua =G m( )+ (N To 7? '' NS ,I GJ X% K) qH 26 ++ -k ?Y /t WQ Z2 (a 6m zm TM Ma E< sG Xr zW Gc GG nO wC +U II 4f eU aa jR xP 1o gb i* ZZ p4 gZ T/ zk &# 6u DD Gh Dy W% GG =) == (3 yb fz 88 W% Q; de pf K8 u4 >S %i 3+ N: /% CL p$ DW CC 3A MM VK oi ny
			Child Trenton:       Ke 5D 8v s, l3 qD 7P h< EC \"D ?N o< ## au G= (m +) v( oa 7j '' NS I, G1 VX K) Hq V6 +h -k Y? t/ QZ 2Z -( m6 m6 pT 2a E< sr Xr zW cB LG Oh BC U+ II f4 eU aa Rj Wx 1: 6g (* Zo 4N gZ /T mz #& Yu ,D fh fy Wm GG N= == 3( Zy fz 8D %W Qh de fp P8 u4 Sy %i 3+ Nr %? LC p$ WD CC A3 MM VK iX nc
			7
			Smith:               K5 DK ?8 :, le qy PH h) )E 8\" s? o0 #! uA SG (p S+ hv a* kj '- =N ,O 1B VX :) xH V# h6 k\" ?% tL 7Z 2( T- 6T C0 2c M% ZE qr sV ;3 P? cv %% nv jT :N b8 jZ an VY v8 $U hU A+ vM 9R xW i? H; +> yl VT jU 88 :U a4 (b ++ dT ?x m+ F5 l7 O, N# !? :E )# gG hG fN +y p7 :D Je L> is %/ 1& Uf Ue yC
			Sullivan:            Ue #D A8 ,T Tl qx jP *h JE \") pN :< p# /u GN vm G) vL ta jt '% N. G, 1V iV N) IH Vs h. (k p? +t Z= /2 .- W6 L6 1p 23 A< Vr r% Fz >B Lr dk .9 ,> H9 .! 4Q 51 R9 C2 '3 oE V9 D> F( #* \"& M' xS t> u1 ,f U9 Cy 9S 2o Nd Qr 5g AB a; .l F= H4 p4 2\" DA k$ #K k' *O YU qT 3X F6 9w V* $4 8u q> oX
			Denzel:              oe TD 82 \"s 3A qZ P> hM Ek h\" PN o! #7 uZ Gu 9( )) v* aQ j< d' Nq Iw 1< pV ?K qN =V %h Pk VY 5/ kZ )Z -M mm G6 *p 2& lE rV rm VW 4B LY hV B2 n+ fI fm BU a> JR W= J: N6 (% So YN ZQ ;T m: K# rY x, fL f3 Nm G/ Nl =( da wm N' 5h O> ?T J, CW oV cw o3 'J \"/ <L xY t% J; sX LK JS */ &R ,P Cx
			Kevin:               Kd UD 8s S, l* ;q P* h% E. L\" #? o) !# uP =w $( +z *v az j$ 'T NM Ig 1a FV &K qg V7 Ph -? Y5 /m 4Z !Z t- 6Y 6H pt 52 E1 lr rB Wg B8 aL hw -B +\" =I H4 UV aX j0 WL :O 6u x( o+ 0N \"Z J/ ml +& YO C, f2 ,f mq G0 NR =z (! oZ fc DN %z rh eP p\" jP A4 y2 *% 3t Jr /? L, pG D0 %C 39 nM Vj Xp mc
			Steven:              !K yD 8; #s 3E wq yP hT CH g\" Nb Wo i# wa 1G mZ A+ vE ao Bj -' NW ,N 1C V0 )% qJ Ve 0h -k <Y p/ ZZ 2q -* mn 6n p% 42 ;< rP Rr WS Bc fw sD Yc X? 3o s) #I -R 7l $e dZ $N BJ 7u -n H8 V5 *1 DO .V cL ?? 2. v? K& AK nO rz kL Q5 #% )I v$ 8R 2l NF 74 8p K% ?d wb $= X1 8V B> o1 0% ,x T/ F- Re
			Walker:              0e D6 8C X, 3p qY PR h( E% f\" ?I mo 0# a9 =7 &( )t v= qa Gj H' bN ,= 21 V, KC qe gV Yh -= w? 6t 8Z OZ -h ms 6, pK w2 En r; 5X WN Br pL sh BB i+ I0 fe 4U aj R0 nW m: 6= %( oV MG '> uS b? W& U0 pR !i 0i 1X -( eI f7 Q5 .+ rf Y: Vy F4 %v b8 yp Vj /3 u& aQ Wi \"C fF +< C2 0l oY Nd :z Az Iy
			Conal:               KK aD +8 sU Vl qP MP 3h hE r\" N7 Ho j# u- =W (J +b Nv \"a uj j' +S I< v1 EV 8K EH VY hD ;- Yc /M ZA \"Z k- 6# 6< pT &2 2< r\" X+ nz B6 LQ hS aB UB 'I 'f ei Fa fj =W q: 6Q X( Uo XN Z> Tr Km .& eY ,p bf fw *m GJ NC =F (1 pZ Oz Dx R% h4 d* gp oP 4A y# Yv x: Ie e# e% mc Ze E$ a< 2S ,. )0 QW" );

	final test9 = parseInput(
		"Mother Dahlia:       u8 AA sB hh (( yy (% )t Tu 7P ww aa ./ %< == ii Qq vN *D JG oo Lr jq 9L pz af #6 0o fR ,N A/ CT 2. '' 4P uN -$ lF 2: u) wd uv v5 A2 aK aP ?f rr i? >> tg nr &O 8! jt &; mm kU jj JK ?L !/ -U uU PP 7J iW !Y M, 3+ NE t+
		Child Brittany:      8u <A Bs hh (( yy %( )t Tu P7 wp Ya /6 %< Z= $i qn vN D* JG Zo L' jq 9\" oz fa #6 o\" Rf ,N /A CT .2 '' P? uN q- lF x2 u. dw vu cv UA tK DP kf rr ?d #> tE rn &O D8 tE &; 6m U. jj JK L? /! 9U UD UP yJ iW U! ,; v+ #N t+
		8
		Randy:               J8 <4 s\" h7 8x yx (+ 9t ZT Pw zp #Y 6U %- Z0 -$ n* KN *e GG kZ 'Y q< \"# (o a8 U# e\" fJ -N !/ fV .- '< 3? u\" q> l# xg .b Vw vM ck XU pt DW )k \"r d; h# EN n& &q Da SE g; 63 .T jK ZJ r? b! Y9 PD U9 Ey SH sU q; v4 #t q+
		Gregor:              uK <P sF Dh .( y! (P tG TF X7 dp %Y 6m T< Z1 $y n3 jN )D eG cZ 'l q: \"d Wo Xa #: \"Q RV JN m/ =T E. 'u *? NT .q kF xu z. .P v9 Tc U& t. LD xk rs &d D# Eo rB O6 %D $E 2& M6 c. $j kK pL /& $9 DC UA Vy W\" Uc I; vf #s +b
		Declan:              <u #< +s hc (! yN k% t4 GT Q7 tp YK f6 8% ZK ;$ Nn 'v S* 2T rZ 'n jj )\" or f' 6k \"\" 6R $N /d zC <. 'g ?# Nx rq Fr Wx .; dk vg cz +U t6 tD kG Ar dH p# Eg rF %& e5 Ey ;; ;6 .b Vj JT 'L !N *9 Dx -U yQ %. U- ;L ;v #% t(
		Robert:              uf >< 's Qx (B =y %# tF HT P? *p dY 6I <0 ;Z o$ ln VN D# fJ Zs 'C RF \"o oV fJ #r o\" bR MN P+ ?C n2 '( ?3 yu q% FD xt n. wh FB /c UM t' .D k9 br pd #N 9E rV )O jD 6E :& 61 .5 jT Ka 0L !< 98 vD >U yG 0W gU ;; vr s# +8
		Albert:              u; <h fs hI (0 *y 3( t! aT P7 pM YT 6i :< ZZ $N n* N8 DF Jm Z2 v' jj \"q jD ff #e a\" PR ,\" // Tb .x 1' ?w XN Gq 1F X( .q dg vy c3 pU tu D; kV rA d* #/ E= Ps \"& 'D EM ;9 s6 f. jk KM 5L a! G9 Dp $U lg ti ,z ;, jv -# tr
		Harvey:              u1 t< s% h/ (n ya d% f) Tq 7* wp (Y 6. k% kZ $b :n vD *' &J Z\" '> bq \"q oM aZ (# \"N JR ZN V/ T( b. '3 V? Uu qw WF x\" :. /d Dv cl U& t8 LD Yk r! Td j# GE nY &* DK FE &# l6 p. &j zK 6L F/ 9= D. pU yn WT U6 ;: vE #K 6t
		Calvin:              8N <b 8B Nh (D y( %> m) hT L7 fp oY %6 I< aZ X$ n2 N< ,* k) Z% T' qp j\" oY a3 #v \"N 5n m, /L =T MC 45 ?x mu 4q F= xI O. wz uu cB Uo Tt M) :k 9X ds #M E: n) O/ DS FE v; J6 Ml jN XJ lZ !o 90 Dc UN (u Gi zU ?; vj #& !+
		Kingston:            u) << 0s ha ,( =y (o mt ZT 7# )p eY 6- <w Zl x$ n1 v5 *I =J Zo f' $1 C\" oh a( #X 1\" fv N$ A6 zC ul ?' i? uv I, xl x( x. \"w vo c& U6 tt 4D kj %r dx b# E7 nG OP D\" sE H& 6D .5 j, *x ?Q !4 &9 OD UR $y iF Uz ;o Pv #k 6+" );
	
}
