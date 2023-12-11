#!/bin/bash
# example input:
# RL
#
# AAA = (BBB, CCC)
# BBB = (DDD, EEE)
# CCC = (ZZZ, GGG)
# DDD = (DDD, DDD)
# EEE = (EEE, EEE)
# GGG = (GGG, GGG)
# ZZZ = (ZZZ, ZZZ)

line_num="0"
elements=()
direction="0"
took_first_step=true
steps=0
while IFS= read -r line
do
    if   [[ $line_num -eq 0 ]]; then
        instructions="$line"
    elif [[ $line_num -eq 1 ]]; then
        echo "skipping line 2"
    else
        key=$(echo "${line:0:3}" | awk '{print $0}' | tr -dc 'A-Z\n')
        declare prefix_$key=$(echo $line | awk -F'[()]' '{print $2}' | tr -d ' ')
        kv=prefix_$key
    fi
    (( line_num++ ))
done < $1

node="AAA"
for (( i=0; i<${#instructions}; i++ )); do
    if [[ "${instructions:$i:1}" == "L" ]]; then
        kv=prefix_$node
        node=${!kv:0:3}
    elif [[ "${instructions:$i:1}" == "R" ]]; then
        kv=prefix_$node
        node=${!kv:4:3}
    fi
    (( steps++ ))
    if [[ $node == "ZZZ" ]]; then
        break
    fi
    if [[ $i -eq $(( ${#instructions} - 1)) ]]; then
        i=-1
    fi
done

echo "steps: $steps"