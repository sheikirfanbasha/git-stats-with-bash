checkAndFillNull(){
    retValue=$1
    if [ "$retValue" = "" ]; then
        retValue=0
    fi
    return $retValue
}
echo "{" > lines-year.json
current=$(pwd)
file="$current/lines-year.json"
dirs=($(ls -d $1/*/))
totalCount=${#dirs[*]}
let count=0
pos=$(( ${#dirs[*]} - 1 ))
last=${dirs[$pos]}
for d in "${dirs[@]}"; do
    count=$((count+1))
    percent=$(echo "scale=2; $count/$totalCount * 100" | bc)
    percent=$(echo $percent | cut -d'.' -f 1)
    #show progress percentage
    echo "Progress... $percent%"
    dir_key=$(echo "$d" | rev | cut -d/ -f 2 | rev)
    cd $d
    res=$(git log --since="1 year ago" --author="irfan.sheik@imaginea.com" --pretty=tformat: --numstat | awk '{ add += $1; subs += $2; loc += $1 - $2 } END { printf "added lines: %s, removed lines: %s, total lines: %s\n", add, subs, loc }' -)
    #sample $res = added lines: 101094, removed lines: 2320554, total lines: -2219460
    one=$(echo $res | cut -d',' -f 1)
    two=$(echo $res | cut -d',' -f 2)
    three=$(echo $res | cut -d',' -f 3)
    one_key=$(echo $one | cut -d':' -f 1)
    one_value=$(echo $one | cut -d':' -f 2)
    #fn call to fill null values
    checkAndFillNull $one_value
    #'$?' means the output of the prev. fn call
    one_value=$?
    two_key=$(echo $two | cut -d':' -f 1)
    two_value=$(echo $two | cut -d':' -f 2)
    checkAndFillNull $two_value
    two_value=$?
    three_key=$(echo $three | cut -d':' -f 1)
    three_value=$(echo $three | cut -d':' -f 2)
    checkAndFillNull $three_value
    three_value=$?
    if [[ $d == $last ]]
    then
        echo "\"$dir_key\":{\"$one_key\": $one_value, \"$two_key\": $two_value, \"$three_key\": $three_value}" >> $file    
    else 
        echo "\"$dir_key\":{\"$one_key\": $one_value, \"$two_key\": $two_value, \"$three_key\": $three_value}," >> $file
    fi 
done
echo "}" >> $file
