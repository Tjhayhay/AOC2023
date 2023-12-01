set -e
unset final_result

while IFS= read -r line
do
    unset calibration_number
    # echo "Line: $line"
    for direction in "1" "-1"
    do
        unset current_word
        unset number
        #find first number
        for (( i=0; i<${#line}; i++ )); do
            index=$((i * direction))
            if [[ $direction == "-1" ]]; then
                index=$((index - 1))
            fi
            # echo "Index: $index"
            # echo "Char: ${line: $index:1}"
            if [[ ${line: $index:1} =~ ^[0-9]+$ ]]; then
                number=${line: $index:1}
                # echo "FOUND Number: $number"
                i=${#line}
            elif [[ ${line: $index:1} =~ ^[a-z]+$ ]]; then
                # check if current_word variable is empty
                if [[ -z ${current_word} ]]; then
                    # check if there are enough letters for a word
                    # if [[ ${#line: $index} -le 3 ]]; then
                    #     break
                    # fi
                    current_word=${line: $index:1}
                    # break
                else # add letter to the current_word
                    if [[ $direction == "1" ]]; then
                        current_word=${current_word}${line: $index:1}
                    else
                        current_word=${line: $index:1}${current_word}
                    fi
                    # check if there are enough letters for a word
                    if [[ ${#current_word} -ge 3 ]]; then
                        # echo "Current word: $current_word"
                        # check if current_word is a number
                        if [[ ${current_word} == *"one"* ]]; then
                            number=1
                            # echo "FOUND Number: $number"
                            i=${#line}
                        elif [[ ${current_word} == *"two"* ]]; then
                            number=2
                            # echo "FOUND Number: $number"
                            i=${#line}
                        elif [[ ${current_word} == *"three"* ]]; then
                            number=3
                            # echo "FOUND Number: $number"
                            i=${#line}
                        elif [[ ${current_word} == *"four"* ]]; then
                            number=4
                            # echo "FOUND Number: $number"
                            i=${#line}
                        elif [[ ${current_word} == *"five"* ]]; then
                            number=5
                            # echo "FOUND Number: $number"
                            i=${#line}
                        elif [[ ${current_word} == *"six"* ]]; then
                            number=6
                            # echo "FOUND Number: $number"
                            i=${#line}
                        elif [[ ${current_word} == *"seven"* ]]; then
                            number=7
                            # echo "FOUND Number: $number"
                            i=${#line}
                        elif [[ ${current_word} == *"eight"* ]]; then
                            number=8
                            # echo "FOUND Number: $number"
                            i=${#line}
                        elif [[ ${current_word} == *"nine"* ]]; then
                            number=9
                            # echo "FOUND Number: $number"
                            i=${#line}
                        fi
                    fi
                fi
            fi
        done
        calibration_number=${calibration_number}${number}
    done

    # echo "Cali: ${calibration_number}"
    final_result=$((final_result + calibration_number))
    # echo "Current result: $final_result "
done < ./input.txt

echo "Final result: ${final_result}"