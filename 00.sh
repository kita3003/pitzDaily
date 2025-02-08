#!/bin/bash
export TZ="Asia/Tokyo"
log=./test22.log

### tee を使ってコンソールとファイルに出力する。
exec &> >(awk '{print strftime("[%Y/%m/%d %H:%M:%S.%f] "),$0} {fflush()}' | tee -a $log)


echo [S]----------------------------------------------
# 現在時刻を取得
# _started_at=$(date +"%s%3N")
_started_at=$(date +"%s")
echo `date`
echo [S]----------------------------------------------

./Allclean.sh
./preProcessing.sh
# mpirun -np 6 python runScript_v2.py 2>&1 | tee logOpt.txt

sleep 3

# 完了時刻を取得
# _ended_at=$(date +"%s%3N")
_ended_at=$(date +"%s")

# 経過時間を計算
# _elapsed=$(echo "scale=3; $_ended_at - $_started_at" | bc)
# _elapsed=$((_ended_at - _started_at))
PT=`expr ${_ended_at} - ${_started_at}`
# _elapsedms=${_elapsed}/1000

echo "start: $(date -d "@${_started_at}" +'%Y-%m-%d %H:%M:%S.%3N (%:z)')"
echo "end  : $(date -d "@${_ended_at}" +'%Y-%m-%d %H:%M:%S.%3N (%:z)')"


H=`expr ${PT} / 3600`
PT=`expr ${PT} % 3600`
M=`expr ${PT} / 60`
S=`expr ${PT} % 60`


# echo "dur:   $_elapsed"
echo "_elapsed(ms):${_elapsed}"
echo "_elapsed(s):${H}:${M}:${S}"
# echo "_elapsed(ms):${_elapsedms}"
# eval "echo Elapsed Time: $(date -ud "@$_elapsed/1000" +'$((%s/3600/24)):%H:%M:%S%3N')"
echo [E]----------------------------------------------
echo `date`
echo [E]----------------------------------------------
