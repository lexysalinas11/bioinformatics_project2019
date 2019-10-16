#usage: bash script2.sh ref_sequences/mcrAgene_*.fasta ref_sequences/hsp70gene_*.fasta proteomes/*.fasta

cat "$1" > master_mcrA.fasta
./muscle -in master_mcrA.fasta -out mcra_align.muscle

cat "$2" > master_hsp70.fasta
./muscle -in master_hsp70.fasta -out hsp70_align.muscle
