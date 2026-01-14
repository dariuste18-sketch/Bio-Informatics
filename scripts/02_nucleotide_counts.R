# 02_nucleotide_counts.R
# Purpose: Count nucleotide composition in DNA sequences

rm(list = ls())
options(stringsAsFactors = FALSE)

# Load the data (re-run loading step explicitly)
dna <- read.csv("data/dna_sequences.csv")

# Function to count A, C, G, T
count_nucleotides <- function(sequence) {
  bases <- strsplit(sequence, "")[[1]]
  table(bases)
}

# Apply function to all sequences
nucleotide_counts <- lapply(dna$sequence, count_nucleotides)

# Name results by sample
names(nucleotide_counts) <- dna$sample_id

# Inspect results
nucleotide_counts
