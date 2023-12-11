#!/bin/bash
file_length=$(wc -l $1 | awk '{print $1}')
# total_cards=$((file_length))
# echo "file_length: $file_length"

for ((i=0; i<=$((file_length - 1)); i++)); do
    # echo adding 1 to card_count
    card_count+=("1")
done

# echo "card_count: ${card_count[@]}"

current_card=0
while IFS= read -r line
do
    count=0
    card=$(echo "$line" | awk '{print $2}' | tr -d ':')
    echo "card: $card"
    echo "card_count[$current_card]: ${card_count[$current_card]}"
    IFS='|' read -ra entries <<< "${line#*:}"

    IFS=' ' read -ra answers <<< "${entries[0]}"
    IFS=' ' read -ra guesses <<< "${entries[1]}"

    # echo "answers: ${answers[@]}"
    # echo "guesses: ${guesses[@]}"

    # for each answer, check if it's in the guesses
    # while [[ ${card_count[$current_card]} -gt 0 ]]; do
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
        # echo "count: $count"
        if [[ $count -ne 0 ]]; then
            # c style for loop
            for ((i=1; i<=$((count)); i++)); do
                y=$(( current_card + i ))
                z=$((${card_count[$current_card]} ))
                echo "adding $z to card_count[$y]: ${card_count[$y]}"
                card_count[$y]=$(( card_count[$y] + z))
                total_cards=$((total_cards + z))
            done

            # power=$((count - 1))
            # echo "power: $power"
            # (( result+=2**power ))
            # echo "result: $result"
            count=0
        fi
        total_cards=$((total_cards + 1))
        card_count[$current_card]=$(( card_count[$current_card] - 1))
        echo "removed 1 card_count[$current_card]: ${card_count[$current_card]}"
    # done
    ((current_card+=1))
    
done < $1

echo "Final Result: $result"
echo "Total Cards: $total_cards"
