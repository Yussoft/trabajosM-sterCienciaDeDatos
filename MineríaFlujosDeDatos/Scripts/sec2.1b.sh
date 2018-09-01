#!/bin/bash
# Script tarea 2.2 HoeffdingTreeAdaptative estacionario con 30 soluciones

for i in `seq 5 35`
do
	echo "modelo $i"
   	java -cp moa.jar -javaagent:sizeofag-1.0.0.jar moa.DoTask "EvaluateModel -m (LearnModel -l trees.HoeffdingAdaptiveTree -s (generators.WaveformGenerator -i $i) -m 1000000) -s (generators.WaveformGenerator -i 4) -i 1000000" > salida2.1b_iter$i.csv
done


read  -n 1 -p "Exit." mainmenuinput