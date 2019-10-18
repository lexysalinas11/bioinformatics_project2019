#Usage: bash scriptNew.sh ref_sequences proteomes <muscle path> <hmmr path> <mcra output> <hsp output>

#combine files for and align McrA gene
cat $1/mcrAgene_* > $1/ref_mcrA.fasta
$3 -in $1/ref_mcrAgenes.fasta -out align_mcrA.muscle

#combine files for and align hsp70 gene
cat $1/hsp70gene_* > $1/ref_hsp70.fasta
$3 -in $1/ref_hsp70.fasta -out align_hsp70.muscle

#build hmmr profile
$4/hmmbuild mcrAgene.hmm align_mcrA.muscle
$4/hmmbuild hsp70.hmm align_hsp70.muscle

#search genes for matches
for file in $2/*
do
	$4/hmmsearch --tblout $file"_mcra_table" mcrAgene.hmm $file
	$4/hmmsearch --tblout $file"_hsp70_table" hsp70.hmm $file
done

#search for combined proteome sequences in hmmr profile
$4/hmmsearch -o $5 hsp70.hmm $2/proteome_combined.fasta
$4/hmmsearch -o $6 mcra_results.  mcrAgene.hmm $2/proteome_combined.fasta





