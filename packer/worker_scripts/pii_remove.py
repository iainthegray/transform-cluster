import argparse
import boto3
import re
import scrubadub
import botocore

# Set up arg parser
parser = argparse.ArgumentParser(
            description='A script that takes a text file and anonymises any PII and writes it out')
parser.add_argument('-i', '--input', help="Input file", nargs='?')

args = parser.parse_args()

"""
This script relies on receiving an input file from S3 with a format of
https://s3-[region].amazonaws.com/[bucket_name]/source/[file_name]

it saves to:
[bucket from source] /done/[file_name].transformed

"""
# https://s3-eu-west-1.amazonaws.com/irg-personal/s3-version-test.txt.txt
temp_in_file = "tmp_s3_file.txt"
temp_out_file = "tmp_s3_file.transformed"


def get_bucket_and_file(my_input):
    """
    :param my_input: an s3 URL of a file to download
    :return: the bucket, input file, output file
    """
    # print('INPUT = {}'.format(input))
    a = re.split('//', my_input)
    bucket_name = re.split('/', a[1])[1]
    source_file = re.split(bucket_name+'/', a[1])[1]
    dest_file = 'done/' + re.split('/', source_file)[-1] + '.transformed.txt'
    # dest_file = re.split('/', source_file)[-1] + '.transformed'
    print('BUCKET = {}, SOURCE = {}, DEST = {}'.format(bucket_name, source_file, dest_file))
    return bucket_name, source_file, dest_file


if args.input is None:
    print("Error Args are None")
    exit(1)
else:
    mybucket, infile, outfile = get_bucket_and_file(args.input)
    s3 = boto3.resource('s3')
    try:
        s3.meta.client.download_file(mybucket, infile, temp_in_file)
    except botocore.exceptions.ClientError as e:
        if e.response['Error']['Code'] == "404":
            print("The object does not exist.")
        else:
            print('Error getting file {}, {}, {} {}'.format(mybucket, infile, temp_in_file, e))
    fh = open(temp_in_file, "r")
    mytext = fh.read()
    clean = scrubadub.clean(mytext)
    print('Cleaned text')
    # print(clean)
    fh.close()
    fh2 = open(temp_out_file, 'w')
    fh2.write(clean)
    fh2.close()
    print("written clean to {}".format(temp_out_file))

    s3.meta.client.upload_file(temp_out_file, mybucket, outfile)
    print('file uploaded to {} - {}'.format(mybucket, outfile))
