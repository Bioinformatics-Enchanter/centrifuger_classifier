#!/bin/bash

# make directory
mkdir database
cd database

./centrifuger-download -P 16 -o taxonomy taxonomy


#./centrifuger-download -P 16 -o library -d "bacteria" refseq > seqid2taxid.map
#./centrifuger-download -P 16 -o library -d "viral" refseq >> seqid2taxid.map

#custom bacterial genome
./centrifuger-download -P 16 -o library -d "bacteria" -t 1423,562,287,1639,1351,1280,28901,1613,210,2097,570278,12821766,1596,160 refseq > seqid2taxid.map


# add more fungi genome.(these fungi are known as human pathogens and were not present in refseq database )
# taxid was varified with edirect edirect_script.sh
# 17 species of fungi were adde from genbank 

##WARNING: NT_187483.1 is filtered due to its short length (could be from masker)!
##WARNING: NT_187484.1 is filtered due to its short length (could be from masker)!
#WARNING: NT_187485.1 is filtered due to its short length (could be from masker)!
# WARNING: NT_167220.1 is filtered due to its short length (could be from masker)!

./centrifuger-download -P 16 -o library -d "fungi" -t 4932,746128,5059,5061,33178,5476,498019,42374,5478,4909,36911,5480,5482,5207,58839,5551,523103,1208 genbank>> seqid2taxid.map

## Add Human genome
./centrifuger-download -o library -d "vertebrate_mammalian" -a "Chromosome" -t 9606 -c 'reference genome' refseq >> seqid2taxid.map

#Combine all the fasta files in to one input-sequence file
#(combine all fasta files of bacteria)
cd library 
ls


## # Concatenate all .fna files in the directory and
#append to input-sequences.fna
directories=("vertebrate_mammalian" "fungi" "bacteria")
# Iterate over each directory
for dir in "${directories[@]}"; do
    # Concatenate all .fna files in the directory and append to input-sequences.fna
    cat "${dir}"/*.fna.gz >> input-sequences.fna.gz
done


# make new directory to store indxes build by centrifuge-build.
cd ..
ls -lt
mkdir centrifuger_database

## Build index with centrifuge-build command with 16 threads
./centrifuger-build -r library/input-sequences.fna.gz --taxonomy-tree taxonomy/nodes.dmp --name-table taxonomy/names.dmp --conversion-table seqid2taxid.map -o cfr_ref_idx


                 