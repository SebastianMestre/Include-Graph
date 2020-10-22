NODE_NAME=$1
awk '{print "\"" $0 "\"" }' | \
awk -v d=", " -v file="$NODE_NAME" '{s=s(NR==1?"":d)$0} END { print "\"" file "\"" (NR > 0?" -> " s:"") ";"}'
