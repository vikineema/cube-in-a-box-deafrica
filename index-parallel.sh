#!/usr/bin/env bash

products=(
  fc_ls
  ls7_st
  ls8_sr
  s2_l2a
  dem_srtm
  io_lulc
  wofs_ls_summary_annual
  rainfall_chirps_monthly
  wofs_ls_summary_alltime
  pc_s2_annual
  s1_rtc
  gm_ls5_ls7_annual
  gm_ls8_annual
  gm_s2_annual
  gm_s2_annual_lowres
  gm_s2_semiannual
  ls5_sr
  ls5_st
  ls7_sr
  ls8_st
  wofs_ls
)

for product in ${products[@]}; do
  make index-$product &
  while [[ $(jobs -p | wc -l) -ge 3 ]]; do
    sleep 0.5
  done
done
wait


# dem_srtm 0 35 seconds
# fc_ls 1091 18 minutes
# gm_ls5_ls7_annual 0 7 seconds
# gm_ls8_annual 0 3 seconds
# gm_s2_annual 0 2 seconds
# gm_s2_annual_lowres 0 2 seconds
# gm_s2_semiannual 0 1 second
# io_lulc 0 1 second
# ls5_sr 0 40 seconds
# ls5_st 0 2 seconds
# ls7_sr 397 5.5 minutes
# ls7_st 397 10 minutes
# ls8_sr 695 7 minutes
# ls8_st 695 7 minutes
# pc_s2_annual 0 3 seconds
# rainfall_chirps_monthly 2 2 seconds
# s1_rtc 6140 4 minutes
