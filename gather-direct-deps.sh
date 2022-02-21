FILE=$(realpath $1)
DIR=$(dirname $FILE)

# echo $1 >&2
# exit

DATA=$(grep '#include ".*"' $FILE \
| sed 's/#include "\(.*\)"/\1/g' \
| awk -v dir="$DIR" '{print dir "/" $1}')

if [ ! -z "$DATA" ]
then
	echo $DATA \
	| xargs realpath \
	| awk -v file="$FILE" '{ print file, $1 }'
fi
