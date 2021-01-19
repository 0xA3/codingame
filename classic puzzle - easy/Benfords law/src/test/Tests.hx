package test;

import Main;
import Std.parseInt;

using buddy.Should;
using StringTools;

@:access(Main)
class Tests extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			
			it( "Regular account", {
				final input = parse( regularAccount );
				Main.process( input.n, input.transactions ).should.be( false );
			});
			
			it( "Fake account (lot's of numbers starting with 1)", {
				final input = parse( fakeAccount1 );
				Main.process( input.n, input.transactions ).should.be( true );
			});
			
			it( "Fake account (equidistributed) 1", {
				final input = parse( fakeAccountEquidistributed1 );
				Main.process( input.n, input.transactions ).should.be( true );
			});
			
			it( '"Adjusted" account', {
				final input = parse( adjustedAccount );
				Main.process( input.n, input.transactions ).should.be( true );
			});
			
			it( "Regular, less transactions", {
				final input = parse( regularLessTransactions );
				Main.process( input.n, input.transactions ).should.be( false );
			});
			
			it( "Fake account (equidistributed) 2", {
				final input = parse( fakeAccountEquidistributed2 );
				Main.process( input.n, input.transactions ).should.be( true );
			});
			
		});

	}

	static function parse( input:String ) {
		final lines = input.split( "\n" );
		final n = parseInt( lines[0] );
		final transactions = [for( i in 0...n ) lines[i + 1].trim() ];
		return { n: n, transactions: transactions};
	}

	static final regularAccount =
	"1000
	1808.13 €
	-54.84 €
	-123.34 €
	-2455.42 €
	291.16 €
	14.29 €
	57.82 €
	892.97 €
	229.93 €
	-8.78 €
	5034.10 €
	-56.35 €
	-1876.12 €
	-0.61 €
	-14.24 €
	8.50 €
	571.58 €
	1036.00 €
	854.65 €
	-82.98 €
	288.58 €
	-6.50 €
	-36.09 €
	-41.41 €
	-45.71 €
	-19.22 €
	-9.76 €
	0.30 €
	-844.25 €
	163.42 €
	0.67 €
	-121.43 €
	13.06 €
	282.67 €
	1175.42 €
	2103.37 €
	2.07 €
	161.96 €
	-249.24 €
	2.18 €
	-2006.31 €
	-3639.75 €
	-35.12 €
	-34.67 €
	45.16 €
	-7.39 €
	-25.35 €
	-128.56 €
	24.69 €
	-327.30 €
	-256.43 €
	16.74 €
	-27.12 €
	17.41 €
	-3.10 €
	-34.43 €
	2127.38 €
	9.17 €
	14.53 €
	67.79 €
	4.96 €
	482.01 €
	-45.86 €
	680.30 €
	-4.84 €
	166.66 €
	-3.58 €
	0.84 €
	284.17 €
	231.61 €
	-5.05 €
	-119.01 €
	-5.18 €
	-3.21 €
	-15.67 €
	155.57 €
	-37.67 €
	116.71 €
	25.63 €
	-17.24 €
	-66.30 €
	-5.43 €
	-27.06 €
	-26.75 €
	-87.23 €
	-50.62 €
	519.04 €
	-1.31 €
	-15.62 €
	11.18 €
	170.76 €
	3318.20 €
	-179.71 €
	1302.45 €
	0.21 €
	323.19 €
	-57.37 €
	2.47 €
	327.85 €
	1.09 €
	-100.25 €
	121.28 €
	131.45 €
	-0.14 €
	-795.08 €
	336.13 €
	-5.78 €
	-28.73 €
	-23.78 €
	0.34 €
	0.99 €
	-7.29 €
	-23.21 €
	-308.76 €
	0.76 €
	-195.52 €
	19.39 €
	-55.17 €
	6.90 €
	29.22 €
	-227.66 €
	1.47 €
	-17.94 €
	0.14 €
	-467.35 €
	-796.61 €
	-69.93 €
	7.91 €
	-3.28 €
	11.52 €
	0.51 €
	1273.92 €
	79.01 €
	-5.73 €
	1.07 €
	207.85 €
	62.71 €
	-3180.01 €
	-46.97 €
	9.15 €
	-827.95 €
	-28.88 €
	-58.60 €
	-63.22 €
	2.85 €
	5259.60 €
	-4.03 €
	2610.42 €
	-1816.81 €
	1.00 €
	-1.16 €
	671.43 €
	-5.53 €
	-102.23 €
	-21.96 €
	7.00 €
	164.42 €
	-16.34 €
	-1276.85 €
	-2.58 €
	1114.43 €
	0.61 €
	5.03 €
	-266.52 €
	-814.93 €
	38.95 €
	19.90 €
	214.44 €
	150.01 €
	78.18 €
	-573.79 €
	1.43 €
	71.98 €
	4.35 €
	-267.04 €
	-136.43 €
	952.80 €
	-1167.48 €
	9.35 €
	-475.18 €
	1.71 €
	-270.14 €
	5.73 €
	2.37 €
	-12.68 €
	57.36 €
	347.10 €
	108.82 €
	42.49 €
	5.91 €
	312.05 €
	-46.81 €
	-9.82 €
	-247.66 €
	-261.80 €
	3587.66 €
	-58.85 €
	1.03 €
	-6.08 €
	84.81 €
	-25.26 €
	-34.49 €
	-203.87 €
	-6.23 €
	0.81 €
	-42.20 €
	-164.10 €
	-1142.11 €
	-963.36 €
	430.95 €
	1.23 €
	1022.04 €
	-9.86 €
	7.47 €
	-664.35 €
	2452.51 €
	11.13 €
	-130.04 €
	-91.15 €
	14.29 €
	-30.55 €
	-12.13 €
	1717.72 €
	0.94 €
	-611.43 €
	78.09 €
	48.47 €
	-3.46 €
	355.08 €
	312.88 €
	0.26 €
	-14.34 €
	-380.76 €
	78.28 €
	-8.02 €
	1569.26 €
	5.85 €
	-1.20 €
	2727.81 €
	-3.70 €
	-42.26 €
	368.12 €
	8.58 €
	-2290.21 €
	-1.29 €
	-2720.38 €
	-5.77 €
	-521.46 €
	128.22 €
	-107.30 €
	-5.39 €
	13.80 €
	-105.88 €
	5.48 €
	248.13 €
	-3914.41 €
	-129.90 €
	62.55 €
	1579.30 €
	-74.28 €
	114.50 €
	0.68 €
	-170.22 €
	1419.46 €
	15.05 €
	-3146.15 €
	92.50 €
	-7.58 €
	14.53 €
	-4409.47 €
	-1482.47 €
	34.06 €
	-92.25 €
	-108.03 €
	84.09 €
	-2195.36 €
	142.28 €
	20.29 €
	-21.86 €
	58.45 €
	855.23 €
	99.69 €
	-5.04 €
	-86.26 €
	350.80 €
	0.25 €
	22.80 €
	-223.84 €
	25.38 €
	-3.77 €
	-12.79 €
	70.11 €
	-261.89 €
	330.03 €
	56.23 €
	23.94 €
	-295.41 €
	-4.27 €
	16.32 €
	-11.11 €
	15.28 €
	80.26 €
	-4386.62 €
	241.13 €
	-27.49 €
	3.41 €
	1237.60 €
	-0.70 €
	271.64 €
	78.13 €
	361.40 €
	70.54 €
	76.60 €
	-11.82 €
	-1.98 €
	8.20 €
	-9.77 €
	269.39 €
	190.93 €
	-1.40 €
	-247.07 €
	154.68 €
	-864.38 €
	-1537.84 €
	31.13 €
	-23.47 €
	-28.56 €
	-5556.28 €
	-8.11 €
	-72.70 €
	-0.54 €
	3.82 €
	13.70 €
	28.13 €
	12.08 €
	0.45 €
	42.54 €
	951.28 €
	64.41 €
	1623.34 €
	-194.44 €
	-1079.70 €
	-10.38 €
	16.48 €
	26.44 €
	294.69 €
	-6.64 €
	-26.96 €
	1.08 €
	677.92 €
	7.57 €
	1661.78 €
	215.61 €
	8.16 €
	139.91 €
	0.54 €
	-1809.90 €
	6.37 €
	43.75 €
	171.60 €
	3932.52 €
	-4.08 €
	1158.66 €
	-6.98 €
	2668.96 €
	27.13 €
	-75.39 €
	4.05 €
	1640.05 €
	-27.18 €
	0.69 €
	3856.95 €
	22.17 €
	411.90 €
	2274.61 €
	41.37 €
	8.80 €
	80.49 €
	39.26 €
	3.00 €
	2.07 €
	-403.89 €
	15.63 €
	-18.53 €
	148.12 €
	456.87 €
	8.36 €
	4.51 €
	73.14 €
	-747.95 €
	200.73 €
	656.81 €
	-2.77 €
	40.86 €
	6.48 €
	-660.70 €
	-46.31 €
	10.51 €
	-67.30 €
	-30.97 €
	1608.65 €
	-45.58 €
	22.66 €
	-1040.14 €
	2.24 €
	7084.39 €
	10.64 €
	-3809.63 €
	-7.41 €
	-56.38 €
	-941.35 €
	2477.50 €
	-153.48 €
	-99.72 €
	-0.01 €
	640.81 €
	53.77 €
	184.19 €
	-148.95 €
	-1.65 €
	7.62 €
	114.18 €
	-559.86 €
	3451.30 €
	-2.16 €
	-84.96 €
	5612.52 €
	184.73 €
	1079.94 €
	-25.25 €
	-3213.08 €
	-174.97 €
	19.95 €
	-326.95 €
	0.66 €
	30.29 €
	16.52 €
	-428.81 €
	222.44 €
	422.46 €
	-5.78 €
	337.29 €
	-143.89 €
	-135.71 €
	59.44 €
	-19.35 €
	-4.48 €
	4732.11 €
	34.54 €
	-302.17 €
	9.85 €
	-524.06 €
	95.19 €
	232.77 €
	86.58 €
	42.76 €
	77.79 €
	-14.26 €
	-36.30 €
	-3054.99 €
	-30.02 €
	-6.13 €
	100.77 €
	-15.76 €
	-44.71 €
	2.97 €
	-131.64 €
	-1.47 €
	150.26 €
	-0.07 €
	14.18 €
	1772.02 €
	6.39 €
	169.37 €
	51.33 €
	1960.90 €
	8.16 €
	-40.55 €
	14.54 €
	3.51 €
	103.33 €
	0.54 €
	-54.41 €
	-113.39 €
	-23.31 €
	3201.98 €
	126.36 €
	-8.94 €
	-89.27 €
	-66.54 €
	-3820.87 €
	5.41 €
	61.66 €
	-838.68 €
	-7173.88 €
	-176.80 €
	756.36 €
	-513.18 €
	8.05 €
	249.85 €
	5.57 €
	-94.99 €
	874.66 €
	6.09 €
	70.17 €
	-7.78 €
	21.51 €
	1.57 €
	36.81 €
	-4398.23 €
	-0.01 €
	-5266.53 €
	-146.59 €
	19.46 €
	14.41 €
	81.36 €
	14.09 €
	53.86 €
	272.22 €
	-27.75 €
	932.52 €
	0.08 €
	-0.64 €
	-23.23 €
	-34.99 €
	37.49 €
	84.08 €
	-2113.38 €
	-1.79 €
	-435.09 €
	-8.02 €
	0.49 €
	-45.39 €
	2022.53 €
	1694.70 €
	-58.46 €
	225.83 €
	-479.98 €
	-1142.31 €
	-10.68 €
	-1914.47 €
	-5820.09 €
	26.23 €
	-735.83 €
	5927.91 €
	210.55 €
	-3010.30 €
	284.00 €
	-17.33 €
	-2.51 €
	12.40 €
	-2718.20 €
	-8.27 €
	-1742.09 €
	24.90 €
	-316.81 €
	0.84 €
	1.57 €
	-172.84 €
	-18.70 €
	44.47 €
	4.12 €
	2.94 €
	-51.08 €
	24.09 €
	2837.62 €
	30.79 €
	-1.03 €
	-3.90 €
	1.95 €
	-772.44 €
	0.42 €
	-1655.97 €
	135.55 €
	131.74 €
	81.81 €
	-57.09 €
	19.51 €
	-295.37 €
	18.87 €
	-3084.44 €
	14.78 €
	37.54 €
	-334.53 €
	1004.23 €
	2439.70 €
	3406.62 €
	6.22 €
	6.34 €
	-5.93 €
	-855.79 €
	127.32 €
	63.33 €
	-1.02 €
	-5.59 €
	10.54 €
	303.02 €
	-33.96 €
	-50.36 €
	-4.84 €
	8.87 €
	403.14 €
	-338.54 €
	3074.96 €
	552.32 €
	65.18 €
	4.15 €
	958.08 €
	388.04 €
	-5.25 €
	13.28 €
	-1774.61 €
	-920.05 €
	-9.86 €
	11.56 €
	53.84 €
	0.07 €
	-119.14 €
	-0.21 €
	7188.49 €
	1859.66 €
	488.78 €
	5358.34 €
	165.10 €
	558.75 €
	-6422.83 €
	-40.39 €
	1102.23 €
	-535.75 €
	-30.28 €
	-153.88 €
	-390.86 €
	76.35 €
	4.49 €
	-3.52 €
	29.74 €
	-5.84 €
	-263.23 €
	546.69 €
	28.25 €
	-765.89 €
	606.73 €
	-14.39 €
	-3.20 €
	341.84 €
	-546.27 €
	105.58 €
	630.06 €
	-287.82 €
	-661.14 €
	266.63 €
	60.57 €
	-2.24 €
	1015.27 €
	-1.65 €
	7.50 €
	421.54 €
	-36.97 €
	-93.66 €
	-5.90 €
	98.20 €
	146.33 €
	-179.24 €
	-203.68 €
	196.38 €
	26.78 €
	379.18 €
	1703.90 €
	104.48 €
	-7.28 €
	15.59 €
	30.11 €
	7.31 €
	-1815.90 €
	-4916.38 €
	-5.71 €
	1.64 €
	6.46 €
	-1231.98 €
	62.42 €
	5991.44 €
	8.88 €
	10.86 €
	237.26 €
	-8.06 €
	-1610.05 €
	-2.17 €
	-216.95 €
	-155.87 €
	95.99 €
	-68.15 €
	-710.26 €
	4032.21 €
	238.66 €
	-6.56 €
	5435.96 €
	-2580.52 €
	-481.60 €
	-41.78 €
	1774.35 €
	76.66 €
	-3.56 €
	-705.50 €
	-1568.47 €
	9.37 €
	2.12 €
	7.50 €
	18.36 €
	63.70 €
	-70.84 €
	-149.72 €
	-257.72 €
	330.28 €
	-5.18 €
	-572.05 €
	-102.97 €
	-15.15 €
	1067.69 €
	-1.52 €
	8.60 €
	1331.21 €
	-25.26 €
	506.89 €
	235.36 €
	19.43 €
	-262.12 €
	-1.84 €
	-5.46 €
	0.63 €
	250.80 €
	25.62 €
	21.70 €
	-81.03 €
	-62.96 €
	-0.49 €
	-152.38 €
	-12.67 €
	39.65 €
	274.03 €
	-523.73 €
	0.23 €
	-5.21 €
	7.31 €
	755.78 €
	689.33 €
	94.47 €
	421.00 €
	-662.89 €
	-381.57 €
	5.15 €
	-44.86 €
	1.46 €
	293.06 €
	127.66 €
	240.88 €
	33.55 €
	2625.32 €
	9.24 €
	204.07 €
	-69.40 €
	10.62 €
	-1.34 €
	-1909.49 €
	-147.22 €
	13.43 €
	202.95 €
	4.20 €
	-2.51 €
	19.10 €
	-12.17 €
	-26.03 €
	-3.49 €
	59.69 €
	-17.19 €
	-13.24 €
	3.01 €
	0.03 €
	3633.83 €
	-5.16 €
	-290.11 €
	-2209.62 €
	11.35 €
	-2983.25 €
	11.75 €
	107.49 €
	-93.16 €
	-172.05 €
	13.14 €
	-2.83 €
	-27.70 €
	578.16 €
	-93.73 €
	736.85 €
	-36.98 €
	4450.10 €
	28.42 €
	-883.22 €
	404.14 €
	-11.20 €
	286.25 €
	1.93 €
	33.46 €
	8.01 €
	17.26 €
	9.98 €
	-0.33 €
	-17.66 €
	-9.35 €
	-0.74 €
	176.41 €
	-364.61 €
	24.92 €
	-15.06 €
	-0.42 €
	1.79 €
	3.82 €
	410.94 €
	46.22 €
	531.08 €
	-0.51 €
	358.36 €
	777.18 €
	-15.98 €
	152.50 €
	1141.59 €
	3.50 €
	0.97 €
	9.69 €
	549.92 €
	188.39 €
	1519.28 €
	6.57 €
	0.52 €
	-717.88 €
	-4.30 €
	26.52 €
	-1942.86 €
	-1.53 €
	19.50 €
	-368.66 €
	2.38 €
	10.53 €
	2435.23 €
	104.51 €
	1.29 €
	-399.54 €
	4.92 €
	-11.41 €
	40.60 €
	-11.85 €
	137.41 €
	8.47 €
	5.10 €
	-3253.78 €
	-16.41 €
	-663.09 €
	130.99 €
	45.19 €
	244.30 €
	-13.82 €
	-1.55 €
	1.53 €
	579.98 €
	-59.41 €
	1.96 €
	4.09 €
	252.89 €
	0.48 €
	0.98 €
	108.37 €
	17.20 €
	-67.48 €
	-711.08 €
	12.08 €
	-40.98 €
	0.26 €
	-206.06 €
	10.06 €
	38.05 €
	458.72 €
	39.41 €
	-3.61 €
	78.27 €
	-0.90 €
	126.88 €
	1.15 €
	1.69 €
	-262.26 €
	747.26 €
	-657.02 €
	-271.03 €
	6.67 €
	48.52 €
	201.08 €
	1.35 €
	-5.44 €
	-2.22 €
	266.40 €
	2894.39 €
	58.13 €
	-23.80 €
	-314.31 €
	103.50 €
	-0.85 €
	-37.64 €
	24.56 €
	-35.82 €
	30.23 €
	-142.13 €
	-1.71 €
	2.35 €
	-68.65 €
	66.00 €
	-54.73 €
	-85.78 €
	-325.33 €
	14.50 €
	32.78 €
	-4449.51 €
	104.72 €
	123.93 €
	-0.41 €
	17.05 €
	-371.42 €
	-1.56 €
	125.63 €
	1934.84 €
	0.18 €
	0.70 €
	-228.71 €
	38.58 €
	3.94 €
	-3.13 €
	222.60 €
	1.69 €
	7.84 €
	-4.85 €
	3.67 €
	-106.22 €
	623.01 €
	0.88 €
	20.35 €
	6.64 €
	-86.54 €
	-2.35 €
	-12.71 €
	0.14 €
	345.45 €
	-614.32 €
	26.60 €
	127.15 €
	-17.08 €
	16.59 €
	-249.49 €
	33.63 €
	8.74 €
	186.50 €
	-20.36 €
	-2.10 €
	977.44 €
	161.15 €
	285.61 €
	2.03 €
	-10.94 €
	-221.93 €
	-3.55 €
	-14.42 €
	-718.92 €
	30.07 €
	6975.10 €
	0.64 €
	496.83 €
	1.13 €
	180.22 €
	101.11 €
	0.39 €
	38.51 €
	35.20 €
	-3379.57 €
	-3723.75 €
	131.39 €
	-714.39 €
	-25.60 €
	272.23 €
	-340.31 €
	-34.87 €
	41.56 €
	98.03 €
	24.24 €
	-62.79 €
	7.15 €
	0.42 €
	1.86 €
	567.37 €
	1736.73 €
	608.51 €
	-372.28 €
	-0.69 €
	0.60 €
	18.25 €";

	static final fakeAccount1 =
	"500
	-1405,68
	-161,99
	-115,71
	-76,59
	+189,54
	+619,78
	+1651,33
	+974,28
	-338,87
	+99,71
	+737,65
	+70,10
	-64,37
	-208,24
	+23,41
	+72,32
	+128,74
	+171,36
	+126,11
	+162,64
	-17,71
	+44,54
	-945,15
	-1697,81
	+126,77
	-572,51
	-195,91
	+0,52
	-1368,83
	-60,61
	+45,94
	-82,99
	+1820,60
	+1419,92
	+1467,95
	-506,43
	+1650,98
	-634,81
	-1947,88
	+1331,11
	+17,41
	+538,43
	-17,53
	-195,56
	+61,31
	+64,37
	+1616,82
	+50,04
	+30,34
	+929,46
	+74,65
	+1332,63
	+380,37
	+608,28
	+472,33
	+613,29
	+1111,93
	-111,64
	-1476,75
	+16,91
	+274,49
	+1732,37
	-51,61
	+60,87
	+1217,82
	+195,35
	+97,72
	+1505,54
	-197,03
	-176,06
	+178,97
	+77,97
	-20,45
	+29,98
	-926,60
	+146,55
	+4,28
	+1720,62
	-94,68
	+27,24
	+343,41
	-615,18
	-83,96
	-209,30
	+148,52
	+123,48
	-352,25
	-14,89
	-75,81
	+380,23
	-83,99
	+90,90
	-149,10
	+74,48
	+140,50
	+10,76
	-4,28
	-3,84
	+158,72
	-65,73
	-840,76
	+120,53
	-68,41
	+166,05
	+479,41
	-64,31
	-34,55
	+149,11
	+126,48
	+954,89
	+139,13
	+692,20
	+605,84
	+1453,08
	+305,37
	+96,04
	+34,88
	-60,14
	-1977,18
	+194,79
	+1723,91
	+28,57
	+43,67
	-129,25
	-28,67
	-75,40
	+40,26
	+93,39
	+938,21
	-1972,73
	-67,61
	-118,75
	-10,11
	+1502,65
	-158,56
	+544,00
	+1515,88
	+1495,54
	+1174,38
	+128,95
	+118,94
	-7,08
	-551,30
	+13,42
	+885,39
	-182,40
	-7,19
	-401,93
	+1440,73
	+164,54
	-119,55
	-1429,88
	-16,71
	-841,47
	-11,36
	-14,25
	+768,49
	-528,26
	+709,48
	+188,74
	-253,44
	-884,09
	-1763,98
	-84,97
	+26,73
	-2,49
	-141,48
	+161,87
	-18,17
	+1342,33
	+1204,25
	-93,77
	+83,28
	+149,97
	-171,35
	-167,38
	+1274,64
	+18,59
	-93,79
	+99,67
	+595,41
	+1566,74
	-155,29
	+1747,42
	-170,51
	+160,64
	-400,53
	-1791,54
	-1872,41
	+331,73
	+127,43
	-96,69
	+1474,28
	+58,70
	-166,83
	-26,93
	-939,71
	-106,83
	+1290,61
	+525,54
	+7,27
	-1421,71
	-21,47
	+15,87
	-200,70
	+878,43
	-151,64
	+483,43
	+319,13
	-61,38
	-93,81
	+24,94
	-91,75
	+866,83
	-79,47
	+37,85
	-180,92
	+92,37
	+1119,22
	-116,97
	+11,27
	-196,71
	+699,96
	+883,41
	+154,91
	+12,97
	+159,59
	+811,40
	-61,41
	-11,24
	+16,11
	-180,59
	-89,58
	+32,08
	-320,12
	+57,52
	+729,42
	+1435,56
	-587,03
	-19,50
	-158,88
	-32,42
	-1928,22
	+754,47
	-159,63
	-41,48
	-131,01
	+547,68
	+791,77
	-945,20
	+1383,77
	+1894,12
	-29,17
	-613,89
	-149,88
	-694,78
	+26,43
	+37,21
	-111,65
	-1473,41
	+186,83
	-1127,07
	-1596,50
	+12,42
	-165,00
	-131,65
	-82,53
	-1869,62
	+235,04
	-620,48
	-97,79
	+43,73
	+84,95
	+16,58
	-271,91
	-103,80
	+648,84
	+72,98
	+715,39
	+1910,42
	+447,82
	+196,20
	-83,33
	+94,64
	-118,23
	+1198,63
	+597,55
	+10,54
	+935,87
	+170,25
	+20,85
	+173,44
	+169,18
	-166,33
	+322,90
	+83,82
	-38,28
	-978,99
	-1727,96
	+68,08
	+1382,84
	-582,07
	+195,29
	+138,86
	-11,79
	+114,87
	+4,89
	+31,94
	-290,36
	-310,57
	-130,36
	-182,44
	+95,50
	+1821,14
	-301,06
	-808,68
	+264,55
	+165,86
	+85,12
	-147,45
	+213,18
	+11,29
	+1373,34
	+784,38
	-131,55
	-126,54
	-16,96
	+1527,19
	+44,72
	+36,15
	-71,37
	-436,40
	-182,78
	-328,24
	-1579,03
	-152,43
	-145,57
	+198,44
	+965,57
	-4,64
	+55,27
	-159,96
	-121,98
	+248,04
	+69,27
	-560,77
	+72,80
	+94,61
	-1376,76
	+190,86
	+180,69
	+30,74
	-76,45
	+215,27
	-178,56
	+177,41
	-545,18
	-179,61
	+329,75
	+1626,23
	+33,79
	-284,29
	+126,16
	-40,98
	-70,96
	-636,95
	+18,68
	-1438,66
	-1621,75
	-110,91
	-353,30
	-3,02
	+1165,78
	+132,75
	-1106,33
	-44,45
	-1878,87
	+272,22
	+2,25
	+980,56
	+1826,89
	+1720,05
	-1538,98
	-1124,43
	+130,64
	-87,99
	+53,17
	+187,57
	+34,15
	+776,08
	-58,89
	+608,77
	+36,17
	+97,62
	-24,74
	+1736,27
	+105,23
	-13,59
	-490,90
	-164,20
	-82,87
	-750,54
	-1787,56
	+223,43
	+1145,11
	+188,79
	+150,29
	-1805,40
	-15,18
	+98,70
	-192,57
	+261,11
	-1122,92
	+157,14
	+174,41
	-66,57
	+47,84
	+62,14
	+485,46
	+381,31
	+187,87
	+18,73
	-41,07
	-91,56
	+17,22
	-551,06
	-362,57
	+65,38
	-54,54
	+43,90
	+748,20
	-1224,77
	+710,88
	-247,53
	-16,27
	+19,27
	+1682,01
	+759,23
	+39,68
	-955,26
	+973,31
	+142,97
	+200,40
	+135,62
	+125,32
	-1358,35
	+178,99
	-1355,28
	-998,73
	-74,27
	+466,12
	+76,74
	+126,12
	+80,57
	+167,35
	+54,70
	-429,54
	+196,06
	+76,06
	+516,37
	+35,70
	+888,41
	-255,83
	+74,81
	-137,42
	-379,48
	+1162,34
	+19,62
	-1347,55
	-147,13
	-59,59
	+503,44
	+1621,98
	+140,13
	+83,69
	-98,89
	+81,89
	+599,54
	-3,10
	+13,86
	-1884,76
	+39,20
	-361,25
	+95,28
	+7,84
	+521,56
	+3,00
	-858,19
	+862,45
	+108,15
	-23,18
	-177,23
	+779,93
	+804,41
	+4,31
	-148,97
	-193,17
	+362,73
	+1469,96
	-1161,07";

	static final fakeAccountEquidistributed1 =
	"600
	522.88 $
	21.33 $
	407.20 $
	36.02 $
	494.54 $
	230.11 $
	65.42 $
	18.75 $
	654.82 $
	306.13 $
	618.06 $
	766.44 $
	10.90 $
	449.36 $
	961.25 $
	375.62 $
	324.38 $
	982.12 $
	409.94 $
	23.97 $
	947.49 $
	97.81 $
	96.48 $
	78.75 $
	92.37 $
	617.30 $
	366.20 $
	871.35 $
	87.09 $
	855.34 $
	113.04 $
	404.52 $
	62.48 $
	653.87 $
	340.64 $
	700.57 $
	69.87 $
	25.45 $
	63.45 $
	67.18 $
	56.23 $
	232.05 $
	70.68 $
	188.28 $
	3.07 $
	16.39 $
	241.12 $
	88.60 $
	86.86 $
	670.10 $
	556.42 $
	48.33 $
	174.85 $
	570.73 $
	920.23 $
	26.05 $
	0.26 $
	83.70 $
	21.21 $
	21.23 $
	48.19 $
	91.01 $
	49.59 $
	619.47 $
	459.99 $
	81.99 $
	456.92 $
	96.01 $
	70.16 $
	649.32 $
	643.01 $
	84.49 $
	92.22 $
	491.24 $
	704.23 $
	259.07 $
	30.48 $
	99.60 $
	12.64 $
	61.70 $
	18.12 $
	6.34 $
	71.61 $
	45.04 $
	974.73 $
	72.40 $
	73.84 $
	288.92 $
	85.70 $
	64.96 $
	0.02 $
	14.86 $
	119.12 $
	616.32 $
	457.90 $
	313.12 $
	93.90 $
	831.64 $
	96.89 $
	642.41 $
	20.43 $
	80.44 $
	29.20 $
	620.29 $
	2.07 $
	821.15 $
	77.53 $
	91.45 $
	68.09 $
	907.04 $
	15.64 $
	832.21 $
	63.88 $
	169.12 $
	988.27 $
	619.93 $
	48.73 $
	839.23 $
	37.74 $
	35.82 $
	751.02 $
	291.74 $
	993.67 $
	983.25 $
	83.21 $
	355.19 $
	56.26 $
	237.12 $
	344.16 $
	25.81 $
	751.37 $
	58.66 $
	1.76 $
	88.17 $
	13.86 $
	577.29 $
	76.85 $
	632.33 $
	12.60 $
	72.49 $
	84.91 $
	453.83 $
	67.74 $
	83.00 $
	37.78 $
	59.52 $
	309.86 $
	50.53 $
	985.96 $
	656.78 $
	616.37 $
	990.97 $
	404.27 $
	249.11 $
	4.29 $
	892.05 $
	65.81 $
	40.36 $
	73.06 $
	8.40 $
	35.64 $
	785.49 $
	68.70 $
	143.91 $
	915.74 $
	95.91 $
	40.23 $
	863.46 $
	22.91 $
	37.66 $
	14.01 $
	62.08 $
	70.22 $
	71.88 $
	128.33 $
	70.63 $
	894.07 $
	68.27 $
	1.35 $
	995.29 $
	27.02 $
	93.50 $
	663.42 $
	70.76 $
	453.13 $
	84.91 $
	476.53 $
	384.36 $
	583.44 $
	647.07 $
	232.28 $
	5.14 $
	90.19 $
	338.64 $
	660.11 $
	69.19 $
	140.58 $
	896.65 $
	593.95 $
	20.79 $
	186.43 $
	425.15 $
	46.45 $
	209.69 $
	12.31 $
	858.14 $
	79.96 $
	457.37 $
	624.92 $
	45.04 $
	394.89 $
	98.32 $
	362.11 $
	265.42 $
	716.34 $
	752.55 $
	453.87 $
	65.35 $
	97.49 $
	28.37 $
	223.61 $
	22.81 $
	405.75 $
	809.77 $
	738.36 $
	115.70 $
	571.59 $
	31.41 $
	611.95 $
	80.60 $
	62.80 $
	19.46 $
	15.94 $
	67.03 $
	48.98 $
	29.29 $
	15.58 $
	71.91 $
	99.10 $
	38.17 $
	30.90 $
	876.65 $
	472.81 $
	62.64 $
	836.13 $
	372.54 $
	826.33 $
	772.36 $
	90.93 $
	284.67 $
	7.39 $
	581.49 $
	601.80 $
	635.66 $
	11.98 $
	890.09 $
	27.49 $
	354.25 $
	515.81 $
	22.56 $
	92.13 $
	775.53 $
	95.73 $
	75.64 $
	70.82 $
	97.96 $
	415.39 $
	95.40 $
	351.65 $
	50.09 $
	64.93 $
	162.53 $
	37.34 $
	709.86 $
	7.95 $
	568.62 $
	90.47 $
	9.50 $
	952.25 $
	968.53 $
	63.05 $
	84.51 $
	16.27 $
	171.36 $
	445.57 $
	21.84 $
	744.68 $
	5.32 $
	710.54 $
	54.42 $
	683.44 $
	4.37 $
	66.84 $
	694.79 $
	70.49 $
	88.88 $
	29.62 $
	48.89 $
	657.38 $
	64.12 $
	74.65 $
	7.11 $
	47.16 $
	710.08 $
	59.65 $
	528.71 $
	705.53 $
	32.86 $
	73.19 $
	522.92 $
	76.55 $
	6.94 $
	470.73 $
	30.67 $
	779.77 $
	53.73 $
	45.17 $
	35.06 $
	28.26 $
	146.29 $
	728.64 $
	53.12 $
	547.48 $
	3.89 $
	778.73 $
	476.45 $
	281.01 $
	7.37 $
	249.91 $
	695.15 $
	828.41 $
	899.04 $
	24.21 $
	16.83 $
	418.08 $
	88.87 $
	37.16 $
	334.88 $
	43.64 $
	65.26 $
	34.34 $
	782.48 $
	856.21 $
	864.82 $
	55.38 $
	591.20 $
	71.77 $
	123.67 $
	25.01 $
	57.42 $
	13.98 $
	31.93 $
	49.64 $
	54.54 $
	36.77 $
	70.34 $
	1.96 $
	48.38 $
	43.32 $
	813.84 $
	5.89 $
	81.04 $
	9.34 $
	692.23 $
	573.32 $
	544.83 $
	168.76 $
	38.69 $
	728.90 $
	251.87 $
	10.60 $
	697.25 $
	12.79 $
	562.06 $
	199.63 $
	96.77 $
	86.09 $
	161.60 $
	253.78 $
	76.24 $
	15.16 $
	23.40 $
	635.65 $
	86.69 $
	670.75 $
	42.81 $
	948.70 $
	1.50 $
	259.09 $
	63.04 $
	37.43 $
	383.52 $
	51.53 $
	38.08 $
	43.29 $
	40.44 $
	86.97 $
	124.62 $
	859.68 $
	626.29 $
	61.19 $
	39.14 $
	660.28 $
	15.31 $
	60.91 $
	658.64 $
	422.45 $
	319.52 $
	62.20 $
	63.13 $
	25.43 $
	143.99 $
	0.56 $
	96.76 $
	652.62 $
	793.98 $
	72.37 $
	59.92 $
	338.42 $
	484.98 $
	660.73 $
	968.84 $
	124.93 $
	20.42 $
	246.17 $
	842.27 $
	682.71 $
	9.25 $
	68.68 $
	631.79 $
	9.02 $
	12.65 $
	70.67 $
	34.96 $
	19.59 $
	10.34 $
	846.85 $
	78.36 $
	18.96 $
	594.33 $
	65.38 $
	979.94 $
	45.65 $
	491.91 $
	93.05 $
	32.80 $
	655.74 $
	29.37 $
	51.97 $
	531.31 $
	221.86 $
	775.29 $
	49.53 $
	516.03 $
	22.83 $
	127.74 $
	78.08 $
	6.01 $
	174.98 $
	663.89 $
	85.62 $
	4.92 $
	51.28 $
	3.86 $
	26.64 $
	35.50 $
	532.01 $
	480.82 $
	86.20 $
	958.92 $
	84.23 $
	72.53 $
	53.38 $
	89.74 $
	84.88 $
	67.23 $
	9.24 $
	36.55 $
	865.45 $
	85.19 $
	83.45 $
	65.20 $
	43.33 $
	577.16 $
	21.90 $
	617.84 $
	91.18 $
	77.36 $
	65.93 $
	65.60 $
	737.25 $
	722.62 $
	63.73 $
	169.79 $
	60.89 $
	38.35 $
	83.78 $
	293.48 $
	50.28 $
	58.87 $
	92.61 $
	874.26 $
	32.88 $
	298.39 $
	88.77 $
	445.90 $
	830.95 $
	22.96 $
	349.13 $
	60.55 $
	149.21 $
	62.50 $
	733.08 $
	17.76 $
	32.82 $
	33.52 $
	10.31 $
	72.47 $
	911.15 $
	15.23 $
	8.74 $
	96.84 $
	554.03 $
	267.40 $
	182.33 $
	29.74 $
	239.69 $
	544.87 $
	401.59 $
	24.92 $
	54.09 $
	68.23 $
	63.89 $
	624.32 $
	526.50 $
	3.69 $
	903.49 $
	65.26 $
	746.06 $
	113.80 $
	38.99 $
	47.57 $
	24.25 $
	64.22 $
	17.12 $
	47.32 $
	38.15 $
	91.88 $
	82.23 $
	44.62 $
	13.25 $
	93.10 $
	808.48 $
	36.57 $
	98.40 $
	6.53 $
	726.77 $
	947.32 $
	99.28 $
	64.20 $
	24.94 $
	638.18 $
	19.10 $
	81.78 $
	138.44 $
	16.24 $
	3.59 $
	850.89 $
	55.58 $
	58.01 $
	783.71 $
	345.29 $
	733.62 $
	731.75 $
	52.06 $
	904.34 $
	74.91 $
	7.08 $
	688.63 $
	869.91 $
	72.95 $
	55.05 $
	506.64 $
	8.09 $
	726.36 $
	573.37 $
	68.20 $
	22.76 $
	581.05 $
	99.83 $
	52.54 $
	57.85 $
	93.64 $
	43.01 $
	494.41 $
	661.77 $
	959.61 $
	360.53 $
	12.74 $
	56.38 $";

	static final adjustedAccount =
	"1000
	438.32 ₿
	13.70 ₿
	400.00 ₿
	90.35 ₿
	0.47 ₿
	659.79 ₿
	6.16 ₿
	30.15 ₿
	400.00 ₿
	1.62 ₿
	23.07 ₿
	20.16 ₿
	111.83 ₿
	500.00 ₿
	545.49 ₿
	500.00 ₿
	10.13 ₿
	611.23 ₿
	500.00 ₿
	400.00 ₿
	363.60 ₿
	910.28 ₿
	400.00 ₿
	78.14 ₿
	3461.65 ₿
	11.92 ₿
	500.00 ₿
	135.22 ₿
	500.00 ₿
	5.77 ₿
	500.00 ₿
	400.00 ₿
	221.81 ₿
	500.00 ₿
	372.49 ₿
	88.31 ₿
	400.00 ₿
	11.73 ₿
	500.00 ₿
	7.52 ₿
	500.00 ₿
	2655.55 ₿
	476.70 ₿
	20.24 ₿
	221.69 ₿
	500.00 ₿
	23.33 ₿
	111.36 ₿
	51.77 ₿
	6.55 ₿
	400.00 ₿
	400.00 ₿
	133.86 ₿
	400.00 ₿
	1224.02 ₿
	400.00 ₿
	1473.26 ₿
	34.68 ₿
	127.45 ₿
	1.47 ₿
	86.22 ₿
	28.97 ₿
	400.00 ₿
	13.28 ₿
	13.54 ₿
	400.00 ₿
	227.49 ₿
	500.00 ₿
	128.78 ₿
	6.93 ₿
	500.00 ₿
	1119.42 ₿
	1822.75 ₿
	400.00 ₿
	467.38 ₿
	251.07 ₿
	500.00 ₿
	500.00 ₿
	400.00 ₿
	26.76 ₿
	5570.62 ₿
	827.52 ₿
	20.35 ₿
	61.30 ₿
	1240.47 ₿
	2.77 ₿
	500.00 ₿
	203.06 ₿
	17.45 ₿
	400.00 ₿
	500.00 ₿
	500.00 ₿
	400.00 ₿
	400.00 ₿
	0.04 ₿
	340.97 ₿
	500.00 ₿
	75.13 ₿
	114.32 ₿
	500.00 ₿
	58.11 ₿
	500.00 ₿
	0.26 ₿
	400.00 ₿
	400.00 ₿
	16.41 ₿
	23.51 ₿
	400.00 ₿
	500.00 ₿
	3020.42 ₿
	1350.22 ₿
	400.00 ₿
	500.00 ₿
	500.00 ₿
	729.61 ₿
	54.89 ₿
	0.18 ₿
	12.10 ₿
	30.01 ₿
	400.00 ₿
	500.00 ₿
	1575.38 ₿
	0.14 ₿
	500.00 ₿
	500.00 ₿
	500.00 ₿
	704.19 ₿
	500.00 ₿
	986.25 ₿
	479.64 ₿
	98.22 ₿
	500.00 ₿
	70.82 ₿
	400.00 ₿
	400.00 ₿
	222.45 ₿
	86.60 ₿
	59.87 ₿
	400.00 ₿
	500.00 ₿
	500.00 ₿
	500.00 ₿
	500.00 ₿
	62.71 ₿
	11.00 ₿
	232.90 ₿
	98.49 ₿
	85.10 ₿
	41.94 ₿
	131.84 ₿
	15.80 ₿
	1078.13 ₿
	13.81 ₿
	400.00 ₿
	575.71 ₿
	33.78 ₿
	160.51 ₿
	4.15 ₿
	500.00 ₿
	134.60 ₿
	18.83 ₿
	20.02 ₿
	79.41 ₿
	294.91 ₿
	21.88 ₿
	13.31 ₿
	8.68 ₿
	400.00 ₿
	15.54 ₿
	500.00 ₿
	1.93 ₿
	400.00 ₿
	128.91 ₿
	400.00 ₿
	436.33 ₿
	400.00 ₿
	109.87 ₿
	27.06 ₿
	6.80 ₿
	259.58 ₿
	110.76 ₿
	500.00 ₿
	280.34 ₿
	3.58 ₿
	400.00 ₿
	26.43 ₿
	0.77 ₿
	252.70 ₿
	0.69 ₿
	44.70 ₿
	500.00 ₿
	18.73 ₿
	1607.06 ₿
	61.44 ₿
	500.00 ₿
	211.59 ₿
	3.54 ₿
	23.76 ₿
	500.00 ₿
	500.00 ₿
	500.00 ₿
	42.60 ₿
	400.00 ₿
	11.44 ₿
	1198.02 ₿
	400.00 ₿
	3.44 ₿
	1886.28 ₿
	500.00 ₿
	40.81 ₿
	500.00 ₿
	52.46 ₿
	614.10 ₿
	1506.46 ₿
	38.28 ₿
	500.00 ₿
	6.22 ₿
	2.31 ₿
	400.00 ₿
	1.36 ₿
	3.67 ₿
	320.56 ₿
	23.69 ₿
	176.59 ₿
	1.17 ₿
	400.00 ₿
	400.00 ₿
	500.00 ₿
	202.61 ₿
	400.00 ₿
	400.00 ₿
	2.21 ₿
	500.00 ₿
	500.00 ₿
	100.72 ₿
	16.67 ₿
	400.00 ₿
	500.00 ₿
	132.13 ₿
	2158.50 ₿
	16.17 ₿
	10.78 ₿
	30.73 ₿
	500.00 ₿
	183.66 ₿
	500.00 ₿
	31.61 ₿
	5.91 ₿
	500.00 ₿
	17.86 ₿
	500.00 ₿
	282.61 ₿
	135.95 ₿
	371.63 ₿
	190.84 ₿
	500.00 ₿
	134.37 ₿
	500.00 ₿
	499.03 ₿
	400.00 ₿
	96.25 ₿
	500.00 ₿
	555.67 ₿
	400.00 ₿
	400.00 ₿
	400.00 ₿
	1703.87 ₿
	41.88 ₿
	500.00 ₿
	284.20 ₿
	500.00 ₿
	400.00 ₿
	1308.99 ₿
	1738.01 ₿
	240.79 ₿
	400.00 ₿
	0.18 ₿
	22.67 ₿
	400.00 ₿
	80.45 ₿
	43.94 ₿
	2555.68 ₿
	500.00 ₿
	95.64 ₿
	120.80 ₿
	60.88 ₿
	985.34 ₿
	18.48 ₿
	753.41 ₿
	39.96 ₿
	111.66 ₿
	500.00 ₿
	500.00 ₿
	11.80 ₿
	500.00 ₿
	400.00 ₿
	500.00 ₿
	500.00 ₿
	234.27 ₿
	13.19 ₿
	400.00 ₿
	500.00 ₿
	4.10 ₿
	29.74 ₿
	400.00 ₿
	22.38 ₿
	123.81 ₿
	129.77 ₿
	1460.91 ₿
	500.00 ₿
	10.00 ₿
	6426.93 ₿
	6.31 ₿
	6.57 ₿
	40.06 ₿
	0.12 ₿
	500.00 ₿
	281.70 ₿
	400.00 ₿
	112.64 ₿
	400.00 ₿
	400.00 ₿
	34.35 ₿
	500.00 ₿
	1414.83 ₿
	1190.62 ₿
	500.00 ₿
	500.00 ₿
	5.79 ₿
	10.00 ₿
	1140.74 ₿
	6.74 ₿
	6.74 ₿
	500.00 ₿
	84.17 ₿
	400.00 ₿
	1.22 ₿
	19.29 ₿
	500.00 ₿
	500.00 ₿
	25.91 ₿
	179.60 ₿
	370.35 ₿
	1191.09 ₿
	4.02 ₿
	54.31 ₿
	400.00 ₿
	500.00 ₿
	400.00 ₿
	0.06 ₿
	235.02 ₿
	400.00 ₿
	10.38 ₿
	103.30 ₿
	73.66 ₿
	400.00 ₿
	400.00 ₿
	400.00 ₿
	149.54 ₿
	21.92 ₿
	500.00 ₿
	156.13 ₿
	1.01 ₿
	35.50 ₿
	240.72 ₿
	474.51 ₿
	69.29 ₿
	500.00 ₿
	5.12 ₿
	20.62 ₿
	192.69 ₿
	500.00 ₿
	1006.43 ₿
	44.94 ₿
	2.24 ₿
	16.34 ₿
	4.69 ₿
	29.86 ₿
	400.00 ₿
	2.19 ₿
	150.11 ₿
	163.43 ₿
	1665.36 ₿
	500.00 ₿
	2.47 ₿
	195.18 ₿
	1.78 ₿
	400.00 ₿
	45.11 ₿
	4.40 ₿
	153.72 ₿
	500.00 ₿
	18.87 ₿
	536.14 ₿
	400.00 ₿
	8.35 ₿
	1213.41 ₿
	0.36 ₿
	255.94 ₿
	0.03 ₿
	55.57 ₿
	156.94 ₿
	35.88 ₿
	1.36 ₿
	400.00 ₿
	500.00 ₿
	11.18 ₿
	28.29 ₿
	26.31 ₿
	400.00 ₿
	992.58 ₿
	500.00 ₿
	77.57 ₿
	136.64 ₿
	0.80 ₿
	500.00 ₿
	400.00 ₿
	38.06 ₿
	0.23 ₿
	302.03 ₿
	59.17 ₿
	32.50 ₿
	78.48 ₿
	2371.08 ₿
	0.76 ₿
	4378.44 ₿
	777.48 ₿
	59.44 ₿
	500.00 ₿
	500.00 ₿
	9.41 ₿
	1252.77 ₿
	171.41 ₿
	396.01 ₿
	0.05 ₿
	400.00 ₿
	604.15 ₿
	500.00 ₿
	500.00 ₿
	1259.14 ₿
	400.00 ₿
	400.00 ₿
	90.58 ₿
	1.44 ₿
	0.40 ₿
	500.00 ₿
	500.00 ₿
	89.39 ₿
	500.00 ₿
	14.33 ₿
	5.52 ₿
	25.69 ₿
	250.14 ₿
	400.00 ₿
	320.80 ₿
	3.70 ₿
	500.00 ₿
	15.08 ₿
	55.65 ₿
	1103.03 ₿
	71.61 ₿
	500.00 ₿
	76.76 ₿
	1003.10 ₿
	83.51 ₿
	490.92 ₿
	1529.65 ₿
	24.21 ₿
	500.00 ₿
	33.14 ₿
	50.58 ₿
	167.88 ₿
	0.33 ₿
	1475.73 ₿
	400.00 ₿
	37.19 ₿
	110.03 ₿
	15.38 ₿
	500.00 ₿
	208.49 ₿
	500.00 ₿
	5.10 ₿
	400.00 ₿
	500.00 ₿
	400.00 ₿
	170.28 ₿
	28.71 ₿
	500.00 ₿
	1178.57 ₿
	560.36 ₿
	10.73 ₿
	529.83 ₿
	7.61 ₿
	58.48 ₿
	532.26 ₿
	141.07 ₿
	621.33 ₿
	500.00 ₿
	65.05 ₿
	9.76 ₿
	500.00 ₿
	500.00 ₿
	400.00 ₿
	500.00 ₿
	400.00 ₿
	14.83 ₿
	400.00 ₿
	3.87 ₿
	4.96 ₿
	379.28 ₿
	31.91 ₿
	189.57 ₿
	79.44 ₿
	3.08 ₿
	1192.39 ₿
	494.93 ₿
	500.00 ₿
	0.04 ₿
	400.00 ₿
	472.53 ₿
	0.01 ₿
	10.39 ₿
	400.00 ₿
	1.25 ₿
	43.90 ₿
	2.16 ₿
	6.03 ₿
	500.00 ₿
	989.54 ₿
	61.66 ₿
	1026.26 ₿
	3456.82 ₿
	127.61 ₿
	400.00 ₿
	25.87 ₿
	500.00 ₿
	0.94 ₿
	4698.18 ₿
	500.00 ₿
	7.91 ₿
	159.72 ₿
	5.55 ₿
	500.00 ₿
	8.07 ₿
	53.60 ₿
	0.05 ₿
	179.70 ₿
	20.95 ₿
	500.00 ₿
	500.00 ₿
	500.00 ₿
	1432.14 ₿
	10.75 ₿
	0.05 ₿
	250.10 ₿
	500.00 ₿
	400.00 ₿
	42.70 ₿
	42.76 ₿
	26.70 ₿
	39.72 ₿
	500.00 ₿
	0.18 ₿
	283.50 ₿
	61.11 ₿
	11.58 ₿
	23.58 ₿
	7.39 ₿
	82.11 ₿
	15.04 ₿
	267.94 ₿
	94.96 ₿
	46.85 ₿
	2.78 ₿
	155.60 ₿
	464.85 ₿
	40.00 ₿
	95.74 ₿
	500.00 ₿
	534.19 ₿
	26.67 ₿
	2.98 ₿
	500.00 ₿
	500.00 ₿
	500.00 ₿
	5.89 ₿
	500.00 ₿
	292.44 ₿
	171.94 ₿
	50.00 ₿
	453.80 ₿
	7.23 ₿
	307.28 ₿
	1.71 ₿
	10.79 ₿
	362.14 ₿
	156.22 ₿
	500.00 ₿
	971.65 ₿
	21.57 ₿
	87.78 ₿
	1496.66 ₿
	500.00 ₿
	112.21 ₿
	400.00 ₿
	76.69 ₿
	10.70 ₿
	500.00 ₿
	24.65 ₿
	291.08 ₿
	400.00 ₿
	1224.93 ₿
	1.23 ₿
	0.25 ₿
	500.00 ₿
	42.54 ₿
	500.00 ₿
	24.29 ₿
	80.21 ₿
	500.00 ₿
	2180.61 ₿
	2.20 ₿
	78.42 ₿
	1099.82 ₿
	500.00 ₿
	8.54 ₿
	737.47 ₿
	95.89 ₿
	0.05 ₿
	0.01 ₿
	1556.96 ₿
	351.06 ₿
	28.33 ₿
	492.97 ₿
	119.23 ₿
	41.44 ₿
	500.00 ₿
	138.84 ₿
	400.00 ₿
	400.00 ₿
	8.62 ₿
	400.00 ₿
	400.00 ₿
	45.58 ₿
	197.92 ₿
	500.00 ₿
	104.68 ₿
	30.42 ₿
	765.23 ₿
	3.30 ₿
	102.14 ₿
	3.75 ₿
	53.66 ₿
	119.06 ₿
	500.00 ₿
	224.86 ₿
	12.80 ₿
	400.00 ₿
	63.90 ₿
	6.42 ₿
	281.31 ₿
	400.00 ₿
	500.00 ₿
	82.36 ₿
	400.00 ₿
	45.60 ₿
	744.00 ₿
	108.55 ₿
	500.00 ₿
	51.50 ₿
	500.00 ₿
	166.63 ₿
	2037.33 ₿
	500.00 ₿
	56.67 ₿
	76.43 ₿
	47.79 ₿
	27.60 ₿
	400.00 ₿
	2947.83 ₿
	400.00 ₿
	500.00 ₿
	500.00 ₿
	165.47 ₿
	6.87 ₿
	500.00 ₿
	162.82 ₿
	77.36 ₿
	104.09 ₿
	500.00 ₿
	46.80 ₿
	500.00 ₿
	1738.58 ₿
	400.00 ₿
	3.90 ₿
	0.50 ₿
	863.48 ₿
	1.55 ₿
	13.48 ₿
	1921.41 ₿
	36.36 ₿
	500.00 ₿
	141.64 ₿
	400.00 ₿
	500.00 ₿
	24.34 ₿
	500.00 ₿
	1730.29 ₿
	17.72 ₿
	500.00 ₿
	27.64 ₿
	998.54 ₿
	34.77 ₿
	14.59 ₿
	196.61 ₿
	500.00 ₿
	6.72 ₿
	816.11 ₿
	500.00 ₿
	0.22 ₿
	5.61 ₿
	9.82 ₿
	500.00 ₿
	373.36 ₿
	145.56 ₿
	500.00 ₿
	160.36 ₿
	1183.18 ₿
	896.38 ₿
	2937.95 ₿
	500.00 ₿
	11.46 ₿
	575.80 ₿
	5.56 ₿
	400.00 ₿
	500.00 ₿
	60.54 ₿
	500.00 ₿
	383.43 ₿
	41.61 ₿
	500.00 ₿
	500.00 ₿
	39.82 ₿
	26.11 ₿
	731.93 ₿
	500.00 ₿
	500.00 ₿
	0.57 ₿
	84.50 ₿
	43.09 ₿
	301.44 ₿
	30.79 ₿
	867.85 ₿
	400.00 ₿
	500.00 ₿
	67.21 ₿
	6.21 ₿
	1.04 ₿
	899.82 ₿
	500.00 ₿
	500.00 ₿
	13.92 ₿
	73.57 ₿
	20.45 ₿
	450.45 ₿
	500.00 ₿
	500.00 ₿
	400.00 ₿
	65.57 ₿
	0.02 ₿
	76.11 ₿
	384.52 ₿
	1721.22 ₿
	192.50 ₿
	500.00 ₿
	500.00 ₿
	500.00 ₿
	40.35 ₿
	500.00 ₿
	99.21 ₿
	500.00 ₿
	500.00 ₿
	30.47 ₿
	400.00 ₿
	500.00 ₿
	3.24 ₿
	230.07 ₿
	500.00 ₿
	421.73 ₿
	297.54 ₿
	36.84 ₿
	21.06 ₿
	147.05 ₿
	101.10 ₿
	697.90 ₿
	400.00 ₿
	2047.86 ₿
	500.00 ₿
	10.14 ₿
	23.11 ₿
	314.39 ₿
	500.00 ₿
	27.00 ₿
	785.46 ₿
	48.76 ₿
	6.81 ₿
	500.00 ₿
	25.84 ₿
	500.00 ₿
	400.00 ₿
	500.00 ₿
	112.04 ₿
	400.00 ₿
	400.00 ₿
	64.35 ₿
	114.23 ₿
	74.13 ₿
	500.00 ₿
	16.79 ₿
	727.51 ₿
	500.00 ₿
	500.00 ₿
	72.27 ₿
	500.00 ₿
	1340.96 ₿
	0.99 ₿
	1.25 ₿
	400.00 ₿
	33.22 ₿
	85.71 ₿
	35.90 ₿
	400.00 ₿
	403.18 ₿
	109.20 ₿
	230.37 ₿
	76.26 ₿
	437.07 ₿
	500.00 ₿
	152.01 ₿
	33.89 ₿
	34.18 ₿
	400.00 ₿
	500.00 ₿
	400.00 ₿
	400.00 ₿
	500.00 ₿
	249.77 ₿
	500.00 ₿
	3.81 ₿
	500.00 ₿
	387.55 ₿
	145.29 ₿
	176.01 ₿
	16.76 ₿
	122.45 ₿
	500.00 ₿
	89.67 ₿
	122.69 ₿
	20.92 ₿
	19.46 ₿
	590.02 ₿
	400.00 ₿
	500.00 ₿
	354.25 ₿
	500.00 ₿
	500.00 ₿
	282.46 ₿
	24.34 ₿
	42.58 ₿
	1519.81 ₿
	500.00 ₿
	400.00 ₿
	400.00 ₿
	153.43 ₿
	254.00 ₿
	500.00 ₿
	1.54 ₿
	500.00 ₿
	500.00 ₿
	48.66 ₿
	0.20 ₿
	193.14 ₿
	400.00 ₿
	443.28 ₿
	500.00 ₿
	218.61 ₿
	32.95 ₿
	56.94 ₿
	38.96 ₿
	1682.06 ₿
	400.00 ₿
	500.00 ₿
	17.91 ₿
	361.09 ₿
	400.00 ₿
	500.00 ₿
	363.87 ₿
	136.47 ₿
	500.00 ₿
	287.02 ₿
	500.00 ₿
	197.51 ₿
	270.33 ₿
	9.67 ₿
	500.00 ₿
	400.00 ₿
	400.00 ₿
	4.86 ₿
	11.92 ₿
	26.59 ₿
	14.33 ₿
	400.00 ₿
	1815.19 ₿
	37.46 ₿
	500.00 ₿
	1.15 ₿
	43.52 ₿
	500.00 ₿
	53.66 ₿
	119.06 ₿
	500.00 ₿
	224.86 ₿
	12.80 ₿
	400.00 ₿
	63.90 ₿
	6.42 ₿
	281.31 ₿
	400.00 ₿
	500.00 ₿
	82.36 ₿
	400.00 ₿
	45.60 ₿
	744.00 ₿
	108.55 ₿
	500.00 ₿
	51.50 ₿
	500.00 ₿
	166.63 ₿
	2037.33 ₿
	500.00 ₿
	56.67 ₿
	76.43 ₿
	47.79 ₿
	27.60 ₿
	400.00 ₿
	2947.83 ₿
	400.00 ₿
	500.00 ₿
	500.00 ₿
	165.47 ₿
	6.87 ₿
	500.00 ₿
	162.82 ₿
	77.36 ₿
	104.09 ₿
	500.00 ₿
	46.80 ₿
	500.00 ₿
	1738.58 ₿
	400.00 ₿
	3.90 ₿
	0.50 ₿
	863.48 ₿
	1.55 ₿
	13.48 ₿
	1921.41 ₿
	36.36 ₿
	500.00 ₿
	141.64 ₿
	400.00 ₿
	500.00 ₿
	24.34 ₿
	500.00 ₿
	1730.29 ₿
	17.72 ₿
	500.00 ₿
	27.64 ₿
	998.54 ₿
	34.77 ₿
	14.59 ₿
	196.61 ₿
	500.00 ₿
	6.72 ₿
	816.11 ₿
	500.00 ₿
	0.22 ₿
	5.61 ₿
	9.82 ₿
	500.00 ₿
	373.36 ₿
	145.56 ₿
	500.00 ₿
	160.36 ₿
	1183.18 ₿
	896.38 ₿
	2937.95 ₿
	500.00 ₿
	11.46 ₿
	575.80 ₿
	5.56 ₿";

	static final regularLessTransactions =
	"450
	7084.39 €
	10.64 €
	-3809.63 €
	-7.41 €
	-56.38 €
	-941.35 €
	2477.50 €
	-153.48 €
	-99.72 €
	-0.01 €
	640.81 €
	53.77 €
	184.19 €
	-148.95 €
	-1.65 €
	7.62 €
	114.18 €
	-559.86 €
	3451.30 €
	-2.16 €
	-84.96 €
	5612.52 €
	184.73 €
	1079.94 €
	-25.25 €
	-3213.08 €
	-174.97 €
	19.95 €
	-326.95 €
	0.66 €
	30.29 €
	16.52 €
	-428.81 €
	222.44 €
	422.46 €
	-5.78 €
	337.29 €
	-143.89 €
	-135.71 €
	59.44 €
	-19.35 €
	-4.48 €
	4732.11 €
	34.54 €
	-302.17 €
	9.85 €
	-524.06 €
	95.19 €
	232.77 €
	86.58 €
	42.76 €
	77.79 €
	-14.26 €
	-36.30 €
	-3054.99 €
	-30.02 €
	-6.13 €
	100.77 €
	-15.76 €
	-44.71 €
	2.97 €
	-131.64 €
	-1.47 €
	150.26 €
	-0.07 €
	14.18 €
	1772.02 €
	6.39 €
	169.37 €
	51.33 €
	1960.90 €
	8.16 €
	-40.55 €
	14.54 €
	3.51 €
	103.33 €
	0.54 €
	-54.41 €
	-113.39 €
	-23.31 €
	3201.98 €
	126.36 €
	-8.94 €
	-89.27 €
	-66.54 €
	-3820.87 €
	5.41 €
	61.66 €
	-838.68 €
	-7173.88 €
	-176.80 €
	756.36 €
	-513.18 €
	8.05 €
	249.85 €
	5.57 €
	-94.99 €
	874.66 €
	6.09 €
	70.17 €
	-7.78 €
	21.51 €
	1.57 €
	36.81 €
	-4398.23 €
	-0.01 €
	-5266.53 €
	-146.59 €
	19.46 €
	14.41 €
	81.36 €
	14.09 €
	53.86 €
	272.22 €
	-27.75 €
	932.52 €
	0.08 €
	-0.64 €
	-23.23 €
	-34.99 €
	37.49 €
	84.08 €
	-2113.38 €
	-1.79 €
	-435.09 €
	-8.02 €
	0.49 €
	-45.39 €
	2022.53 €
	1694.70 €
	-58.46 €
	225.83 €
	-479.98 €
	-1142.31 €
	-10.68 €
	-1914.47 €
	-5820.09 €
	26.23 €
	-735.83 €
	5927.91 €
	210.55 €
	-3010.30 €
	284.00 €
	-17.33 €
	-2.51 €
	12.40 €
	-2718.20 €
	-8.27 €
	-1742.09 €
	24.90 €
	-316.81 €
	0.84 €
	1.57 €
	-172.84 €
	-18.70 €
	44.47 €
	4.12 €
	2.94 €
	-51.08 €
	24.09 €
	2837.62 €
	30.79 €
	-1.03 €
	-3.90 €
	1.95 €
	-772.44 €
	0.42 €
	-1655.97 €
	135.55 €
	131.74 €
	81.81 €
	-57.09 €
	19.51 €
	-295.37 €
	18.87 €
	-3084.44 €
	14.78 €
	37.54 €
	-334.53 €
	1004.23 €
	2439.70 €
	3406.62 €
	6.22 €
	6.34 €
	-5.93 €
	-855.79 €
	127.32 €
	63.33 €
	-1.02 €
	-5.59 €
	10.54 €
	303.02 €
	-33.96 €
	-50.36 €
	-4.84 €
	8.87 €
	403.14 €
	-338.54 €
	3074.96 €
	552.32 €
	65.18 €
	4.15 €
	958.08 €
	388.04 €
	-5.25 €
	13.28 €
	-1774.61 €
	-920.05 €
	-9.86 €
	11.56 €
	53.84 €
	0.07 €
	-119.14 €
	-0.21 €
	7188.49 €
	1859.66 €
	488.78 €
	5358.34 €
	165.10 €
	558.75 €
	-6422.83 €
	-40.39 €
	1102.23 €
	-535.75 €
	-30.28 €
	-153.88 €
	-390.86 €
	76.35 €
	4.49 €
	-3.52 €
	29.74 €
	-5.84 €
	-263.23 €
	546.69 €
	28.25 €
	-765.89 €
	606.73 €
	-14.39 €
	-3.20 €
	341.84 €
	-546.27 €
	105.58 €
	630.06 €
	-287.82 €
	-661.14 €
	266.63 €
	60.57 €
	-2.24 €
	1015.27 €
	-1.65 €
	7.50 €
	421.54 €
	-36.97 €
	-93.66 €
	-5.90 €
	98.20 €
	146.33 €
	-179.24 €
	-203.68 €
	196.38 €
	26.78 €
	379.18 €
	1703.90 €
	104.48 €
	-7.28 €
	15.59 €
	30.11 €
	7.31 €
	-1815.90 €
	-4916.38 €
	-5.71 €
	1.64 €
	6.46 €
	-1231.98 €
	62.42 €
	5991.44 €
	8.88 €
	10.86 €
	237.26 €
	-8.06 €
	-1610.05 €
	-2.17 €
	-216.95 €
	-155.87 €
	95.99 €
	-68.15 €
	-710.26 €
	4032.21 €
	238.66 €
	-6.56 €
	5435.96 €
	-2580.52 €
	-481.60 €
	-41.78 €
	1774.35 €
	76.66 €
	-3.56 €
	-705.50 €
	-1568.47 €
	9.37 €
	2.12 €
	7.50 €
	18.36 €
	63.70 €
	-70.84 €
	-149.72 €
	-257.72 €
	330.28 €
	-5.18 €
	-572.05 €
	-102.97 €
	-15.15 €
	1067.69 €
	-1.52 €
	8.60 €
	1331.21 €
	-25.26 €
	506.89 €
	235.36 €
	19.43 €
	-262.12 €
	-1.84 €
	-5.46 €
	0.63 €
	250.80 €
	25.62 €
	21.70 €
	-81.03 €
	-62.96 €
	-0.49 €
	-152.38 €
	-12.67 €
	39.65 €
	274.03 €
	-523.73 €
	0.23 €
	-5.21 €
	7.31 €
	755.78 €
	689.33 €
	94.47 €
	421.00 €
	-662.89 €
	-381.57 €
	5.15 €
	-44.86 €
	1.46 €
	293.06 €
	127.66 €
	240.88 €
	33.55 €
	2625.32 €
	9.24 €
	204.07 €
	-69.40 €
	10.62 €
	-1.34 €
	-1909.49 €
	-147.22 €
	13.43 €
	202.95 €
	4.20 €
	-2.51 €
	19.10 €
	-12.17 €
	-26.03 €
	-3.49 €
	59.69 €
	-17.19 €
	-13.24 €
	3.01 €
	0.03 €
	3633.83 €
	-5.16 €
	-290.11 €
	-2209.62 €
	11.35 €
	-2983.25 €
	11.75 €
	107.49 €
	-93.16 €
	-172.05 €
	13.14 €
	-2.83 €
	-27.70 €
	578.16 €
	-93.73 €
	736.85 €
	-36.98 €
	4450.10 €
	28.42 €
	-883.22 €
	404.14 €
	-11.20 €
	286.25 €
	1.93 €
	33.46 €
	8.01 €
	17.26 €
	9.98 €
	-0.33 €
	-17.66 €
	-9.35 €
	-0.74 €
	176.41 €
	-364.61 €
	24.92 €
	-15.06 €
	-0.42 €
	1.79 €
	3.82 €
	410.94 €
	46.22 €
	531.08 €
	-0.51 €
	358.36 €
	777.18 €
	-15.98 €
	152.50 €
	1141.59 €
	3.50 €
	0.97 €
	9.69 €
	549.92 €
	188.39 €
	1519.28 €
	6.57 €
	0.52 €
	-717.88 €
	-4.30 €
	26.52 €
	-1942.86 €
	-1.53 €
	19.50 €
	-368.66 €
	2.38 €
	10.53 €
	2435.23 €
	104.51 €
	1.29 €
	-399.54 €
	4.92 €
	-11.41 €
	40.60 €
	-11.85 €
	137.41 €
	8.47 €
	5.10 €
	-3253.78 €
	-16.41 €";

	static final fakeAccountEquidistributed2 =
	"300
	¥ 59.51
	¥ -43.19
	¥ 922.01
	¥ -49.24
	¥ 7098.65
	¥ 484.23
	¥ 9782.87
	¥ 7523.18
	¥ -600.83
	¥ 6.91
	¥ -96.47
	¥ 210.67
	¥ -706.02
	¥ -206.10
	¥ 381.63
	¥ 56.72
	¥ 7655.72
	¥ -946.32
	¥ 2823.02
	¥ 3800.57
	¥ 5240.25
	¥ -2310.63
	¥ 1.18
	¥ 918.39
	¥ 47.49
	¥ -139.60
	¥ -90.18
	¥ -5019.69
	¥ 32.09
	¥ 138.57
	¥ -508.65
	¥ 632.98
	¥ 8680.73
	¥ 74.80
	¥ -755.95
	¥ 775.67
	¥ -8569.57
	¥ -4899.61
	¥ -9303.85
	¥ -9159.08
	¥ -8985.99
	¥ -59.50
	¥ 99.58
	¥ 9.51
	¥ -663.19
	¥ 2.79
	¥ -36.00
	¥ -28.37
	¥ 505.90
	¥ -89.54
	¥ 478.63
	¥ -9130.57
	¥ -592.17
	¥ -27.52
	¥ -14.29
	¥ 167.75
	¥ -2506.55
	¥ 9348.25
	¥ 8385.36
	¥ -55.77
	¥ 3696.01
	¥ -118.46
	¥ -215.79
	¥ -35.03
	¥ -4984.65
	¥ 28.38
	¥ 4201.33
	¥ 4908.11
	¥ -770.52
	¥ -7574.75
	¥ 11.79
	¥ 21.84
	¥ 3129.33
	¥ -961.11
	¥ -7240.48
	¥ 970.22
	¥ -3804.03
	¥ -5372.84
	¥ 268.89
	¥ 219.71
	¥ -38.43
	¥ -739.14
	¥ -47.78
	¥ -6243.09
	¥ 508.85
	¥ 6.77
	¥ 9596.13
	¥ -971.41
	¥ 2017.22
	¥ 844.37
	¥ 8370.78
	¥ 71.75
	¥ 48.42
	¥ -8003.88
	¥ 7864.14
	¥ -9828.37
	¥ 68.03
	¥ 8.38
	¥ -771.07
	¥ -6605.00
	¥ 6797.14
	¥ -512.26
	¥ -6236.64
	¥ 885.94
	¥ 86.58
	¥ 45.58
	¥ 3951.22
	¥ -884.12
	¥ -4990.18
	¥ 7169.46
	¥ -62.75
	¥ 2972.92
	¥ -3504.14
	¥ 8695.39
	¥ 49.61
	¥ -612.40
	¥ 1185.20
	¥ 8863.81
	¥ 22.53
	¥ 513.29
	¥ 481.69
	¥ -789.65
	¥ 465.38
	¥ 5.64
	¥ -8785.87
	¥ 45.38
	¥ 39.75
	¥ 517.38
	¥ 5777.98
	¥ -310.66
	¥ -61.43
	¥ 797.32
	¥ 5029.10
	¥ -6724.36
	¥ -2360.14
	¥ -9954.37
	¥ 549.70
	¥ -95.73
	¥ -76.92
	¥ 79.11
	¥ 35.97
	¥ -661.83
	¥ -288.48
	¥ -2611.35
	¥ 7926.10
	¥ -655.00
	¥ 785.85
	¥ -6.32
	¥ 55.50
	¥ 72.52
	¥ 130.52
	¥ 6156.45
	¥ 83.68
	¥ -3015.53
	¥ -64.92
	¥ -2067.36
	¥ -34.09
	¥ -2279.36
	¥ -513.96
	¥ -1521.75
	¥ 25.14
	¥ 354.25
	¥ -736.10
	¥ -593.85
	¥ 33.37
	¥ 83.34
	¥ -748.73
	¥ 6564.93
	¥ -25.36
	¥ 73.50
	¥ 48.21
	¥ -16.60
	¥ -22.41
	¥ 9.68
	¥ -628.57
	¥ -6313.87
	¥ 1075.11
	¥ 86.39
	¥ -9434.39
	¥ -805.35
	¥ 4274.68
	¥ 420.42
	¥ 3.28
	¥ -3773.56
	¥ -565.26
	¥ 63.90
	¥ 529.34
	¥ -38.88
	¥ -5359.24
	¥ -90.79
	¥ 524.34
	¥ 1.79
	¥ -5442.80
	¥ -7883.67
	¥ 605.17
	¥ 51.72
	¥ 529.37
	¥ 81.28
	¥ 646.12
	¥ -891.30
	¥ -2651.19
	¥ 5.94
	¥ -69.38
	¥ 129.97
	¥ 53.64
	¥ 681.91
	¥ -2008.26
	¥ 23.00
	¥ 8053.21
	¥ 40.72
	¥ -27.80
	¥ 398.75
	¥ 9058.78
	¥ -5015.91
	¥ -5.07
	¥ -923.84
	¥ -3694.15
	¥ 848.70
	¥ 48.06
	¥ -8558.80
	¥ 421.45
	¥ -9176.71
	¥ -92.18
	¥ -415.17
	¥ 469.55
	¥ -77.65
	¥ 7795.72
	¥ 197.09
	¥ 99.95
	¥ 54.06
	¥ -742.18
	¥ 24.93
	¥ -9421.89
	¥ 959.42
	¥ -33.62
	¥ 806.45
	¥ -40.38
	¥ -70.96
	¥ 237.45
	¥ 678.00
	¥ 826.39
	¥ -2231.79
	¥ 83.14
	¥ -64.76
	¥ 40.19
	¥ 2206.35
	¥ 6208.46
	¥ -16.73
	¥ -4112.96
	¥ 805.27
	¥ 6129.47
	¥ 29.59
	¥ -474.76
	¥ 881.28
	¥ -3141.62
	¥ 6595.24
	¥ 19.96
	¥ -231.95
	¥ 4476.00
	¥ 4888.46
	¥ 484.55
	¥ -9778.53
	¥ 852.29
	¥ 85.13
	¥ 656.09
	¥ 72.83
	¥ 83.88
	¥ 466.72
	¥ 8729.22
	¥ 2528.67
	¥ -95.59
	¥ -467.73
	¥ -587.76
	¥ -240.79
	¥ 43.53
	¥ -3289.84
	¥ -18.35
	¥ -79.91
	¥ 107.71
	¥ -281.00
	¥ -6955.61
	¥ -5438.08
	¥ 4.33
	¥ 4265.80
	¥ 8525.29
	¥ -975.15
	¥ 94.62
	¥ -53.52
	¥ 57.00
	¥ -8.27
	¥ 28.56
	¥ -670.66
	¥ -401.15
	¥ 436.88
	¥ 91.96
	¥ -596.67
	¥ 27.35
	¥ 6.37
	¥ 41.07
	¥ 536.88";

}
