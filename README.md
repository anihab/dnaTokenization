The bash script **vocabulary.sh** runs **build_vocabulary.py** on Bridges. 

The file paths and vocabulary size parameter are hard-coded in **build_vocabulary.py**. 

```
VOCAB_SIZE=4096
INPUT_PATH="/path/to/bacteria_data"
OUTPUT_PATH="/path/to/output_directory"
```

Running the script will save the vocabulary json file to the `OUTPUT_PATH` as `vocabulary_VOCAB_SIZE.json`.

The `/data` subdirectory includes my output on the bacteria data for vocabulary sizes: 4096, 8192, 32768, 16384.
