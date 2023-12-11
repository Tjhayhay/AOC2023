#!/bin/bash

# speedfinder.sh <time> <record> 
# will return the total amount of possible answers

time=$1
record=$2

time_array=()
distance=()
for (( i=0; i<$(( time + 1 )); i++ )); do   
    time_array+=("$i")
    distance+=("$i")
done
# time_array=$distance

min=0
max=$(( ${#time_array[@]} -1 ))

while [[ min -lt max ]]
do
    # Swap current first and last elements
    x="${time_array[$min]}"
    time_array[$min]="${time_array[$max]}"
    time_array[$max]="$x"

    # Move closer
    (( min++, max-- ))
done


# echo "time_array: $( echo ${distance[@]} | rev)"
echo "time_array: ${time_array[@]}"
echo "distance  : ${distance[@]}"

for (( i=0; i<$(( time + 1 )); i++ )); do   
    sum_array+=("$(( time_array[$i] * distance[$i] ))")
done

echo "sum_array : ${sum_array[@]}"

for (( i=0; i<${#sum_array[@]}; i++ )); do   
    if [[ ${sum_array[$i]} -gt $record ]]; then
        echo "adding 1 for ${sum_array[$i]}"
        sum=$(( sum + 1 ))
    fi
done

echo "Result: $sum"

# while IFS= read -r line
# do
#     time=$(echo "$line" | awk '{print $2}' | tr -d ':')

#     card=$(echo "$line" | awk '{print $2}' | tr -d ':')
#     echo "card: $card"
#     IFS='|' read -ra entries <<< "${line#*:}"

#     IFS=' ' read -ra answers <<< "${entries[0]}"
#     IFS=' ' read -ra guesses <<< "${entries[1]}"

#     echo "answers: ${answers[@]}"
#     echo "guesses: ${guesses[@]}"

#     # for each answer, check if it's in the guesses
#     for answer in "${answers[@]}"; do
#         # echo "answer: $answer"
#         # if it's in the guesses, remove it from the guesses
#         for guess in "${guesses[@]}"; do
#             # echo "guess: $guess"
#             if [[ $answer == $guess ]]; then
#                 # echo "found $answer in guesses"
#                 count=$((count + 1))
#                 break
#             fi
#         done
#     done
#     echo "count: $count"
#     if [[ $count -eq 0 ]]; then
#         continue
#     else
#         power=$((count - 1))
#         echo "power: $power"
#         (( result+=2**power ))
#         echo "result: $result"
#     fi
    
# done < $1

# echo "Final Result: $result"
