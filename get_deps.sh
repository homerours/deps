while read -r line
do 
    git clone "$line"
done < deps
