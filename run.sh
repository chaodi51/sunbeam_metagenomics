
# ---- Quality control rules
sunbeam run -- --configfile sunbeam_config.yml --cluster "sbatch --job-name=sunbeam --mem=10G -c 4 --time=660" -j 100 -w 60 all_qc
sunbeam run -- --configfile sunbeam_config.yml --cluster "sbatch --job-name=sunbeam --mem=20G -c 4 --time=660" -j 100 -w 60 all_decontam

# ---- Assembly rule
## megahit will use 0.9 of max RAM by default
sunbeam run -- --configfile sunbeam_config.yml --cluster "sbatch --job-name=sunbeam --mem=10G -c 4 --time=660" -j 100 -w 60 all_assembly
sunbeam run -- --configfile sunbeam_config.yml --cluster "sbatch --job-name=sunbeam --mem=10G -c 4 --time=660" -j 100 -w 60 all_coverage

# ---- Contig annotation rules
sunbeam run -- --configfile sunbeam_config.yml --cluster "sbatch --job-name=sunbeam --mem=50G -c 8 --time=9660" -j 100 -w 60 all_annotate

sunbeam run -- --configfile sunbeam_config.yml --cluster "sbatch --job-name=sunbeam --mem=100G -c 4 --time=660" -j 40 -w 60 all_classify

sunbeam run -- --configfile sunbeam_config.yml --cluster "sbatch --job-name=sunbeam --mem=20G -c 4 --time=660" -j 100 -w 60 all_mapping

sunbeam run -- --configfile sunbeam_config.yml --cluster "sbatch --job-name=sunbeam --mem=20G -c 4 --time=660" -j 100 -w 60 all_reports
