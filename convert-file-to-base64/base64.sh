#!/bin/bash

input_file="/Users/vivekbangare/demo/config"
output_file="/Users/vivekbangare/demo/base64_output"

base64_content=$(base64 -i "$input_file")
echo "$base64_content" > "$output_file"
