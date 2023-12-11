#!/bin/bash
while IFS= read -r line
do
    count=0
    card=$(echo "$line" | awk '{print $2}' | tr -d ':')
    echo "card: $card"
    IFS='|' read -ra entries <<< "${line#*:}"

    IFS=' ' read -ra answers <<< "${entries[0]}"
    IFS=' ' read -ra guesses <<< "${entries[1]}"

    echo "answers: ${answers[@]}"
    echo "guesses: ${guesses[@]}"

    # for each answer, check if it's in the guesses
    for answer in "${answers[@]}"; do
        # echo "answer: $answer"
        # if it's in the guesses, remove it from the guesses
        for guess in "${guesses[@]}"; do
            # echo "guess: $guess"
            if [[ $answer == $guess ]]; then
                # echo "found $answer in guesses"
                count=$((count + 1))
                break
            fi
        done
    done
    echo "count: $count"
    if [[ $count -eq 0 ]]; then
        continue
    else
        power=$((count - 1))
        echo "power: $power"
        (( result+=2**power ))
        echo "result: $result"
    fi
    
done < $1

echo "Final Result: $result"
