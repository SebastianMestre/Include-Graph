rm -f result.dot

TF="pass1.txt"
TF2="pass2.txt"

rm $TF
touch $TF
for file in $(find . -name '*.cpp' -or -name '*.hpp')
do
	./gather-direct-deps.sh $file >> $TF
done

HERE=$(realpath .)
rm $TF2
touch $TF2
for file in $(cat $TF)
do
	realpath --relative-to=$HERE "$file" >> $TF2
done

echo "digraph G {" > result.dot
echo "overlap = false;" >> result.dot

# add lines like the following after the awk invocation to filter files out
# | grep 'pattern' -v \

awk 'NR % 2 == 1 { o = $0; next} { print o " " $0 }' $TF2 \
| ./lines-to-node.sh \
>> result.dot

echo "}" >> result.dot

fdp result.dot -Tsvg > result_fdp.svg
dot result.dot -Tsvg > result_dot.svg
neato result.dot -Tsvg > result_neato.svg
twopi result.dot -Tsvg > result_twopi.svg
