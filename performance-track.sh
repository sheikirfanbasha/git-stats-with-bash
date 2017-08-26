echo "{" > performance.txt
for d in */ ; do
    $(echo "$d" | cut -d'/' -f 1 | echo "\"$d\":") >> performance.txt
    res=$(cd $d && git log --since="Fri Apr 01 00:00:00 2016" --author="irfan.sheik@imaginea.com" --pretty=tformat: --numstat | awk '{ add += $1; subs += $2; loc += $1 - $2 } END { printf "added lines: %s, removed lines: %s, total lines: %s\n", add, subs, loc }' -)
    echo $res
 	#sample $res = added lines: 101094, removed lines: 2320554, total lines: -2219460
    one=$(echo $res | cut -d',' -f 1)
    two=$(echo $res | cut -d',' -f 2)
    three=$(echo $res | cut -d',' -f 3)
    one_key=$(echo $one | cut -d':' -f 1)
    one_value=$(echo $one | cut -d':' -f 2)
    two_key=$(echo $two | cut -d':' -f 1)
    two_value=$(echo $two | cut -d':' -f 2)
    three_key=$(echo $three | cut -d':' -f 1)
    three_value=$(echo $three | cut -d':' -f 2)
    echo "{\"$one_key\": $one_value, \"$two_key\": $two_value, \"$three_key\": $three_value}," >> performance.txt
done
echo "}" >> performance.txt
