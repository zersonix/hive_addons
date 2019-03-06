#!/usr/bin/env bash
declare -A arr
declare -A arrb
declare -A arrd

trex="/hive/miners/t-rex/0.9.2-cuda92"
arr=([m01]=103567 [m02]=103587 [m03]=103588 [m04]=103589 [m05]=103590 [m06]=103591 [m07]=103592 [m08]=103593)
arrd=(['m01']=0 ['m02']=1 ['m03']=2 ['m04']=3 ['m05']=4 ['m06']=5 ['m07']=6 ['m08']=7 ['m09']=8 ['m10']=9 ['m11]=10 ['m12']=11)
str="-a x16r -o stratum+tcp://eu-01.miningrigrentals.com:3333 -p x --api-bind-telnet 0 --api-bind-http 0"
arrs=("m01" "m02" "m03" "m04" "m05" "m06" "m07" "m08" "m09" "m10" "m11" "m12")
case $1 in
     start)
     echo "starting"
          cd $trex
          export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/hive/lib
          t="./t-rex -d ${arrd[$2]} $str -u leiber."${arr[$2]}
          echo $t
          screen -dmS $2 $t
          sleep 1
          echo "done"
          ;;
     stop)
          echo "stopping"
          process=$(screen -ls | grep $2)
          tt=$(echo $process | cut -f1 -d'.')
          #echo $tt
          kill $tt
          sleep 1
          echo "done"
          ;;
     restart)
          echo "restarting"
          ./ss.sh stop $2
          ./ss.sh start $2.
          ;;
    stopall)
          for i in ${arrs[@]}
          do
          echo $i
          ./ss.sh stop $i
          done
          ;;
    restartall)
          for i in ${arrs[@]}
          do
          echo $i
          ./ss.sh stop $i
          ./ss.sh start $i
          done
          ;;
esac
