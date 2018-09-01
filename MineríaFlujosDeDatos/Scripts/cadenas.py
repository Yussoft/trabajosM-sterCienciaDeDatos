# -*- coding: utf-8 -*-
"""
Created on Fri Aug 31 18:20:21 2018

@author: Yus
"""
import pandas as pd
dir = "C:/Users/Yus/Desktop/moa-release-2017.06b/moa-release-2017.06b/2.5b"

# Leer valores MOA test-then-train
for i in range(1,31):
    data = pd.read_csv(dir+'/salida2.5b_iter'+str(i)+'.csv', sep=",")
    print(float(data.iloc[-1:,4]), float(data.iloc[-1:,5]))


# Leer valores MOA incremental
#    with open(dir+'//salida2.1b_iter'+str(i)+'.csv', 'r') as myfile:
#        
#        lines = myfile.readlines()
#        line2 = lines[1]
#        line22 = line2.find("\n")
#        line3 = lines[2]
#        line33 = line3.find("\n")
#        print(line2[-7:-1],line3[-7:-1])
    
