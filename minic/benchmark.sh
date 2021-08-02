#!/bin/bash

function usage {
	echo "syntax error : $1"
	echo "Usage: $0 <benchmark_name> (compile_target) [optimizations]"
	exit 1
}

[ $# -eq 2 -o $# -eq 3 ] || usage "You must provide two or three parameters"

BENCHMARK_NAME="$1"

echo "##################################"
echo "#### Benchmarking : $BENCHMARK_NAME ####"
echo "##################################"

TEMPFILE="./benchmark.temp.out"
CLANG="clang"
MINIC="./target/debug/minic"

BENCHMARK_DIR="benchmarks/$BENCHMARK_NAME"
BENCHMARK_SOURCE="$BENCHMARK_DIR/$BENCHMARK_NAME.mini"
[ -f "$BENCHMARK_SOURCE" ] || usage "Couldn't find benchmark at '$BENCHMARK_SOURCE'"

LLVM_FILE="intermediate.ll"
if [ "$2" == "-a" -o "$2" == "-ar" ]
then
	LLVM_FILE="intermediate.s"
fi

if [ ! -f "$BENCHMARK_SOURCE" ]
then
	echo "Couldn't find $BENCHMARK_SOURCE"
	exit 999
fi

echo "Benchmarking : $BENCHMARK_NAME"

echo "Compiling : $BENCHMARK_SOURCE"
"$MINIC" "$BENCHMARK_SOURCE" "$2" $3 > /dev/null
if [ "$?" -ne 0 ]
then
	echo "Minic compilation failed"
	echo "${BENCHMARK_NAME},<minic>" >> "TIMES"
	exit 1
fi
SOURCE_SIZE=`wc -l "$LLVM_FILE" | sed 's/^ *//;s/ .*//;'`

echo "Compiling LLVM..."

"$CLANG" "$LLVM_FILE" "src/helper.c" > /dev/null

if [ "$?" -ne 0 ]
then
	echo "LLVM compilation failed"
	echo "${BENCHMARK_NAME},<llvm>" >> "TIMES"
	exit 2
fi
COMPILED_SIZE=`wc -c "a.out" | sed 's/^ *//;s/ .*//;'`

TIMES=""

for ENDING in "" ".longer"
do
	INPUT="${BENCHMARK_DIR}/input${ENDING}"
	OUTPUT="${BENCHMARK_DIR}/output${ENDING}"
	echo "Executing a.out with input from '$INPUT'"
	RUNTIME=`(time -p ./a.out < "$INPUT" > "$TEMPFILE" ) 2>&1 | grep user | sed 's/user[^0-9]*//'`

	if [ $? -ne 0 ]
	then
		echo "Execution with input \"$INPUT\" failed"
		echo "${BENCHMARK_NAME},<crash>" >> "TIMES"
		exit 4
	else
		if (diff "$OUTPUT" "$TEMPFILE" > /dev/null)
		then
			echo "Success : $RUNTIME"
			TIMES="$TIMES,$RUNTIME"
		else
			echo "Output didn't match reference version"
			echo "${BENCHMARK_NAME},<diff>" >> "TIMES"
			exit 3
		fi
	fi
	rm "$TEMPFILE"
done

echo "${BENCHMARK_NAME}${TIMES},${SOURCE_SIZE},${COMPILED_SIZE}" >> "TIMES"
exit 0

