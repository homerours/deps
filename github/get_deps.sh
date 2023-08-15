while read -r line
do 
    folder=${line##*com/}
    author=${folder%/*}
    name=${folder#*/}
    echo $line
    echo $folder $author $name
    mkdir "repos/${author}"
    mv $name "repos/${author}"
    # git clone "$line"
done < deps
