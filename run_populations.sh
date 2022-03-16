#!/bin/bash
#SBATCH -p aces
#SBATCH -N 1
#SBATCH -n 16
#SBATCH -J populations_manacus_long_plink
#SBATCH -t 16:00:00

module load gcc/7.2.0

stacks=/projects/aces/kira/programs/stacks-2.60/bin
popmap_path=/projects/aces/kira/chapter_1_HZ_movement/popmaps/popmap_long_samples.tsv
gstacks_out=/projects/aces/kira/chapter_1_HZ_movement/gstacks_runs/220308_gstacks_rm-pcr-dups_ALL
populations_output_path=/projects/aces/kira/chapter_1_HZ_movement/populations_runs
whitelist_path=/projects/aces/kira/chapter_1_HZ_movement/whitelists/hwe_10000_whitelist.tsv

mac=3
r=0.8
p=9
#populations_output=$populations_output_path/populations_long_only_p${p}_r${r}_mac${mac}_whitelist_10k
populations_output=$populations_output_path/populations_long_only_p9_r0.8_mac3_whitelist_10k
mkdir -p $populations_output

cmd=(
    $stacks/populations
    --in-path $gstacks_out
    --out-path $populations_output
    --popmap $popmap_path
    --threads 16
    --whitelist $whitelist_path
    --plink
)

"${cmd[@]}"
