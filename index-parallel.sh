#!/usr/bin/env bash
make index-s2_l2a & # 30 minutes
(
  make index-dem_srtm &
  make index-io_lulc &
  make index-wofs_ls_summary_annual &
  make index-rainfall_chirps_monthly &
  make index-wofs_ls_summary_alltime &
  wait
)
(
  make index-pc_s2_annual & # 30 seconds
  make index-s1_rtc & # 20 seconds
  make index-gm_ls5_ls7_annual & # 30 seconds
  make index-gm_ls8_annual & # 20 seconds
  wait
)
(
  make index-gm_s2_annual & # 15 seconds
  make index-gm_s2_annual_lowres & # 3 seconds
  make index-gm_s2_semiannual & # 22 seconds
  wait
)
(
  make index-ls5_sr & # 5 minutes
  make index-ls5_st & # 5 minutes
  make index-ls7_sr & # 7 minutes
  wait
)
(
  make index-ls7_st & # 7 minutes
  make index-ls8_sr & # 5 minutes
  make index-ls8_st & # 4 minutes
  make index-fc_ls & # 8 minutes
  wait
)
make index-wofs_ls & # 12 minutes
wait
