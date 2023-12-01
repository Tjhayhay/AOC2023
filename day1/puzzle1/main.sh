final_result=0
while IFS= read -r line
do
    unset number
    number=$(echo "$line" | grep -o '[0-9]*')
    final_result=$((final_result + ${number:0:1}${number: -1} ))
done < ./input.txt

echo "Final result: ${final_result}"