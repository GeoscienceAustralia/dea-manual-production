find $1 -type d -print0 | while read -d '' -r dir; do
    files=("$dir"/*)
    printf "%s  %5d\n" "$dir" "${#files[@]}"
done | sort

#find . -maxdepth 1 -type d | sort; do y=find $x | wc -l; echo $y,$x; done
