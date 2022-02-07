
## count total reads
cat  DYNAMIC_metagenomics_2020_all_samples_metadata.txt |cut -f20 > sampleID
rm -rf foo
for j in `sed 1d  DYNAMIC_metagenomics_2020_all_samples_metadata.txt|cut -f20 `;do echo $j;

	zcat sunbeam_output/qc/decontam/$j\_1.fastq.gz | echo $((`wc -l`/4)) >> foo
done
paste sampleID foo > total_reads.txt
awk '{for (i=3; i<=NF; i++) {if ($i) {print; next}}}'  DYNAMIC_metagenomics_2020_reads_map_toArcOperon.txt  > DYNAMIC_metagenomics_2020_reads_map_toArcOperon_at_least1.txt

awk 'BEGIN{FS=OFS="\t"} {print $20"\t"$9}'  DYNAMIC_metagenomics_2020_all_samples_metadata.txt >  DYNAMIC_metagenomics_2020_reads_map_toArcOperon.txt
for i in `ls sunbeam_output/mapping/|grep -v intermediates `;do echo $i;
	echo $i >  $i.reads_map_toArcOperon.txt
	for j in `sed 1d  DYNAMIC_metagenomics_2020_all_samples_metadata.txt|cut -f20 `;do
		samtools view -c -F 260 sunbeam_output/mapping/$i/$j.bam > $i.$j.reads_map_toArcOperon.txt
		cat $i.reads_map_toArcOperon.txt $i.$j.reads_map_toArcOperon.txt > foo1
		mv foo1 $i.reads_map_toArcOperon.txt
		rm $i.$j.reads_map_toArcOperon.txt
	done	
		paste DYNAMIC_metagenomics_2020_reads_map_toArcOperon.txt $i.reads_map_toArcOperon.txt > foo
		mv foo DYNAMIC_metagenomics_2020_reads_map_toArcOperon.txt
		rm $i.reads_map_toArcOperon.txt
done
