# R code to read in multi-sequence fasta alignment file and remove any position that contains a gap for all taxa
# this is useful when you remove a taxon from an alignment file and that taxon alone contained an indel. 
# reads in multiple fasta alignment files, analyzes them, and reads them back out####
#
library(ape)
library(seqinr)

# read in multiple files
# you should have a directory with all the fasta files you want read in. create a vector of all the files you want to read in
# make sure you remove missing taxa before this, otherwise it causes issues exporting the fasta files
seq_list <- c("test1.fasta", "test2.fasta", "test3.fasta")

# use sapply to read in the alignments from your list. the simplfy = FALSE argquement allows you to keep the names of your files. 
# This places them all into a list of alignments
aligns <- sapply(seq_list, read.alignment, format = "fasta", simplify = FALSE)

# double check
class(aligns[["test1.fasta"]]) # should be alignment

# get rid of columns with all gaps. this needs to be done on an alignment class
aligns_nogaps <- lapply(aligns, del.colgapsonly)
# this converts it into a DNA class
# write it out
mapply(write.dna, aligns_nogaps, file=paste0(names(aligns_nogaps), 'ungapped.fasta'), format = "fasta")
