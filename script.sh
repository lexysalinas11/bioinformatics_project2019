#usage: bash script.sh proteome/*.fasta ref_seqences/mcrAgene_*.fasta ref_sequences/hsp70gene_*.fasta

#align with mcra gene
for protFile in $1
do
	for mcraFile in $2
	do
		muscle -in $mcraFile -out $protFile
	done
done

#align with hsp70 gene
for file in $1 (or already aligned file)
do
	for hspFile in $3
	do
		#muscle command for alignment
	done
done
