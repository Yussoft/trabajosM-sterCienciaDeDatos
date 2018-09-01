#!/bin/bash
# Script tarea 2.1 HoeffdingTree test-then-train 

for i in `seq 2 32`
do
	echo "modelo $i"
   	java -cp moa.jar -javaagent:sizeofag-1.0.0.jar moa.DoTask "EvaluateInterleavedTestThenTrain -l trees.HoeffdingTree -s (generators.WaveformGenerator -i $i) -i 1000000 -f 10000"  > salida2.2a_iter$i.csv
done


read  -n 1 -p "Exit." mainmenuinput