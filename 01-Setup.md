# Setup


```r
suppressPackageStartupMessages(library(ED.Hydro.Helpers))
suppressPackageStartupMessages(library(rlang))
suppressPackageStartupMessages(library(knitr))
suppressPackageStartupMessages(library(tidyverse))
options(digits = 10)

knitr::include_graphics("ED_HYDRO.png")
```

<img src="ED_HYDRO.png" width="1607" />

```r
bety <- betyConnect("/fs/data3/ecowdery/pecan/web/config.php")
PFT3_defaults_history <- "/fs/data3/ecowdery/ED.Hydro/parameters/pft3_defaults_history.xml"

stats <- c("theor.min",
           "low.025", 
           "low.25", 
           "mean",
           "upp.75",
           "upp.975",
           "theor.max")

priors <- prior_load_data(download = FALSE, subset = TRUE)
```

```
## [1] "leaf_psi_tlp"   "wood_psi_tlp"   "rwc_tlp_wood"   "leaf_density"  
## [5] "leaf_psi_min"   "leaf_water_cap" "wood_psi_min"   "wood_water_cap"
```

```r
kable(priors)
```



ED_name            Christoffersen_name    BETY_variable_id   BETY_prior_id  ED_units              Christoffersen_units    theor.min   low.025   low.25    mean   upp.75   upp.975   theor.max
-----------------  --------------------  -----------------  --------------  --------------------  ---------------------  ----------  --------  -------  ------  -------  --------  ----------
wood_Kexp          avuln_node                   1000000291      1000000361  unitless              unitless                    1e-01      1.00     10.0      NA      100    200.00          NA
leaf_elastic_mod   epsil_node                   1000000294      1000000387  MPa                   MPa                         1e+00      5.00       NA   20.00       NA     50.00          NA
wood_elastic_mod   epsil_node                           NA              NA  MPa                   MPa                         1e+00      5.00       NA   20.00       NA     50.00          NA
wood_Kmax          kmax_node                    1000000290      1000000357  kg H2O / m / s        kg m-1 s-1 MPa-1            1e-02      0.10      0.5      NA        5     10.00          NA
wood_psi50         p50_node                     1000000289      1000000360  m                     MPa                         1e-01      0.50      1.0      NA        4      6.00          NA
leaf_psi_osmotic   pinot_node                   1000000295      1000000388  m                     MPa                         1e-01      0.50       NA    2.00       NA      4.00          NA
wood_psi_osmotic   pinot_node                   1000000298              NA  m                     MPa                         1e-01      0.50       NA    2.00       NA      4.00          NA
leaf_psi_tlp       pitlp_node                   1000000284      1000000384  m                     MPa                         5e-01        NA       NA      NA       NA        NA        6.00
wood_psi_tlp       pitlp_node                   1000000301              NA  m                     MPa                         1e-01        NA       NA      NA       NA        NA          NA
rwc_tlp_wood       rwctlp_node                  1000000296              NA  unitless              unitless                       NA        NA       NA      NA       NA        NA          NA
leaf_water_sat     thetas_node                  1000000285      1000000358  kg H2O/kg biomass     kg kg-1                     1e-02      0.40       NA    0.65       NA      0.88        0.99
wood_water_sat     thetas_node                  1000000286      1000000359  kg H2O/kg biomass     kg kg-1                     5e-02      0.35       NA      NA       NA      0.80        0.90
leaf_density       NA                                   NA              NA  kg/m3                 NA                          1e-07        NA       NA      NA       NA        NA     2000.00
leaf_psi_min       NA                           1000000299      1000000392  m                     NA                          1e-01        NA       NA      NA       NA        NA      700.00
leaf_water_cap     NA                           1000000287      1000000390  kg H2O/kg biomass/m   NA                          1e-07        NA       NA      NA       NA        NA          NA
wood_psi_min       NA                           1000000300              NA  m                     NA                          1e-01        NA       NA      NA       NA        NA          NA
wood_water_cap     NA                           1000000288      1000000391  kg H2O/kg biomass/m   NA                          1e-07        NA       NA      NA       NA        NA          NA

```r
load("/fs/data3/ecowdery/ED.Hydro/parameters/prior_calculations/prior_data/accepted_dists.Rdata")
```
