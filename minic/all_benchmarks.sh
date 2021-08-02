#!/bin/bash

function usage {
	echo "syntax error : $1"
	echo "Usage: $0 (-l|-lr|-a|-ar) [optimizations]"
	exit 1
}

[ $# -eq 1 -o $# -eq 2 ] || usage "You must provide one or two parameters"

SUCCESS=""
LLVM=""
MINIC=""
CRASH=""
DIFF=""

echo "Benchmark,Short,Long,SourceSize,CompiledSize" > "TIMES"
for name in BenchMarkishTopics Fibonacci GeneralFunctAndOptimize OptimizationBenchmark TicTac bert biggest binaryConverter brett creativeBenchMarkName fact_sum hailstone hanoi_benchmark killerBubbles mile1 mixed primes programBreaker stats wasteOfCycles
do
	./benchmark.sh "$name" "$1" $2
	case $? in
		0)
			SUCCESS="${SUCCESS}${name} "
		;;
		1)
			MINIC="${MINIC}${name} "
		;;
		2)
			LLVM="${LLVM}${name} "
		;;
		3)
			DIFF="${DIFF}${name} "
		;;
		4)
			CRASH="${CRASH}${name} "
		;;
	esac
#	[ -f intermediate.ll ] && rm intermediate.ll
#	[ -f intermediate.s ] && rm intermediate.s
done

echo "##############################"
echo "####### RESULTS ##############"
echo "##############################"
echo "minic errors : $MINIC"
echo "llvm errors  : $LLVM"
echo "output diff  : $DIFF"
echo "a.out crash  : $CRASH"
echo "Success      : $SUCCESS"
echo ""
cat "TIMES"
echo
echo "These execution times are available in the file 'TIMES'"
