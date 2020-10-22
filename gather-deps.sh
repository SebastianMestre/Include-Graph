FILE=$(realpath $1)
mkdir -p _graph
cpp -MM $FILE               | \
cpp -P                      | \
tr ' ' '\n'                 | \
xargs realpath              | \
awk '{if(NR > 2) print $0}'
