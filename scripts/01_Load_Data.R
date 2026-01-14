# 01_load_data.R
# Purpose: Load and inspect DNA sequence data

# Clear the workspace
rm(list = ls())

# Avoid automatic factor conversion
options(stringsAsFactors = FALSE)

# Load DNA sequence data
dna <- read.csv("data/dna_sequences.csv")

# Inspect the data
str(dna)
head(dna)
