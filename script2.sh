#usage: bash script2.sh ref_sequences/mcrAgene_*.fasta ref_sequences/hsp70gene_*.fasta proteomes/*.fasta

for mcraFile in $1
do
cat "$1" >> master_mcrA.fasta | ./muscle -in master_mcrA.fasta -out mcra_align.muscle
done 


