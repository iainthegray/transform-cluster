#!/bin/bash
#
# Usage == letter_sub.sh INPUT_FILE OUTPUT_FILE

INPUT_FILE=$1
OUTPUT_FILE=`echo $INPUT_FILE | sed 's/^.*\///'`_transformed
TMP_FILE=mytmp.txt


echo "Output = $OUTPUT_FILE"
echo "INPUT = $INPUT_FILE"


# if [ ! -e $INPUT_FILE ]; then
#   echo "Missing input file!"
#   exit 1
# fi
aws s3 cp $INPUT_FILE $TMP_FILE
cat $TMP_FILE|sed 's/e/%/g' > ${OUTPUT_FILE}
aws s3 cp ${OUTPUT_FILE} s3://transform-bucket-irg-test/done/${OUTPUT_FILE}
