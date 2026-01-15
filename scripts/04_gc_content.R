# 04_gc_content.R
# Purpose: Calculate GC content per sample

rm(list = ls())
options(stringsAsFactors = FALSE)

# Load data
dna <- read.csv("data/dna_sequences.csv")

# Function to count nucleotides
count_nucleotides <- function(sequence) {
  bases <- strsplit(sequence, "")[[1]]
  table(bases)
}

# Apply function
nucleotide_counts <- lapply(dna$sequence, count_nucleotides)
names(nucleotide_counts) <- dna$sample_id

# Convert to tidy format
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

# Calculate GC content
gc_content <- aggregate(
  count ~ sample_id,
  data = subset(tidy_counts, base %in% c("G", "C")),
  sum
)

# Add total length per sample
total_length <- aggregate(
  count ~ sample_id,
  data = tidy_counts,
  sum
)

# Merge and calculate proportion
gc_content <- merge(gc_content, total_length, by = "sample_id")
gc_content$gc_fraction <- gc_content$count.x / gc_content$count.y

# Inspect result
gc_content
