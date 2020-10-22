FILE=$(realpath $1)
DIR=$(dirname $FILE)
grep '#include ".*"' $FILE     | \
sed 's/#include "\(.*\)"/\1/g' | \
awk -v dir="$DIR" '{print dir "/" $1}' | \
xargs realpath
