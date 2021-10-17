package test;

import Std.parseInt;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			it( "Alone", {
				final ip = alone;
				Main.process( ip.wallyWidth, ip.wallyHeight, ip.wallyRows, ip.pictureWidth, ip.pictureHeight, ip.pictureRows ).should.be( "6 1" );
			});
			it( "Hidden in the crowd", {
				final ip = hiddenInTheCrowd;
				Main.process( ip.wallyWidth, ip.wallyHeight, ip.wallyRows, ip.pictureWidth, ip.pictureHeight, ip.pictureRows ).should.be( "5 4" );
			});
			it( "Hard", {
				final ip = hard;
				Main.process( ip.wallyWidth, ip.wallyHeight, ip.wallyRows, ip.pictureWidth, ip.pictureHeight, ip.pictureRows ).should.be( "28 17" );
			});
			it( "Very Hard", {
				final ip = veryHard;
				Main.process( ip.wallyWidth, ip.wallyHeight, ip.wallyRows, ip.pictureWidth, ip.pictureHeight, ip.pictureRows ).should.be( "9 65" );
			});
		});
			
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final inputs = lines[0].split(' ');
		final wallyWidth = parseInt( inputs[0] );
		final wallyHeight = parseInt( inputs[1] );
		final wallyRows = [for( i in 0...wallyHeight ) lines[i + 1]];
		final inputs = lines[wallyHeight + 1].split(' ');
		final pictureWidth = parseInt( inputs[0] );
		final pictureHeight = parseInt( inputs[1] );
		final pictureRows = [for( i in 0...pictureHeight ) lines[i + wallyHeight + 2]];
				
		return { wallyWidth: wallyWidth, wallyHeight: wallyHeight, wallyRows: wallyRows, pictureWidth: pictureWidth, pictureHeight: pictureHeight, pictureRows: pictureRows };
	}
	
	static function parseResult( input:String ) return input.replace( "\t", "" ).replace( "\r", "" );

	final alone = parseInput(
		"3 3
		 O 
		/|\\
		/ \\
		10 10
		..........
		.......O..
		....../|\\.
		....../.\\.
		..........
		..........
		..........
		..........
		..........
		.........."
	);

	final hiddenInTheCrowd = parseInput(
		"3 3
		 O 
		/|\\
		/ \\
		10 10
		\\OO\\.OO.|\\
		..../||\\\\/
		\\./||//|/O
		O\\|O.O\\\\|\\
		.OOOO|O.O|
		O|\\||/|\\|\\
		\\/\\/O/.\\.O
		O.\\|O/\\O\\.
		./\\\\./||O/
		\\O|.|\\\\||\\"
	);

	 final hard = parseInput(
		"13 13
     _\\|/_   
      /--\\   
      |[]|   
    _] \\/ [_ 
   /_ `==' _\\
   \\\\|    |//
    l\\  __/j 
    `|-'##|  
     |#||#|  
     |#||#|  
    _|#||#|_ 
   `==\"  \"==`
as           
50 50
AfOajBjw}#sGQ.R~&x./&Q:63_*.vC|{XS4F{Kb\"iTD#s4.{^+
0/.I8&H*NqSIa?cA&+nl_Pw^6Fn.N}r[.y.qlo&.+j+~J!S7|#
%..&dlS~.D,0KO]12._'p.oJo&SL2['V{VtMm+u7:AMWhM:Y\".
o!:c.k5L.t9gy\"Rr9|v2O5YCo|x8C.k_0..m.-.i..Ca}7b0e|
$&CyIZsM-('+i_i/VTjEL%mn%;CXEW(;3M}A6BMs\\K]-v&8I{y
lYQ/U+;pS?w.iIapJ,^.iuh{Ka%x{=e\\5fKEw({a3Q*!=zB7-f
P=Mkp{RZFTsQyW6Bfd}?_W.^u7LG\\l/oI\"XiXV|S(,YO.nsCk.
ty9sm#rR|XWk4t.dhM}Y.ZnV*w+GngPiwA{QVq/4[g5H^.iF9$
g.D1|.lnK|^\"D*iN-EBDY[,K7:\\%Zfo8,Ja8%.KxFH%~9f..zY
(.dGvpk_\\r/F4E!Co_*Q8u_e}qk'.1^nWbsK5Go\"Y'/tX]$RjG
[*}&|9~]HeexrIv2&2mG;*%={.U!W}M9.K?mo;mYZ5}j.A.H+^
qrF$9hdc{iokTJ7LU.;iNlQ3.i~?p7mn.0*vD]!3jm.dJOl5RL
%'9-Yf!.=1xI'A=bI_1MhVgk]BFNtH=ut$\"zT-b$U1dpF.zVgH
gsefEA.Z-x/DY55coiO,YU{.{VR[.yb&G\"A$qnO0T_].drdO0C
2qhJ&2Bwo&*|%6v[+,E\"'b9(t5Um.!RdGR,~.=c:S\\}5.4oIYn
tGj:Q1WtquhoROH.YD\\Lna.6J#cel4Qm47Wl\\7bkDY..6ES0y+
f~Om]t,TFYZSh1$^Z~#w~{C&i5u']fQS.nZ6;R7CPQCT1~Que.
.77cmoY5eK}&TAih,\\cnyis5.J5&yxoa*_\\|/_bKiiMxE5+bLU
oWr{M?Pbu.Z/H.w}bo}zw#_8eq,\\BrM3N$/--\\_5J*Zy\"I.4bF
3&dlxv3Z'w]U!dG^B3:4plvJ[OJ..,Oh_^|[]|W(dAe,6-iW{|
hn[NqS49u&'#.q.#0.O.L]h\"0|gY.cF(_]4\\/W[_][h,akX(|:
DDhoTigf'BLf{sT]p\"1W.eaD$V{K~QH/_e`=='N_\\l.S/_]|sb
^,BJ=yC$L}r?uM\\sM'URt1NfB5KX3&W\\\\|U.{z|//csPEY{yYX
WmL..JywhH-%p1RpTK{zBn.e.qI}!.:ml\\DJ__/jL?s!1\\'7+p
fWHywJHGa6bAVF8.%jyiZdI%(5^eT.E.`|-'##|_bzQLjlp'h&
o$J|6bo1L6OD(tCAA_8R=fzEgz3+,.Qi=|#||#|?duFtU:Mxi&
~vu6(jTe&GOq-8pGGt0.#p}=N./f&H(G||#||#|ZhDB4x'F,do
Ht,G{?xyslJOuRTiBb.^SaMa.4-J/0Md_|#||#|_+5n?q8j&lp
1D^i?G.,?C.(Z7/FMZR&O.fV+((!~cV`==\"ii\"==`+(9PkgV=~
vZIC!&xQk*Tg\"9..5]86xT0.=R-Mas.I.].^?^&q~8*qq.lt',
Ug'F3.]0Gz\\\"KxblB'(\"g9qS%4?J7pF?0II!VOMd^l5Zv]x0pe
VzGa6\"[KZ}g6_q\\zBb-B5'P&[^d7w.Gku29fEZ.W&l|N=FrP4=
:w?(O9&Wk?*zn$7^MGX-\\.zHRU+c'1$4czhkPGnav*Oh:0+l%a
#~{/c=+DM\\?.9Z{ux(?XWftX9lCs9[W\"w\"8_,Cxlnl_tEOo|pU
DkQyU(7Kg[9%.VN~0*{}X^60KLlasv+Nco3ML}H%BCvGRHQO%U
(G}r+IU|-i.7r\"#w$V{bP2Qm,u/zic\\;u:H7P~rv#Vjzd.kKNv
4^W.fB|'V.8u.\"neMTUB.#D,j\\SqibjF\"(N]qQ9f.2FO2;:ym]
y7|mN,7~?k&/$U8DJ_On(=~P0u3|jLvuej.SP/P.IF.Yvc*~.z
D%&}lC.Q1ti..z|5...q(9T,%YrBtXL.j&iQKg+Q?]nw964V96
Ioj5L9Bns3lVxe.F9#rOv3,BU-Wwdp\\?82px9TOOpx-KFp.jOD
=,EvL.R.lWnejd9P(.-0?qT$z+/C=FnN*/syHNrK.'I{Akn~.|
Bhv(8.s0=Nfp\"%J!wJ~KhQST.&*2So~-0gdfr\\hMg.Q$F6b2X0
($aG.\"4.j*}5i.3q4..DYBCOEA]:nn.ve{Ag(tyrRQ\"yNQ:9qo
bx~tc2R2bW'|4^a.0qWXDLV0'iQda-2GY}m0L\"|:5Bs.F1'|y.
[Xm9\"6.AG\\lN2n\\VH5&QH/B.{bs$uBw1%F}ft|nV*lU^3r/e.&
twf*DqwF.~N}gf:08wp|CSSE7wvGu!Cn^Ki]V+c.&(nDh~eOxc
YS|#W!..qg^|kaXzd?=:f?uHgPFpw.r.jrs&yd(Hu$.^'_$m%.
.JSY+'yY'hL5UJ|p.#*;b]*5UB|yVm?sJP]*E0uF0/r%^4yMg;
m~Eh%.0'e,=ad/LtwfJg~v:SnC*d9|dTs*]\"(C9syRWYI0,RJ.
Isc]'{l\"\\T}Xsp9T*v/0F_Mr*J:qk25G9{W~Rs^i/cHpt.yH-|"
	);

	final veryHard = parseInput(
		"6 6
		\\~~~~/
		|    |
		[-OO-]
		| () |
		|    |
		`----'
		95 95
		.1u$n6#?bhGkkS2SQt.c?D9o}/1r.L$I~t;]XZ1$THWFQz?wspILw!HP#f.Ne!a6E}z{.2^{7dZE.D:/dF}VcHlk\"yhR.o:
		.G[bS].R5tQ$tqd84GeK/.V3+'ogWVTnTE.+[Cw!z-JB13#_.5Sk!.]a\"Cd5~:\\k!DA|Kf.CkEl~ItbK\\vy{cIM/E%m3y6|
		0_y1yDdZ.'qaL9p87A9?5QdhI[004_peUP0{j8$g{?Ve'IbgpnUD4^zj|qtH.S\\*;mV=ixY]W2._\\}v]|TLRO\"PZpQc_PME
		P.;H/'f+#5V.cqGp[\\tSygTK\";=.7u5ZkyFsx7Wn&WT'#fMI&Bl}w\\fIyDVc[yF;a^?$\"n#yOg8.26R.A3+Gi6Dqt=_\\lTw
		1q.'=J9W?I(ZpBC.7'/.CB]4J8V0|u}m\\&g2%.UM6gB+vhn-[pCiM._zrsSE(i7RK!4Gu!a'HClw]bICU7./{[!t|.L3CpY
		YP~3VS.9qpP!j5;Ap&q~wO{ZU]LQOFM0s.3.oO'&,+U0Rp73sWv.lECjYAiVhHv~.|XFc{m.=Goy\\GhEI.y{j8P(STy(FH.
		F.9.28B1BKT..qdprs$nziD!kP.(Y8yM53&WBYV,gw+X6\".,OEh.1tTwO#;m+Oc8mhrqHW(8;hgdl.ky%+Ou13~Lk3hJ~I:
		8tELZ9UF{QO=UnPk8.PHa]*gYw%f.PU.FIN&.K05B7W$n6Gy.SO1La:8Lx'D(O1S=67l/6Dyx&gITf_#[XKBa_MF9.OYXx.
		(gd.W]uYepqD1\\GpGE\\NGdzScuCS\\r.!]itCPyM_?}Gm~5~LD5iu3~L&.1.C,.3'KPET!d!h{b.H,n8MK{oFjZnp,JV(Ukw
		_LT.KBG.z-aD1idm9_H#%4x$~Co.HY'3..*=tLxldw-Qiw1g9w'\\nsQEn/[im0D.bNW.Ah_x?w|Y!..4!ink?#Q4DT*TVp}
		S_mP?/%.1D5y[D#4GfCHeMsgi+#S.zP.VxM43H]-^B2.g.ZAL-SOs._g!gG;.C]C((.9{Db}fNM.~LaOO7h#.bY;EG-XbBh
		8Cz\\s{|Ji(TI%LqvFg{zpvhV\"EeF1PT=$G.Q1R.WYx}eD8$CnkYRkc#Nv.i('0*8KW5P6!.-yK.{wcrt1.rQ[c'.NGu.J\\.
		+PF..dE?NQ.s/Aars2-CkJI.H9(bAV(VE!.S[IKqwg.av&nRNpctU7Z3g3CnpDL{2p-}VXA~s:fd4IWYWM3kS9b,qqLCfxa
		_.'Ng\\o^||sb%1V]:h.6$/BO_or.Em+.^:mJ.\\Q3HQ;vA7vl?r,vB6xuJOU{$G6${NggPmx$6qyCbfnB#gmnP.SER{]DQY&
		b~\\E(1p?Y_#4kH\\sDAs];tSEp^.5Yn_DiGxSh.A!$K4uWnH+W:?dyZm.H6o{&0nL]5W.jSl1]SwC5y*c3$i&R[eZuPlR2I[
		sxtu[63-e2je%C&si*mEfRE_j0=Z9G.]61dfLe{L]|ewH\"zwKxd9Pe\".#zkF.du;#kOuz..d[.EpNh2xB!pMDbZ1!Bml_1!
		^?HEwNe=6Q].:/?E~;(e\\-.J[1'U+7?jEaIUg$F~w$Y=Dz~'e+BOgX.h(+O?10}}%[N;GqxhIc.qF\"g6!aP]Gwc.tB7iF.z
		,.0qN\"nV(!ugd!5.b{.\\1l]8Y(6TeZp.;$kM%?8%3U1zlq}g406rY!:1%{8Zu9QE0SIA5t^GybGgZ/WI-0|U_+t+fZ7-ci0
		_dw:9.:RL4z#WJ7bfKA?.$^L3zLuf1hDqRMdCa(0pjU[9f,4OY1U.N|qh\"lJMUL&W=.f=3:fW/V1zf.Y2.%X]30.1w=R-Tn
		?;.J;C77\"&V+c{E[bj3.5:-&_L]U/6wrc2&(4?ev^p\\;T5X\"xG\\IA,X+&\"QBDn{u2E\\QiQBGeI\"Q.qFD-owJ,-[Fe'e$v$#
		*x/kp.h..e4D#\"ht9VmNo[YY:O5LwMYlAQctefq9.LQFh0+T+9LyjG$#:rM.f?WKWTdS&(p3ET6$QtQnQlO3bzb\\,jU'9P3
		l|f&4XV.jU.\\6/aSV.zA\\w_JwRi%/JC_-|U(KK\"5\\QEitFLu,7]lKo9|^?2nP!^!r(f!vmhk|9GT#~q[f(ihJqZ/w5#/.;q
		uU3{FA?]0Z-w!*p=lU,i17(GaEFU6uIDrSl}E_\"5K-YYU\\*{g8.uk5537w[a^rIGr1ex,q8r9g:,iF'gVNN+Nns1(YHhc~.
		tVsH_|0u[a50e{#VCK~UX$L_dJSKo&0p&MVq|}#q^tX+.3n.\\df,sFnPkzDZMqghPP.7L.5ER9ZDwOlPv*Pl.-+Tyfg6.J$
		.nPXH\"WysN!uY%&s?o(D4.\\D1SyJF?].i[.q.[$4/Zw:d9O;P(KR.godsm=|3n#XOgm8b9M.Lz3fUwA{e0_SBX(c..+9\\-a
		26/z=X.,.Q5gWSjY='e~ctPw[sk[A?.&WzbO%=DKx-nb?RHZ8sb.[d+JqSJ$N[Mk:%ZxQ?$]Z.2ofN0P\"0yh9^_TB8xC20=
		HScD|{ji=ObywQ*D.#\\{'7EQ$'f^*NQM};v,ck.X.RB98;;dSEUK88j!n10d\"nAZ}4zYvmA8xNqLG?*gocTT#g.G3VYR07?
		3r..eNo*Ge'nvS:KS$U-&..7#~_\\!3&h5.2t4a.8aunPf#Z(-kg;g.'_Kk.uUth.v.XT|U.S]'-4XH1]Aff5Xlb(|9&Tx0n
		.mKuALf}KE3:u-xLdZ$_PnSvj$.3w?CvO:iRmnA3uh?A_N.}7x%_T6:8.pkX.R.:bHzV..z[zp:HSsB,=?=}|J.*]P.+c.'
		.F+y1nBs\"}|.D#GqS(O1gV$*86RVG}B(WD^cV_/Y.Skaa/N|9zFj4r%x1o5^,%\"',bna=E?Yo|[3K.*_s1'h9rzFX:QGD$'
		|6xE]1N#E3.^:As'*F,$k#.tU.*Sy-EuKcb+mO&I.9YU'w0eF\"7b7a.='e&x$\\9Qz21,zv/KWE}QKAHyq$nNwD3Kzeki514
		~]hvz.-%klxUDbC22,1h].wt^]rMuk7%^/oRCeh3B}cB]*zI+SYLdT5c$-zATS1]USZ4(~AX5}%b.^tm/&O.2v.Rjl:N%.j
		&Nd.Xz.Umsa.e:4x..m0.d*Ny!hV.m'..-=4.o,'fEB01O;$V-[$8wP%46X.sp$aFy}p.aW9+AVF.y\"~cE](wij1Pq]l6|.
		|1BuDQXbUIw%I.jeF.;.-p|$wpN!1aKdi56.QeYKVDUV]D!&Fm.G#k./?X+nc.PU+t,.kF3BwDy1?K._O3KPGek}&[i_gKH
		:(aX.7}/aYJk4'veA$e/OM]o#i:_ux.u\"=0;.(+CQ-K{+\\Wm4'.pb.#B-'5:#eU.-oy8BYJN%.z0ciq}12FHQUsrdy**xzJ
		LJ7c*,-~gSJKzLIy.?6mG/nCJ^g4d/1qVJ(qLfIC;.z-gk_..]cm7nd,wE9'5z.G{t-[Xs(!DEO3PzwzcA\\d,OYIFr\\hMV,
		O\\#=(vdySmC&C/Pw=hJ~EE$9S.W0Fx%E.7]8XCId}cR{K4v9|^+]c?IkrzUs/T#uG}c./././G\"C('y(O'.KA.Bmz|Ry*pE
		Vjw0M21_jvCA,&fwEa6.'*Y\\0,[L~FR'ZbGt6C'B(_1o+V5Ct8nxrLS,1Ba!,pj..Q..T'6coF[_xJ+eg3rrrt.nZ97EBl4
		;&.KW.\\*Hclj'UYPsD=9i}#21%4l~uB!c!tjQ}RAl.~pgj.8atPbFRV/{u*!q&}m.LhmBO]t'?YDn.WS}^k7.AK0uUsvq!j
		C.:O.c?G1two9_r1o:G.u:HHQaW{.w.cl1vXPE\"QD4ZNYl!7c#dX~}|3PG+9V$ZEPudh;.l&'|O5p_&FA||-swsm,8iiHr\\
		0fu+Di8_H.u.\\ZAOVX8J6(.msb[Lf2cS.^-Z^^Vw8^Xh}2x3Mu21/*E,Li%Bsw-%..a]?!TZcL..G2n6.D]\"aR.'6rn'qtd
		Lh.Cv1y{?.cZDh9G*\\oX|xc%D]oIT26I*HG24A{eWLDj+{O.+\"F#b,one=}wN|Njk9!=.h.YckbU\\_*L1JL8x;HmtsX7B?6
		6+t}DrSd|j.[{..tlo2?eU%\"NC4$YZkwGTLW!\\UuiFVZQ.QRY]LS:a2lrH1a2/VG}Z0NznSr9H2/]wK6'muZn7XF{zEIIT8
		J~o0{wcsLWt&HN'm^=\\oPV^sGbuVa*k*p/t-~?TK&\\&d_*q{fmJLOFs--=u|cXr2ML97u+CzT0FV?#yX~CQ-P:K~XF]-Q4I
		B$x7YpZ;h~j#-a;s=;;e/hDm;a*k|}O&|rd.OA/HB5JdG.W~~ndq$Z8uPk_YHP*jLAd,=^$?+F$j:z.{T}z.\\xfFY&CEHra
		'.A7f.~(-JHtN.YWqDceIpgoou;nn9PE.F{CO7!o9lLH3e8Z]DlaFm7,.lT\"f,/v\\dNh|wiY3(Kx.:1j1on~XO]9;u1Co|j
		+LpNZ709$u3NR.K#c0Jz[Y-;Wd$K?.%K;.N\"4BbSbVK5\\bY{CCY..5sOXS{V(q}iOs/,EZE.Z[yLny$UV'hJle5i1}EmKV4
		~WBq.C\"3$+.s(H.Ay:Mabj5+K27kFvsHdCO-'ibr.zELE'.!.;fN+V3.{E.p?!xX%Qo1_#Oq;uF.%u8Y~[G7p.JY:,+XB'W
		_b.5(;q.'y|!.p\"=;?xE.K5Hbg6(w^{-~:L!}5.~.iTJze6I(!A\"dY.ZLO4.hD1{Hb|e$k+i{N9,[wi=PxaV.f~C='EZa+$
		HW2byp25..s\\6-f8pG7H~DfwCq3i{%Oh_9CpEv&.(7x$SkuO[uptJ6#eQG:h2T;=Ela=1[E_W~TsfC$r=os;6u;D!y:+W.v
		J_AOHkx'a|v,Zm!}o3XlNBaGjN;wDrGN.4jy%(Lh:Cs.LXoqaz0K]6*h__E\\MbY*Y*#\\dRtArPMkjt^2yXve7=Nn.bF\"YR.
		;.Jy35unYgzsZt:}/}.,-%Uq2K.nblH.!%/F!\\I+dK,}I.-\\id6'.%%{At,s~hlN:YS.UIx.6%8UjV**V~f+VV^^].fWypm
		=yzz&BjP!%\"wamB*.K-,abo{t2W%;C.WQ9,v&w}WMLFr.z\\*;]BlJSm\\kHgx%E.NeE%HQf}YMIA5,=w_8;h:b5m}X.lRp..
		h8{nGT2I7a./bsWxolm4hwdLPr.~/\\WJ?6s=%&[QfFP;y[k%aT=Gcm9~4V;o,.9;TJeL]0SEu,Y..GmYgb&v+pGY+HHzl.$
		D?.u|'/.Pa8mF3{dyIph?#N/DcVN7tttS#vgemx,HuKuFdb\\fEi[=.iKyd['GBpw.P.MI\"]mlS!QYtJAb0IDkDw.~~*bvLF
		ffoM[I42uF=%T_8'e96~%_'lUs(2Xd+[/m?LK.T{N}o}oX.(s}$I51Zltc#;VbfqHffGyxSyp:M.%-==P]KYA4Ao20rH(%L
		M_+6jSM5^VVs[o.GFg^yW7W[.%{$:flKKDa-.x(UdKPc%MJ]~t'B#X|.Mg(D08[|Kk*3n-YhsQumrTlGL{_Ut~R'OvR.JZ\\
		LTZ8.3.'=?.iRC$3_^X#9:M,08^p{M.:9W&87\"R.5f+*O.a0?8X%'7B,h(hb86\\Z-gO\\Tk^iT.C3.3x*8LTz|b\"cvm1.$Pk
		}lO_IDfh0,PChE;^T6yJwn.9(uM:GZrEe.ERD9-V2E_2P/.;YrhnVg(\"Q.go[H!bVkxMav8&...#titoQ/qoRd*+.SbY3!5
		v3{hFRH,CZyL$z\\7I0{;qq20RCA5Yujwbm1FCa-;ic-4t7f:\"~8}?cOfaH5cq.oiQcK6:5FH?u4oC+G&x2.;2k0}:WE\\L'W
		H(.oqxOawVACQOA.da%%4+RVFRM#rBK=&:xAW*q2*2XsC*jZO$B_6g{KMA&/~W*^kDT.r]wu~s+cPytXH'TN]QG$.((v]Q.
		B$2h}FIIOXgjNj-\\nhCH+cK^9+/\\EmauJQ?y(rur]Tf[_H#.##/o;j.zJ6Oa5NeCW\"/+N6g='kHU+UcCffbLM\"Xz,L|w$u2
		2P$Jh7^wC\".C3.AC-4l^0L9|?EPBb!~t7Y%euk\\.k*/Z9Z_XLjb77zcq%(:.s.u2bY.f=vi..R\".,jvlK{|#/s2IV5zGMrS
		Q4nYk--0qbx+pOAU,72HA.C'*=CZH=.IS}KnY0kxWG/[SuM\\vl2/&~s?CA!o1EtuA-Vqdn^lWE\"_fLK3ZIEwJcY8./~y~=,
		rnV63/v[hpRsU}z6[|m5ta=~yG(KEC,A089%0..-DRwg#&e9Xi\\I:GSrr.Iw\"\"2.Tq7\"FTgmixB.$[#OBu'vIE2tpS4|L0d
		S-S3.rsDd\\~~~~/NB.\\^7}HLp4O,(|q.Yu&(BCqwj[&s1eloOeDmQ5MTWgOn$WQo\"g.xw(l}2;\"!pp~kSzx*2dA#*FGv-cT
		3Q.GVC-#1|E0$$|EHvD?Tz71*.&O[W[k0tyzU*F*4H?|xTWomb]]0HaE&iY:TPcfcuaZVM&Y[Vgl3.EEz.C-W[Zst_PLA6F
		pF5'cS+9/[-OO-]!i.tP*mnZm?.F1=Oyzq[.}-B'Bb3?g.T#FtH7gqWdrg!H.7h..r&|Ji.tSHn.YSTFr|aI5.ri.(4{o\\r
		.\\~{-+4Yx|o()c|U/3Kp%7/n+a!vWT\"eYpT(:04I3G${Q8Sf^J|D..Ldv,\\(wIc$5k6ZZ~%o}c2P(.;EX.zm3XA$$Q8b6.m
		uD]BGc#Wk|!F.s|pN]5G1j|pi&'.js.Yx|Hl-WGC5opZ(sY0.BvcaK1lN&sWpmN#&rh'~\"A{8D!M\\GC[BB]*=.Y'Ew;eD&m
		T.w/?k,!^`----'rhXCv-n5^h9uX3ow3*rx?;66%41d.8I\"sqf6Xa4yGlB8c[om..!1VMSTQ[X6Cj.C/.bHYX/2u#{ZL}4|
		QOvd#.G.;1p6T+^wE}_v-.4zenG2U#hSC7q--$K#Qv9=Iijx+?uNfIb9&^}.Q$B.T;D'.hI14a.9n8{=ej5&:.N\\6Xe#.5S
		,_|S.%xQ|D9*e4IWrec!GoSg&AJvzcP.}Yh/xqwq.8/We\"IFya((.|lYR*8KMbr'('~WW8ya.'_:O^c+#d+yp1fiMYyPX'.
		%R(9rb\"*5.'g|=NkV.?SId_;B..j}J&T^hnx1C~^guIVCVpm]O$8\"KL.YqIKz.~v_Jl**pZs^/Mo?NK%85jZ6q71?L/L\\Q,
		DJm2_KHD&|0;l+xhk.2.98B5$.0mNQoyVdi.Y\"QLBBz.gTV3NE44H:c.iX*r&u[I.Bri|TYzFrQHI7ZAw+:j'Z{.aO?acz1
		gL[_.BN:\\%Fzqx.BR}Y\\'W.WsJKhR.Xwg5K=S:.}&y.EXz.ZFmucUE:04K!K{Fxmxit0(:&$uZl3.S]#8\".E3V..{~Hh+Jh
		Ub7gPgr,6CR*^tk*lL*.g2#Z.FS9cH..~R72kMZ'Rolcl,.Y.bv,o6b{jhEj3X9z0.+T2Y:/\"^B{R[NfY_'blf7tQ/SchQy
		_V\"RQ/E=yDW~sFjQt9z1.?8oUd$d'g,8L;HM5O+Fu+4:4vO-GzyI.|4y(,+N^Ajr6-PV};~%,\\G;g_Zz4|,3.D~VjjY#RZK
		_(Mh!%_|8OT?(Y[r_n;*f4WKCd\\M-p{DnZN~.'*T?]eoD8+=s#5%$.EFGb.;\"WbTXqYDlgWhEumfZHh.g+t^Zl0MvhT8hl8
		p}17nk9\"lLYQZ4y%}\\k6-Cf_L5lid3(]s1+h}!\\ZNmhZb.b.=BU:+V.'#7vX}0.YYZy+6q.y]0t.uV#!4El.ipb;.lpGVM1
		'FZbSMer.Uw:MBc7M/U_.PfPIX0pVbQ.3]GM?TQD0mFx'Q5M%T.7aT[Nzj9\\'-?.dTlN\\5^#zrIXj.2{#oJby&.ji_m1~VR
		?R0tJFrRpY~I&kJDSX.c:U.Wu.bEbSKh$/;gY3t2!,uTOQ_}/5.ejS$q.e]7D(P;n.4jND.-DoCbAqi$.c5L.G}B=WzU42y
		(xWF?\"~1M~..\\p.|6=v~Bxe|.$Dm[eAA.[P.$~M#+Rt0b5dlu78YI.=5s7Y{Y;?I0V]d/+l%ZD'~eT(r/r{zL.#]_~1mCUJ
		A.\"aW5]LxV(}e|m1/.GrH.L=*3ak|L]Tf\\2etTH2!%9.X$(j.y'I^CcTK-s#5|V\"VK#kDiIvM.R1m7Pe![D7Z7X${i9EAO+
		~z*zn~..:[6^r~QH$Ons:2-C('ptuOd\\}.7CDICt+k4!#,G#R![|nvzyKWLA.Z1A(?=KsodLm_u4+nJqWx.TYn..XJ{.=bY
		OYE(w/=/C;V.ta?Bxmu.N.h./(t'&xwOlL.f8AmRZXP.cK4.'i.?.xl7R2oIVk[fQg7*u58=]$u[IA/EzR].20,-Ao4fl$^
		P7JG=$.XxP;?}cuzq(&jekoS[J$Xfb3~v*%z}\\.1S\\.C|-:\"f|OrC.{ES[P2ayRv''Qqx\\Avkx6jI'3b?{Sp3LY1[Q.hUq1
		uSWQcOX4k5sged.^6DO[i.C8QE|z.ns!\\,M7'M02nCH0KETXjUq.gzSNq(]:Zy.+NRmI7pju$'$.P.xl\"HpB=O..t}R}M\"d
		|UJn_rk[_L=auW,}O6((riWa}.So8:l.#&-Bf4E\\!Rv[aOQnX]cHY}\".}Jom/^xvApiK8K_&C_m!(5a0GE78?$z_+hD?Qru
		.ua6\"FfVmgtf4\"l_IJ4%KE4ZX|oN0hyJk/IV']puA&U2S;.i'o\\C'L&Q5Qi^r8\\f*~\\|S5gJtJV1&ch&vf0Mm^W/|{[M[ud
		8-O.8$.5xi1iT[y63Jz/mhX#'Dva1/.S]G',KxOfRPDE1'd*7ADc6U{0GV#EY.eYNijme1vF\\uy,.tHaAMJAM7\"UPBF|FkX
		;L%[S$[.fe+hMwu.no#elL$m.x4;.vGa~,1B]D-wJ8DvOZOyuVs!NfMB79kvotc~;=x!?_.~A??SiX;w*GTwc62.Az.Ft8i
		p6SYSC:2B:IP.K_tj=(M.!%.hJSQLzR772V'5]v\\k.rX.q~JGf0JFvBP~?Qi&xqcw..q|g4j!_CdYxn[ZijG:hBLAfc\\Zmk
		'3pA#I.UzQQ8M_y{2X0Z!n~DpPM|&e.04*PPJ+uX|4~|xO|SboQM}3J/.\"lS=..v.[e3U*X5Dc9mD\\g!0_(?4x1aP!,X\".0
		k_4iHKC}t6\"j^_xL*%L#d[]7ZEeo$l]$1SZs/':Fy^.e.o6grE-.P*Xu\\+ZdGouh6hXTKe,^gf.hv\\-K;+=OxxD.^Ey.C?]"
	);
		
}

