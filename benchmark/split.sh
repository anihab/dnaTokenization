#!/bin/bash

# Define
output_path=""

# sed 1d $output_path/test.csv > $output_path/test_without_header.csv
# cat $output_path/train.csv $output_path/test_without_header.csv > $output_path/full.csv
# rm $output_path/test_without_header.csv

full_file="$output_path/full.csv"
# train_file="$output_path/train.csv"
# test_file="$output_path/test.csv"
# dev_file="$output_path/dev.csv"

# Set the train-test-dev split ratios
train_ratio=0.8
test_ratio=0.1
dev_ratio=0.1

# Run Python script to perform train-test-dev split
python_script=$(cat << END
import pandas as pd
from sklearn.model_selection import train_test_split

# Load the input CSV files
full_data = pd.read_csv("$full_file")

# Perform train-test-dev split
train_data, temp_data = train_test_split(full_data, train_size=$train_ratio, test_size=$test_ratio+ $dev_ratio)

# Perform test-dev split on the remaining data
test_data, dev_data = train_test_split(temp_data, train_size=$test_ratio/($test_ratio + $dev_ratio), test_size=$dev_ratio/($test_ratio + $dev_ratio))

# Save train, test, and dev data to separate CSV files
train_data.to_csv("$output_path/train.csv", index=False)
test_data.to_csv("$output_path/test.csv", index=False)
dev_data.to_csv("$output_path/dev.csv", index=False)

END
)

# Execute the Python script
python3 -c "$python_script"

# # Set the headers for train, test, and dev files
# touch $output_path/temp.csv
# temp_file=$output_path/temp.csv

# echo "sequence,label" | cat - "$train_file" > "$temp_file"
# mv "$temp_file" "$train_file"

# echo "sequence,label" | cat - "$test_file" > "$temp_file"
# mv "$temp_file" "$test_file"

# echo "sequence,label" | cat - "$dev_file" > "$temp_file"
# mv "$temp_file" "$dev_file"
