#!/usr/bin/env bash

products=(
  index-fc_ls # 2 minutes
  index-wofs_ls # 2 minutes
  index-ls8_st # 7 minutes
  index-alos_palsar_mosaic
  index-crop_mask_eastern
  index-ls8_sr # 2 minutes
  index-crop_mask_western
  index-crop_mask_northern
  index-ls5_sr # 5 minutes
  index-s2_l2a # 7 minutes
  index-dem_srtm
  index-gm_ls5_ls7_annual
  index-gm_ls8_annual
  index-gm_s2_annual
  index-ls5_st # 5 minutes
  index-gm_s2_annual_lowres
  index-gm_s2_semiannual
  index-ls7_sr # 7 minutes
  index-io_lulc
  index-jers_sar_mosaic
  index-ls7_st # 7 minutes
  index-pc_s2_annual
  index-rainfall_chirps_monthly
  index-s1_rtc
  index-wofs_ls_summary_alltime
  index-wofs_ls_summary_annual
)

for product in ${products[@]}; do
  make $product &
  while [[ $(jobs -p | wc -l) -ge 2 ]]; do
    sleep 0.5
  done
done
wait

