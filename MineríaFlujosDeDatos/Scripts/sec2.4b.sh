#!/bin/bash
# Script tarea 2.3 HoeffdingTree RBFGenerator con drift 
for i in `seq 1 30`
do
	echo "modelo $i"
	java -cp moa.jar -javaagent:sizeofag-1.0.0.jar moa.DoTask "EvaluatePrequential -l trees.HoeffdingAdaptiveTree -s (generators.RandomRBFGeneratorDrift -i $i -r 1 -c 2 -a 7 -n 3 -s 0.001 -k 3) -i 2000000 -w 1000"  > salida2.4b_iter$i.csv	
done


read  -n 1 -p "Exit." mainmenuinput