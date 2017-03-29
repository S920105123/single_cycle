#!/bin/bash

for dir in $(ls ./open)
do
	cp ./open/${dir}/dimage.bin ./simulator/dimage.bin
	cp ./open/${dir}/iimage.bin ./simulator/iimage.bin
	cd ./simulator
	./single_cycle
	cd ..
	diff ./open/${dir}/snapshot.rpt ./simulator/snapshot.rpt > diff_snapshot.tmp
	diff ./open/${dir}/error_dump.rpt ./simulator/error_dump.rpt > diff_error.tmp
	if [ "$(cat diff_snapshot.tmp)" = "" -a "$(cat diff_error.tmp)" = "" ]; then
		echo "   Testcase: ${dir}\t- [Accecpted]..."
	else
		echo "   Testcase: ${dir}\t- [Wrong Answer]..."
		echo "${dir}" > who
		break
	fi
done