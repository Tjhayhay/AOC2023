sum_ids=0
rc=12
gc=13
bc=14

while IFS= read -r line
do
    unset id
    possible_game="true"
    # set id equal to Game # with awk
    id=$(echo "$line" | awk '{print $2}' | tr -d ':')
    echo "ID: $id"

    # separate out each game
    IFS=';' read -ra game <<< "${line#*:}"
    # for each game, separate out the reveal and the cubes
    for reveal in "${game[@]}"; do
        # echo "Reveal: $reveal"

        # separate out the cubes
        IFS=',' read -ra hand_of_cubes <<< "${reveal}"
        for cubes in "${hand_of_cubes[@]}"; do
            # echo "Cubes: $cubes"
            cube_color=$(echo "$cubes" | awk '{print $2}')
            cube_count=$(echo "$cubes" | awk '{print $1}')
            case $(echo "$cubes" | awk '{print $2}') in
                "red")
                    if [[ ${cube_count} -gt ${rc} ]]; then
                        possible_game="false"; echo "not possible"; break
                    fi
                    ;;
                "green")
                    if [[ ${cube_count} -gt ${gc} ]]; then
                        possible_game="false"; echo "not possible"; break
                    fi
                    ;;
                "blue")
                    if [[ ${cube_count} -gt ${bc} ]]; then
                        possible_game="false"; echo "not possible"; break
                    fi
                    ;;
            esac
            if [[ $possible_game == "false" ]]; then
                break
            fi
        done
    done
    if [[ $possible_game == "true" ]]; then
        # echo "Current Sum: $sum_ids + $id"
        sum_ids=$((sum_ids + id))
    fi
done < $1

echo "Sum IDs: ${sum_ids}"