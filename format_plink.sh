#!/bin/bash

working_dir=/projects/aces/kira/chapter_1_HZ_movement/admixture
old_ped=$working_dir/populations.plink.ped
new_ped=$working_dir/populations.corrected.plink.ped
old_map=$working_dir/populations.plink.map
new_map=$working_dir/populations.corrected.plink.map

cat $old_ped | grep -v "^#" | \
    sed 's/^pr_090/090/' | \
    sed 's/^ru_080/080/' | \
    sed 's/^cg_100/100/' | \
    sed 's/^ss_020/020/' | \
    sed 's/^qp_060/060/' | \
    sed 's/^ro_050/050/' | \
    sed 's/^fc_040/040/' | \
    sed 's/^mr_095/095/' | \
    sed 's/^so_030/030/' > $new_ped

cat $old_map | grep -v "^#" > $new_map

plink --file populations.corrected.plink --make-bed --recode12 --allow-extra-chr 0 --out populations.corrected.plink
