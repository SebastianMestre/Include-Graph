rm -f result.dot
echo "digraph G {" > result.dot
for file in $(find . -name '*.cpp' -or -name '*.hpp')
do
	mkdir -p "_graph/$(dirname $file)"
	./gather-direct-deps.sh $file | \
	./lines-to-node.sh $(realpath $file) >> \
	result.dot
done
echo "}" >> result.dot
#sed -i "s/\/home\/sebastian\/Programming\/C++\/Jasper\/src//g" result.dot
fdp result.dot -Tsvg > result.svg
