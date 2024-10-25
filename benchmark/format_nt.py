# Libraries
import os

import pandas as pd
from Bio import SeqIO

# Format Nucleotide Transformer task to (sequence, label)
input_dir='/uufs/chpc.utah.edu/common/home/sundar-group2/ANISA/RAW_DATA/nucleotide_transformers_downstream_tasks/promoter_all'
records = []

for filename in os.listdir(input_dir):
    f = os.path.join(input_dir, filename)
    if os.path.isfile(f):
        for record in SeqIO.parse(f, 'fasta'):
            filename = os.path.basename(f)
            name = filename.split('.')[0]
            segment = str(record.name)
            seq = str(record.seq).upper()
            label = segment.split("|")[-1]

            records.append(
            {
                'sequence': seq,
                'label': label
            }
            )

df = pd.DataFrame(data=records)

formatted = df[['sequence', 'label']]
formatted.to_csv(input_dir + '/full.csv', encoding='utf-8', index=False, header=True) 