# 03_tidy_nucleotide_counts.R
# Purpose: Convert nucleotide counts into tidy format

rm(list = ls())
options(stringsAsFactors = FALSE)

# Load data
dna <- read.csv("data/dna_sequences.csv")

# Function from previous script
count_nucleotides <- function(sequence) {
  bases <- strsplit(sequence, "")[[1]]
  table(bases)
}

# Apply function
nucleotide_counts <- lapply(dna$sequence, count_nucleotides)
names(nucleotide_counts) <- dna$sample_id

# Convert list of tables into tidy data frame
tidy_counts <- do.call(
  rbind,
  lapply(names(nucleotide_counts), function(sample) {
    data.frame(
      sample_id = sample,
      base = names(nucleotide_counts[[sample]]),
      count = as.integer(nucleotide_counts[[sample]])
    )
  })
)

# Inspect tidy result
tidy_counts
