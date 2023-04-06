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
			
			it( "Velocity-centric race", { Main.process( velocityCentricRace ).should.be( 4492 ); });
			it( "Elegance-centric race", { Main.process( eleganceCentricRace ).should.be( 98020 ); });
			it( "Balanced horses", { Main.process( balancedHorses ).should.be( 107044 ); });
			it( "Linear horses", { Main.process( linearHorses ).should.be( 29220 ); });
			it( "Affine horses", { Main.process( affineHorses ).should.be( 226173 ); });
			it( "Bimodal horses", { Main.process( bimodalHorses ).should.be( 4492 ); });
			it( "2D horses", { Main.process( _2DHorses ).should.be( 345805 ); });
			it( "A fistful of horses", { Main.process( aFistfulOfHorses ).should.be( 97225 ); });
			it( "For a few horse more", { Main.process( forAfewHorseMore ).should.be( 35608 ); });
			it( "All your horse are belong to us", { Main.process( allYourHorseAreBelongToUs ).should.be( 33322 ); });
			it( "Many horses", { Main.process( manyHorses ).should.be( 1293 ); });
			it( "Mmmaaannn, That Sucks!", { Main.process( mmmaaannnThatSucks ).should.be( 0 ); });
			it( "Don't overflow your stack", { Main.process( dontOverflowYourStack ).should.be( 0 ); });

		});
			
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		return [for( i in 1...lines.length ) {
			var inputs = lines[i].split(' ');
			{ velocity: parseInt(inputs[0]), elegance: parseInt(inputs[1]) }
		}];
	}

	final velocityCentricRace = parseInput(
		"10
		6850207 0
		8707138 0
		8028585 0
		3635318 0
		8612162 0
		6854699 0
		7106093 0
		3721952 0
		2670046 0
		1746583 0"
	);

	final eleganceCentricRace = parseInput(
		"10
		0 8594871
		0 4376738
		0 5869733
		0 3970664
		0 2878332
		0 4760474
		0 227963
		0 9555082
		0 4278718
		0 1089921"
	);

	final balancedHorses =  parseInput(
		"10
		3531127 3531127
		8847040 8847040
		9954369 9954369
		6461507 6461507
		6730693 6730693
		9610510 9610510
		5339600 5339600
		1461099 1461099
		4075186 4075186
		6677171 6677171"
	);
	
	final linearHorses = parseInput(
		"10
		2664206 5328412
		385670 771340
		3632721 7265442
		1272558 2545116
		4182028 8364056
		4384423 8768846
		2040178 4080356
		4451006 8902012
		2673946 5347892
		975389 1950778"
	);

	final affineHorses = parseInput(
		"10
		7008973 982054
		5349792 4300416
		3111744 8776512
		5717622 3564756
		5899479 3201042
		2599231 9801538
		3993617 7012766
		3187135 8625730
		3317404 8365192
		5793015 3413970"
	);

	final bimodalHorses = parseInput(
		"20
		6850207 10000000
		8707138 10000000
		8028585 10000000
		3635318 10000000
		8612162 10000000
		6854699 10000000
		7106093 10000000
		3721952 10000000
		2670046 10000000
		1746583 10000000
		10000000 8594871
		10000000 4376738
		10000000 5869733
		10000000 3970664
		10000000 2878332
		10000000 4760474
		10000000 227963
		10000000 9555082
		10000000 4278718
		10000000 1089921"
	);

	final _2DHorses = parseInput(
		"20
		4618437 6674593
		3514840 7691515
		2672663 1665342
		5631166 6201289
		9945095 3677291
		1512462 4361
		2505387 5874765
		1291399 7215528
		1660077 787560
		9931494 5381878
		7915213 4933424
		4831249 1702132
		8635501 764174
		4280909 6682870
		5130005 1332040
		2404884 8112820
		6220969 1077590
		1304552 5025490
		8009975 8931210
		3783886 8177379"
	);

	final aFistfulOfHorses = parseInput(
		"100
		476232 6099056
		1252195 8195024
		5179797 3726665
		2529858 9172796
		7961959 2561085
		9263926 3845617
		2456202 6000415
		9192480 3336489
		8385706 3436795
		7633011 3341236
		9600683 7771955
		4180801 4369825
		7882543 5920460
		7642730 151115
		1369927 8322244
		2964558 6707262
		7788173 1490791
		8991412 7392994
		5321429 413931
		8568890 6052054
		3473046 1616509
		7091766 49737
		3913880 9460643
		3515415 2384655
		6699786 7028201
		9970257 1358714
		710257 3086432
		5400992 2792219
		2362365 222315
		2561008 2817585
		3011758 8441447
		729903 4583383
		670590 8216624
		2721940 4369326
		4237122 7149588
		179753 7677875
		110994 2742519
		6396540 3760912
		9410680 8086228
		8608224 4098416
		4845345 8038040
		9002862 1814263
		6233776 6318808
		4797363 1542758
		2600525 2196497
		6352079 3404672
		2388101 2490411
		9183978 7476586
		5558651 6629134
		1182081 2311080
		6955727 686161
		2639207 9963413
		7273848 9616226
		737340 1784216
		139513 4394573
		5737251 1535489
		3222188 4149579
		6734466 1672743
		828881 9560738
		5892729 2810128
		1233882 7310373
		1523550 7254201
		5979735 925498
		9248067 3268740
		761882 8279829
		3288654 4536675
		9263699 2854534
		5256788 7641273
		6708636 4746187
		8726430 1728770
		8990622 8683541
		4535498 7676634
		4362813 2949997
		3800137 6819590
		6919651 3240441
		4746861 730059
		6890407 4900751
		1886958 6767077
		247994 1652869
		5027767 8561296
		5779668 7401376
		3919775 4662213
		8802825 3808880
		6791371 2012836
		7656948 1433158
		6970220 7418201
		8260610 7911150
		7608637 9825366
		7970563 7182155
		6128062 8027917
		8079463 8449669
		5314462 2747934
		3182400 9529169
		9502662 3239530
		9753972 3615219
		1485409 7313285
		8312047 1178908
		7705447 9619362
		6988250 4685659
		7000551 7174156"
	);

	final forAfewHorseMore = parseInput(
		"250
		1570777 4940542
		7881461 4566154
		7307933 2691607
		3365532 490795
		7357598 8371440
		2686548 9125173
		8256894 7792118
		1764848 4845191
		5448180 9342401
		7545617 9339453
		583987 6669297
		2792967 9282205
		379997 4503571
		6150700 8575994
		8371159 6150796
		3727791 170195
		2252483 9174300
		3548329 5250694
		2143736 8586973
		6873327 4452957
		4623653 861208
		5001375 5357466
		5033324 3832674
		8063270 7970621
		5930016 6342555
		4450912 9170115
		3043389 1619194
		8802250 3601665
		5288264 1984720
		372629 1560630
		1745698 1682435
		6660531 9690186
		3742247 4310177
		3355467 2496707
		2722138 1523068
		7102399 7748014
		6286375 8002282
		2825880 6712933
		3115263 1996749
		55421 7259113
		8326613 1510805
		9999351 9294225
		762224 9067223
		6217234 4564119
		2632876 6213056
		361426 6966768
		5560591 6002388
		1348437 2265739
		9291640 3689037
		1763829 3260785
		4950893 4053202
		1614662 5371153
		1685212 7085053
		3566814 9391180
		7699533 1227526
		9417808 475416
		6104182 6768703
		8167228 1696174
		5527042 8155817
		7095894 4690286
		1242102 7519226
		8722353 780763
		6550521 7242795
		5372951 1735759
		6526594 4350667
		5912892 7130879
		7995366 6309037
		4504809 3637012
		5008604 6731359
		2184095 2895858
		8180275 748647
		8693585 7807319
		7361629 6441706
		4062270 9780931
		9390826 8863977
		8533155 947925
		8435317 2603320
		1864602 8548055
		3930730 3485600
		1999824 3158725
		6762901 8516019
		1403428 6492620
		5376247 9245530
		1816870 7929003
		439543 8855239
		4131791 5445126
		5858005 8943915
		5898580 6265371
		9868702 2510955
		585318 4341137
		8055860 4334235
		8018874 6114452
		9016228 5890158
		6946189 7209401
		7516218 6349278
		7851547 1450701
		2017005 3858503
		6088097 9547208
		6887589 7299920
		3093600 8925208
		1246465 662749
		2556908 3483673
		8718962 2901049
		1510126 3809164
		6299449 1154103
		5599824 4875784
		7576921 5113684
		7428622 1116104
		711417 3423628
		5576640 3538691
		5411256 7739630
		5462577 2249892
		4712127 7564362
		6869841 1180853
		6335141 5464796
		4058656 2300830
		7819433 1690843
		4755999 296304
		8284782 3619521
		2838701 8200174
		4660992 5575211
		4609151 1260430
		9384773 309060
		647273 3343682
		1054186 4300106
		9277512 4182311
		6269217 4764637
		5717398 7774
		5079687 9182090
		4508103 6685787
		95009 5775213
		5431611 6907216
		9651651 885312
		2889576 8723092
		3532482 1882428
		782380 5581172
		8917612 123703
		3941701 768994
		8629979 655908
		9825424 5944841
		713719 4640928
		1700704 2300071
		1122711 7813382
		5171376 8306779
		1256047 7260923
		1432850 3332828
		1492621 8209877
		2875761 6427422
		6266279 8717793
		3954343 2976083
		6884756 9792457
		3964114 3782190
		4810141 702391
		9443844 5447107
		847026 8501785
		5268604 3092954
		8269561 9103920
		2604607 5807701
		9784040 6799026
		3254434 7404546
		7074567 4778392
		7566416 4795522
		6002007 1006392
		3078757 9508368
		2088566 9341829
		4013231 4557581
		7270577 2971881
		5251798 5353054
		5870679 6464553
		5680661 4837024
		1938760 9703544
		3959320 6232536
		1431400 4934001
		8588039 2220906
		6815957 565857
		4357543 4004737
		2552963 8356936
		9153144 3425831
		2265390 5390573
		966045 3369532
		263296 7788004
		1683261 7279972
		5256125 8426651
		5661173 5322477
		4632608 7800081
		644502 9054108
		6481135 2438674
		1711894 6301223
		9704177 3552846
		5582009 5100982
		2072749 4460391
		9802014 8254408
		2075995 6269575
		5596859 5381398
		3933094 9719809
		3047113 5888224
		417537 7198136
		5881203 6387129
		5246015 3074518
		641526 8683720
		4035935 5610687
		971358 7214860
		9348273 7930704
		3960124 6928325
		3498485 4687601
		8099293 7101998
		811624 1066544
		4691615 2967949
		5273452 234654
		9306137 3604363
		7323758 8040506
		1894562 1161405
		5368720 1098524
		2827057 6777378
		9754847 7937245
		3744215 2606802
		4027932 6874172
		2665040 6216529
		5657837 8088662
		177757 3609933
		4686307 8038675
		241816 4619535
		8374409 9104861
		4647498 77586
		5593453 5999642
		3547397 3651749
		9904868 8059576
		6755983 3544089
		1778011 5712275
		7305350 5328010
		749055 2996857
		2673990 8377296
		8359097 1497760
		2329174 4868273
		4036720 5060611
		6931774 3860594
		3602044 7486589
		3465852 9040998
		4439569 5495809
		7425927 9310442
		1571068 7713993
		3305802 7377406
		4593596 3530002
		5298642 5164288
		9749010 7310674
		3184228 2321380
		3059090 7715978
		2723144 8061657
		6574428 5460497
		3907011 8373888"
	);

	final allYourHorseAreBelongToUs = parseInput(
		"400
		9166353 5567161
		3889550 3577427
		2744337 5321118
		3465268 9865823
		6563434 9312297
		9099668 3394597
		4657842 3708515
		6435966 6585673
		3948635 9533020
		3181967 2035911
		8457860 946638
		6867997 5751590
		6867579 2533252
		6543418 186944
		3528917 7860179
		3419725 5842985
		4352654 9589834
		549980 2971814
		1670602 4209621
		4301988 1788729
		1663379 8439336
		4982193 9201053
		5604213 6141772
		1875427 7506806
		1550078 3331175
		90794 9792234
		6582087 9030475
		5885487 3265064
		4899310 3312858
		1046876 4807015
		3427789 3073513
		9950864 8327250
		1824596 5766686
		9114275 5667406
		6321689 1521528
		4485641 7873863
		8533572 2383313
		6967584 1545705
		8695250 1736984
		9362302 2025311
		3632735 7736012
		5237416 6666696
		9708712 7416014
		1312265 3945199
		9923585 6410557
		3585192 8317322
		7960665 6253245
		4312531 3464474
		4198986 3249129
		2392998 3728214
		4314337 1089446
		6021500 2442580
		8066196 2682669
		499698 7673084
		8024258 4154131
		9703954 8169611
		7403050 7354625
		322735 1626111
		5708271 3399989
		9024663 1513884
		6696405 3280045
		4175737 9624143
		7133711 7123313
		2592029 7232234
		7216993 8637496
		4625237 5599613
		5272894 8074336
		6197618 4885692
		4752424 5957288
		7325564 1881762
		631865 1083654
		3324398 141165
		3450163 2948021
		6929090 8807868
		1467728 8865699
		8685968 7890054
		7214881 5494460
		5389814 942837
		2183654 9107459
		5310970 577680
		9059640 7463283
		7261374 6274656
		1927037 2210447
		3001385 7412781
		1827984 5869256
		8436357 934819
		4215070 3126150
		4870323 2714195
		784057 6682887
		3181929 3487033
		6273357 2609970
		9104395 4552292
		9710456 6101665
		9297546 9634089
		3696979 2915953
		5097699 8055549
		7358606 4460451
		2753675 311964
		2029801 464319
		6668913 1278102
		364044 5122676
		1266194 3571866
		1906596 3336138
		199919 5361964
		2069015 8672424
		919311 3395018
		8513915 4584193
		2223872 4878009
		4087443 3518597
		1170570 6641705
		9299441 3296394
		9242538 8692718
		8902347 7625789
		1354694 2705171
		6095921 4107837
		2367221 6483033
		7303404 2502547
		6148738 9122631
		9124566 2429884
		754524 1109620
		4052394 9806237
		8369214 389802
		704151 7049403
		747636 2459177
		8806880 2964680
		4942551 6531995
		5915897 3948560
		2135826 4079333
		7037517 1068335
		5923483 2603927
		5960487 5205351
		9009241 9955086
		7442000 9952711
		7031611 222106
		7492478 4657285
		313075 5113607
		8188707 5869299
		3334645 7477729
		7828615 7645438
		4394642 394624
		4215685 434295
		5427501 4134692
		1600441 5603331
		2588792 8686500
		1765712 1647876
		9739620 4886475
		9157911 7514866
		9201627 7203494
		4355728 4692846
		1448622 4627264
		829510 9337821
		9129379 7967628
		6459022 7949968
		1886586 6186848
		4005775 9374154
		9788781 6558896
		7321138 4208316
		2295916 2785446
		1936859 2265664
		1037216 7410529
		7535527 4402488
		2325043 4583780
		4121207 6803283
		5325390 2451346
		5272572 1374546
		4749817 1135325
		8211124 3060565
		452190 8735180
		7385673 4137070
		7564725 9291839
		2472462 2496700
		8980914 9847677
		3010663 8904711
		808724 9169886
		6009392 621644
		1627929 5343753
		3729913 1765156
		8273710 9155230
		1201583 5575712
		6749335 2244296
		4890048 9276443
		3589323 4603600
		9099980 7548263
		4428111 2708649
		7242278 7506044
		6086024 3890484
		3888616 3344864
		1603725 2399776
		6716931 7068196
		4309047 9769228
		6943808 7609585
		4188102 4771900
		2848863 1569448
		4089053 3615886
		4508347 7218841
		3176311 7535821
		3137961 9538398
		3671019 5070886
		5547180 8185465
		4387288 8894968
		1459074 5394146
		561081 9831709
		7962342 5046468
		5659372 2795676
		3528273 3298968
		3471766 3907462
		2018798 1155198
		1077363 4398034
		1387400 8844256
		8029258 3515313
		9569123 4558370
		9122278 9249058
		1886474 7434761
		6752018 5980425
		6463805 8210727
		511935 2227828
		1223571 4964727
		2218317 8495183
		3395288 5164841
		1939962 5232640
		8744406 5920484
		7310919 8400095
		7347677 9070827
		3922721 5793052
		8408880 6397594
		7960354 767952
		1810380 7830511
		4528183 2315189
		5599488 4686681
		1903951 6504436
		8962778 3572875
		5887666 5506473
		276500 60558
		1635969 6922487
		1148331 5252341
		7080833 9676385
		4877464 1186308
		944886 8804449
		2130391 1118734
		5236301 2072747
		6813606 9189466
		2217111 7335079
		858277 7067543
		6504655 3188400
		933338 6813493
		6032079 2970192
		1771031 3451328
		9937631 6061030
		6903096 4346230
		5481897 2299836
		6027576 7317949
		246650 7989315
		98356 5026027
		5119410 2271537
		7475855 9238467
		9915895 3801438
		2302760 7493786
		8471758 1758299
		5659817 3897434
		7209501 5837394
		280798 523153
		8652202 4387677
		5711990 1440485
		4239477 2144428
		6119672 5739607
		3761200 1792374
		1590663 2208918
		8450318 1035325
		3128429 7330220
		2488409 6999489
		4794579 938263
		1628321 7122154
		5037642 3849375
		5610503 3544629
		5424310 7757531
		2858024 1213466
		4260401 6141747
		5925395 7078789
		6258368 2398174
		5725117 4050860
		7055526 7132350
		2571657 2730021
		3373396 4906495
		5504694 1761154
		9576434 3774494
		5652622 3288546
		8761633 850544
		9075606 9113384
		8994222 8800005
		3617876 403122
		1385160 1522296
		8866150 5195154
		8151067 82055
		8950546 3408124
		3155277 9958168
		2263304 4960816
		530142 8399496
		7366965 8144892
		5436674 1735691
		9607133 9254308
		4720820 182584
		1956049 1197612
		9849900 5451452
		7143958 5372394
		4013006 423516
		6468880 3333072
		4381951 1545126
		6126367 9431
		7272050 2351182
		1314707 9615304
		2113644 9706754
		5625033 6512680
		1825721 4698108
		1727793 2660268
		5233744 4489127
		4556821 8777547
		7737337 4428516
		40214 9802379
		1433658 5944457
		7935579 4825098
		5544218 2649993
		3028950 4563763
		3262855 7114217
		3416480 4129482
		6308196 4097249
		901269 7748878
		3573948 3023374
		6831740 4100881
		3655005 6054977
		6640663 3731144
		1797758 6464934
		9604947 2779933
		2371942 877820
		3156241 3054996
		6462472 4308022
		6683269 6762499
		7088285 7369002
		961733 3345796
		9107351 4322500
		941175 5649023
		7580507 195149
		955931 6701787
		3540261 6585328
		8886321 6900621
		4324431 3243396
		5284621 3236324
		2249650 5418718
		2937662 7884438
		9059029 2367829
		4234731 7245324
		8705389 7507343
		7547855 5103688
		331643 5325895
		8644675 4593970
		269247 9351640
		6394 4133197
		3262025 1871363
		5410500 7348385
		1484609 2536525
		1886964 7619147
		6092590 4948990
		8325736 4422087
		1626321 8429592
		3791872 2852116
		3484961 4727017
		7713468 5063731
		3565456 4870132
		4298424 4885409
		7977856 807169
		92420 5381728
		3240036 6170093
		3826527 5946031
		6539027 4367837
		3464487 6783025
		321641 4320320
		5523794 6973603
		8723998 1224612
		4719407 9197418
		1029134 3680259
		8203829 2522841
		6596929 8833414
		3122925 1265467
		3464546 3626480
		875373 5978180
		4274035 5114899
		7888029 4287166
		4332533 3645226
		4464415 8054444
		6717528 4644928
		8424533 6660208
		3453616 3176396
		3958323 7895432
		3238176 8234303
		3020486 780791
		9092733 4151174
		3390539 2732601
		1057106 5212077
		5429588 4936590
		2798497 7612773
		6836275 9028986"
	);

	final manyHorses = parseInput(
		"600
		126072 607519
		426485 810155
		301463 471822
		103306 492315
		256702 276231
		802343 940543
		578188 1426
		720881 180853
		812528 645688
		874256 193238
		97178 234019
		465636 355467
		910739 309637
		91072 980589
		515888 447479
		343123 636232
		800652 129871
		884501 212747
		489382 603550
		330014 392903
		645555 736469
		734983 136530
		153811 69453
		279141 537947
		406891 134672
		947568 341534
		770158 128522
		938310 51677
		916609 384970
		917242 877909
		761071 16453
		544458 285924
		244051 58334
		316476 142043
		472230 470766
		311183 945175
		890483 185134
		947348 429624
		994594 813253
		140352 527959
		177377 714130
		966367 829917
		294974 398734
		57470 926238
		433841 77019
		812281 440792
		719809 858101
		195658 826878
		234065 314396
		445363 720948
		660607 939640
		634546 536834
		987443 360542
		441341 163907
		799418 909858
		38081 862425
		641993 507366
		73888 377820
		888856 413489
		829209 713151
		126022 771877
		766697 85743
		463522 412098
		589537 171790
		423425 876940
		199462 523002
		228372 321676
		478616 875027
		854790 821655
		911686 201365
		124397 751848
		730065 682680
		219515 565580
		464010 34237
		233176 312777
		700809 778629
		943354 180079
		88889 372680
		749183 800606
		524837 542821
		271344 930461
		290709 589015
		222419 698213
		154339 761280
		847836 144152
		40019 462934
		153782 335317
		458801 999839
		733306 393038
		47421 774430
		811738 240440
		96550 257345
		21966 472135
		99641 188547
		831241 186936
		73474 335382
		744606 892203
		593723 728853
		754479 186312
		260033 714083
		667935 120420
		214773 879705
		177896 214254
		650442 107419
		934658 601159
		168573 631793
		581092 768279
		816784 286358
		227780 667962
		502386 591106
		230571 450635
		836064 204604
		288167 818194
		825655 608383
		774949 646074
		949608 939142
		166105 463428
		176833 254278
		278101 21320
		351953 466627
		545668 191499
		873408 864877
		472890 11555
		800289 836682
		844889 780223
		929258 812865
		960463 678964
		185721 874444
		565308 688184
		26803 121573
		928765 329343
		814063 147273
		541180 514535
		90980 532283
		718799 55039
		906561 564299
		321652 967655
		227870 659571
		228262 935916
		749919 642515
		908470 211580
		162928 925177
		709623 974796
		152 169451
		467300 69500
		342022 547754
		993294 969830
		876271 719968
		432487 455180
		543116 984046
		546458 433396
		367476 243495
		633080 576059
		187204 866434
		64231 355703
		121518 728127
		682241 905844
		534217 662486
		482232 80912
		382015 769201
		892618 659798
		602899 994025
		398262 814634
		199039 722600
		407061 522496
		963263 796417
		895675 313831
		149909 6758
		67048 675692
		516021 273187
		672156 123694
		976132 32404
		780433 753032
		995486 906734
		195016 320708
		867577 185365
		795668 208723
		210724 622827
		327717 97176
		606456 265301
		341394 728819
		974354 574757
		502266 679656
		421350 792018
		548283 736695
		259163 912364
		48206 12227
		195484 631045
		434300 748340
		369816 331920
		731352 355298
		623636 461460
		5063 318480
		820235 164672
		904016 451538
		18513 711487
		197704 585107
		166797 255073
		923394 192859
		730147 721159
		479669 967892
		263334 904110
		655869 785746
		560749 56412
		403165 405010
		275967 708824
		952409 257039
		132736 95233
		311421 623306
		324145 216020
		953845 768198
		899015 234035
		694746 328267
		798823 926320
		964716 613333
		372352 321240
		402323 873215
		249520 334145
		420484 964742
		194593 215049
		29987 921112
		229110 369874
		165320 399450
		866662 683715
		324689 847849
		638452 822320
		856278 991188
		316760 219133
		373147 152389
		922614 62847
		814575 284493
		996860 718379
		675180 937039
		936191 666883
		55814 781111
		866509 402844
		941469 600221
		417354 334183
		548381 663544
		448206 790927
		601010 244458
		788528 846201
		972858 356644
		120021 17764
		555280 943877
		436215 667013
		385216 185319
		948817 304280
		674126 938421
		713276 193698
		222647 824913
		661417 917854
		892688 26022
		654042 592730
		33282 460559
		801232 538241
		539117 909373
		795988 620829
		159707 572776
		724286 544866
		699660 20499
		561227 821942
		361032 48784
		851319 375426
		10657 394244
		366929 16360
		19422 882532
		511567 770784
		256268 490794
		5835 53706
		144377 71105
		789003 417402
		546252 477821
		866350 388409
		861687 441227
		13289 226133
		649879 374339
		246276 154454
		453846 46708
		925391 244928
		270066 631274
		355074 65613
		304895 466252
		91701 993125
		656073 177821
		596578 648016
		294974 800710
		840802 826202
		973626 698029
		377459 23851
		288560 419854
		853334 792487
		278067 918645
		996272 708139
		365218 541002
		548239 327028
		769165 987111
		133725 654923
		352832 535237
		577513 42942
		245435 597700
		86939 94927
		40660 451771
		66833 826807
		321402 384129
		168713 543588
		173212 626907
		720873 422191
		22889 238601
		627437 726586
		955794 401329
		549796 694254
		833536 640059
		34092 69372
		338733 907908
		767377 808332
		129919 778554
		329841 827889
		789667 611922
		361399 626751
		213217 247975
		631048 899553
		611887 786615
		943397 730630
		822067 345991
		448132 846780
		121670 389170
		747536 607241
		94316 567894
		190473 689715
		158589 865737
		67369 708514
		434608 710159
		701665 580495
		470248 258794
		994362 282574
		640227 109873
		97722 558308
		486457 616181
		53577 107740
		939438 937779
		365445 202642
		877806 108289
		219581 517200
		304515 135544
		18917 151583
		79670 448445
		839562 392602
		515929 541973
		609241 132610
		655111 181192
		190885 126128
		974688 988207
		35877 365338
		968729 154183
		756719 903106
		186546 658584
		417577 938740
		148454 21613
		816084 41048
		174852 811669
		746676 39860
		723342 940606
		613603 536019
		818008 35063
		672618 716651
		642861 716673
		199460 413529
		253068 567971
		538871 194491
		606777 530376
		11466 958694
		38757 867074
		231998 634135
		764631 34512
		408886 409191
		729145 514152
		492433 618199
		879916 49647
		661574 234568
		873551 767959
		83610 584020
		996486 305529
		348209 696769
		228695 548222
		619404 882582
		493311 676907
		723812 989263
		145911 406256
		909393 136407
		168612 144490
		379472 885964
		679207 84494
		397318 93700
		655532 275277
		436133 496165
		949264 596385
		640139 231702
		38870 361186
		589471 417989
		693922 368422
		803420 949145
		16066 480933
		554371 310418
		737503 877682
		833378 305822
		325465 657278
		845193 662729
		319296 391118
		306699 916750
		451070 970296
		371936 330221
		835799 866929
		956335 789013
		805342 956995
		32668 226400
		571836 813692
		524791 601352
		690240 878645
		338952 414329
		422398 919548
		906014 169658
		341607 469336
		123768 723631
		440078 561574
		502757 616009
		273094 592828
		550340 934690
		282232 884591
		348441 64502
		953243 829438
		965461 517866
		277499 998978
		820784 524079
		572944 390699
		622395 893094
		883076 988712
		709083 986691
		290399 916760
		936088 184000
		762137 843657
		987839 668565
		876827 649959
		727386 480761
		575075 134253
		896486 753019
		128545 197741
		863168 697142
		848709 232115
		828301 955136
		759698 599054
		805699 209769
		964401 146614
		91159 721831
		744767 690597
		847269 601426
		389000 595424
		818600 905230
		241152 832771
		225068 995220
		761815 756057
		181739 302926
		289482 899891
		886483 662767
		346304 255804
		580913 545641
		462952 65214
		406425 817058
		656938 349099
		680459 430926
		516860 318564
		446019 759473
		779708 904127
		990918 951004
		875660 842790
		185880 840453
		18988 774670
		199955 943477
		487225 345053
		367470 14613
		23989 368490
		606667 505569
		172637 189880
		932393 123637
		474784 740149
		823463 55707
		104731 713174
		762262 424060
		740911 334036
		375591 200692
		459709 409841
		690642 292118
		664783 582483
		950387 372345
		603578 782409
		783831 484095
		767700 924148
		826675 534436
		398753 514003
		868639 808165
		727941 449518
		449334 128898
		346059 286270
		423054 572500
		938490 303192
		204826 829679
		313527 1306
		239608 714472
		316175 176695
		200589 603310
		545718 386384
		721464 87029
		304496 710975
		254486 37159
		495978 961249
		277672 980923
		189211 394285
		360104 889485
		778895 129961
		46781 595181
		428724 589040
		609492 339850
		201346 722788
		96864 833339
		690593 650310
		927004 474104
		397951 658296
		325298 499154
		680982 708993
		996240 125058
		70322 521863
		513008 693130
		655637 584296
		446651 308131
		209439 763970
		375635 969922
		708974 462989
		707168 140684
		966560 910183
		997994 606758
		552118 437041
		931317 314407
		30513 644398
		738414 154304
		511266 726551
		51597 902019
		467801 877950
		545976 293906
		904459 431523
		330448 522758
		986856 949383
		646369 908971
		787903 953868
		740965 665495
		498920 913160
		721033 193272
		302210 810125
		132610 274002
		665396 470334
		29436 565246
		494445 415736
		415461 535814
		845146 470151
		405814 134888
		543608 563328
		931102 184279
		485113 68805
		699341 478666
		775231 740289
		769134 522823
		533760 570042
		20706 517871
		714970 135029
		35285 811093
		899200 692004
		108221 367155
		701622 166690
		980465 614581
		322544 505732
		233049 122510
		256738 639633
		459669 212488
		291858 572932
		325829 691752
		491021 171920
		405453 182994
		783253 874099
		425941 935604
		316928 376084
		872766 840763
		683029 962823
		129813 583774
		132455 380839
		740258 288450
		718412 408076
		446149 617938
		942778 673993
		337755 462108
		604317 993509
		353641 72350"
	);

	final mmmaaannnThatSucks = parseInput(
		"20
		4618437 6674593
		3514840 7691515
		2672663 1665342
		5631166 6201289
		9945095 3677291
		1512462 4361
		2505387 5874765
		1291399 7215528
		1660077 787560
		9931494 5381878
		7915213 4933424
		4831249 1702132
		8635501 764174
		4280909 6682870
		5130005 1332040
		2404884 8112820
		6220969 1077590
		1304552 5025490
		8009975 8931210
		4618437 6674593"
	);

	final dontOverflowYourStack = parseInput(
		"20
		0 0
		0 0
		0 0
		0 0
		0 0
		0 0
		0 0
		0 0
		0 0
		0 0
		0 0
		0 0
		0 0
		0 0
		0 0
		0 0
		0 0
		0 0
		0 0
		0 0"
	);
}
