#Usage: bash scriptNew.sh ref_sequences proteomes <hmmr path>

#combine files for and align McrA gene
cat $1/mcrAgene_* > $1/ref_mcrA.fasta
./muscle -in $1/ref_mcrAgenes.fasta -out align_mcrA.muscle

#combine files for and align hsp70 gene
cat $1/hsp70gene_* > $1/ref_hsp70.fasta
./muscle -in $1/ref_hsp70.fasta -out align_hsp70.muscle

#build hmmr profile
$3/hmmbuild mcrAgene.hmm align_mcrA.muscle
$3/hmmbuild hsp70.hmm align_hsp70.muscle

#search genes for matches
for file in $2/*
do
	$3/hmmsearch --tblout $file"_mcra_table" mcrAgene.hmm
	$3/hmmsearch --tblout $file"_hsp70_table" hsp70.hmm
done



