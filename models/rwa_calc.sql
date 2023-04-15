

WITH rwa AS (
  SELECT *
  , CASE WHEN ASSET_CLASS_IND = 1 THEN
  0.12 * (1 - EXP(-50 * R_PD))/(1 - EXP(-50)) + 0.24 * (1 - (1 - EXP(-50 * R_PD))/(1 - EXP(-50)))
  WHEN ASSET_CLASS_IND = 2 THEN
  0.12 * (1 - EXP(-50 * R_PD))/(1 - EXP(-50)) + 0.24 * (1 - (1 - EXP(-50 * R_PD))/(1 - EXP(-50))) - 0.04 * (1 - (TURNOVER - 5)/45)
  WHEN ASSET_CLASS_IND = 3 THEN
  0.03 * (1 - EXP(-35 * R_PD))/(1 - EXP(-35)) + 0.16 * (1 - (1 - EXP(-35 * R_PD))/(1 - EXP(-35)))
  WHEN ASSET_CLASS_IND = 4 THEN
  0.15
  WHEN ASSET_CLASS_IND = 7 THEN
  (0.12 * (1 - EXP(-50 * R_PD))/(1 - EXP(-50)) + 0.24 * (1 - (1 - EXP(-50 * R_PD))/(1 - EXP(-50)))) * 1.25
  END 
  AS R_ASSET_CORRELATION
  , POWER((0.11852 - 0.05478 * LOG(R_PD)),2) AS b
  , 1 AS R_PD_NORMSINV
  FROM dmn01_rsk_mvs_raw.T2
),

-- rwa2 AS (
--  SELECT *
--, POWER((1 - R_ASSET_CORRELATION),-0.5)*R_PD_NORMSINV+POWER((R_ASSET_CORRELATION/(1 - R_ASSET_CORRELATION)),0.5)*3.090232 AS N
--FROM rwa)

rwa2 AS (
  select
  *
  , {{ cents_to_dollars('BASEL_ASSET_CLASS' | trim) }} as amount_usd
  , {{ normsdist(normsdist_prep('RAND_NORM_1')) }} as normsdist_out
  from rwa
)

SELECT * 
FROM rwa2

