#!/bin/bash
log=./test.log

### tee を使ってコンソールとファイルに出力する。
exec &> >(awk '{print strftime("[%Y/%m/%d %H:%M:%S] "),$0} {fflush()}' | tee -a $log)

echo [S]----------------------------------------------
echo `date`
echo [S]----------------------------------------------
./Allclean.sh
./preProcessing.sh
mpirun -np 6 python runScript_v2.py 2>&1 | tee logOpt.txt
echo [E]----------------------------------------------
echo `date`
echo [E]----------------------------------------------
