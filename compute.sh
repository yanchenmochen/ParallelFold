#!/bin/bash
# Description: 用于一下子完成所有的执行
# Author: songquanheng

cd `dirname $0`
source ~/.bashrc
source activate parafold

# run_fasta用于计算传入fasta的序列，并且使用模型2进行预测
run_fasta() {
    startTime=`date +%Y%m%d-%H:%M:%S`
    startTime_s=`date +%s`

    touch result/$1.log
    ./run_alphafold.sh -d /mnt/dataset/ -o result -p monomer -m model_2 -i input/$1 | tee result/$1.log
    echo "Name passed is: $1"
    endTime=`date +%Y%m%d-%H:%M:%S`
    endTime_s=`date +%s`

    sumTime=$[ $endTime_s - $startTime_s ]
    echo "Handle $1: " "$startTime ---> $endTime" "Total: $sumTime seconds"
}

for fasta_name in $(ls ./input) ; do 
    run_fasta $fasta_name
done


