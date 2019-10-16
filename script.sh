#usage: bash script.sh ref_seqences/mcrAgene_*.fasta ref_sequences/hsp70gene_*.fasta proteomes/*.fasta

#align mcra gene
cat $1 > masterMCRA.fasta
./muscle -in masterMCRA.fasta -out mcra_align.muscle

#align hsp70 genes
cat $2 > masterHSP.fasta
./muscle -in masterHSP.fasta -out hsp_align.muscle

