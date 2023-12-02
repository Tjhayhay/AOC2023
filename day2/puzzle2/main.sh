sum_ids=0
while IFS= read -r game
do
    unset id
    min_rc=1
    min_gc=1
    min_bc=1
    possible_game="true"
    # set id equal to Game # with awk
    id=$(echo "$game" | awk '{print $2}' | tr -d ':')
    echo "ID: $id"

    # separate out each game
    IFS=';' read -ra game <<< "${game#*:}"
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
                    if [[ ${cube_count} -gt ${min_rc} ]]; then
                        min_rc=${cube_count};
                    fi
                    ;;
                "green")
                    if [[ ${cube_count} -gt ${min_gc} ]]; then
                        min_gc=${cube_count};
                    fi
                    ;;
                "blue")
                    if [[ ${cube_count} -gt ${min_bc} ]]; then
                        min_bc=${cube_count};
                    fi
                    ;;
            esac
        done
    done
    # echo "Final Min RC: $min_rc Final Min GC: $min_gc Final Min BC: $min_bc"
    power_of_cubes=$((min_rc * min_gc * min_bc))
    sum_of_powers=$((sum_of_powers + power_of_cubes))
    echo "total: Sum Of Powers: $sum_of_powers + $power_of_cubes"

done < $1

echo "Sum Of Powers: ${sum_of_powers}"