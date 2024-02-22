## # Concatenate all .fna files in the directory and
#append to input-sequences.fna
directories=("fungi" "bacteria")
# Iterate over each directory
for dir in "${directories[@]}"; do
    # Concatenate all .fna files in the directory and append to input-sequences.fna
    cat "${dir}"/*.fna.gz >> input-sequences.fna.gz
done


## Build index with centrifuge-build command with 16 threads
./centrifuger-build -t 16 -r library/input-sequences.fna.gz --taxonomy-tree taxonomy/nodes.dmp --name-table taxonomy/names.dmp --conversion-table seqid2taxid.map


