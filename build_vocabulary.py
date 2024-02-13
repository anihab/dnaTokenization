import os
import csv

from tokenizers import Tokenizer, models, trainers, normalizers

VOCAB_SIZE=32768
INPUT_PATH="/ocean/projects/bio230026p/lindseyl/DATA/SEGMENTS/bacteria"
OUTPUT_PATH="/ocean/projects/bio230026p/ahabib/VOCABULARY_OUTPUT"

def sequence_iterator():
  if os.path.isdir(INPUT_PATH):
        for filename in os.listdir(INPUT_PATH):
          f = os.path.join(INPUT_PATH, filename)
          with open(f, 'r') as file:
            csv_reader = csv.reader(file)
            for row in csv_reader:
              # ensure the correct number of columns exists
              if len(row) > 4:
                seq = row[4]
                # min sequence length = 1500
                if len(seq) >= 1500:
                  yield seq

def build_vocab():
  tokenizer = Tokenizer(models.BPE())
  tokenizer.normalizer = normalizers.Sequence([normalizers.NFKC()])
  trainer = trainers.BpeTrainer(vocab_size=VOCAB_SIZE)
  tokenizer.train_from_iterator(sequence_iterator(), trainer=trainer)
  tokenizer.save(OUTPUT_PATH + "/vocabulary_" + VOCAB_SIZE + ".json")

build_vocab()