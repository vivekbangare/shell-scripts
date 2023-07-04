#!/bin/bash

bucket_name=demo-3-6
search_dir=/Users/vivekbangare/demo/aws
echo "Enter the file name for download: "  
read file_name 

if [[ ! -f $search_dir/$file_name ]]
then
    echo "$file_name does not exist on your filesystem."
    aws s3 ls s3://$bucket_name --recursive | awk {'print $4'} | grep $file_name || not_exist=true 
    if [ $not_exist ]; then
      echo "$file_name does not exist in $bucket_name bucket also"
    else
      echo "Downloading your file, please wait..."
      aws s3 cp s3://$bucket_name/$file_name $search_dir/$file_name
      echo "Downloading Done successfully..!"
    fi
else
  echo "File already exists"
fi

#check Multiupload file

#if [[ aws s3api list-multipart-uploads --bucket demo-3-6 | jq -r '.Uploads[].Key' -eq OnVUE-3.53.42.zip ]]
#then
#  echo "multipart file"
#else
#  echo "normal file"
#fi