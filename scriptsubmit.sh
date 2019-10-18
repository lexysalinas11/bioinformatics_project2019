#bash scriptsubmit.sh ref_sequences proteomes ./muscle ./bin 

#combine files for and align McrA gene
cat $1/mcrAgene_* > $1/ref_mcrA.fasta
$3 -in $1/ref_mcrAgenes.fasta -out align_mcrA.muscle

#combine files for and align hsp70 gene
cat $1/hsp70gene_* > $1/ref_hsp70.fasta
$3 -in $1/ref_hsp70.fasta -out align_hsp70.muscle

#build hmmr profile
$4/hmmbuild mcrAgene.hmm align_mcrA.muscle
$4/hmmbuild hsp70.hmm align_hsp70.muscle

#hmmsearch for proteome genomes for mcrA gene presence
#output to .tbl 
for sample in proteomes/proteome*.fasta
do
tblname=$(echo $sample | sed 's/.fasta/mcrA/')
$4/hmmsearch --tblout $tblname.tbl mcrA.hmm $sample
done
	
#line count in mcrA tables and list of proteomes
for tbl in proteomes/proteome_*mcrA.tbl
do
echo "$tbl $(cat $tbl | wc -l)" >> mcrAcnt.txt
done
	
#13 lines/proteomes dont have mcrA gene so we remove them
#the remaining proteomes do have mcrA gene so we put them into a new file 
cat mcrAcnt.txt | grep -v "13" > mcrAhits.txt
cat mcrAhits.txt | cut -d " " -f 1 | sed 's/mcrA.tbl/.fasta/' > hmmsearch.txt	

#new file used in hmmsearch to count hsp70 sequences 
for sample in $(cat hmmsearch.txt )
do
tblname=$(echo $sample | sed 's/.fasta/hsp70/')
$4/hmmsearch --tblout $tblname.tbl hsp70.hmm $sample
done

#new proteome file created with line counts for hsp70 genes
for file in proteomes/proteome_*hsp70.tbl
do
	echo "$file $(cat $file | wc -l)" >> proteomelist.txt
	done

#new proteome file reversed for highest hsp70 gene # to be first and winners.txt is final output
echo "The best isolates to move forward with are:" > winners.txt
cat proteomelist.txt | sort -k2 -r | cut -d " " -f 1 | sed 's/proteomes\///' | sed 's/hsp70.tbl//' >> winners.txt




