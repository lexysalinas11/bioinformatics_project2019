#usage: bash scriptFL.sh ref_sequences/mcrAgene_*.fasta ref_sequences/hsp70gene_*.fasta proteomes/*.fasta

#combine mcrA gene files into one fasta file
for fileMCRA in $1
do
cat $fileMCRA >> master_mcra.fasta
done

#combina hsp70 gene files into one fasta file
for fileHSP in $2
do
cat $fileHSP >> master_hsp.fasta
done

#align mcra
./muscle -in master_mcra.fasta -out mcra_align.muscle

#align hsp
./muscle -in master_hsp.fasta -out hsp_align.muscle
