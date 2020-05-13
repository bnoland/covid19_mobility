# Examining the *unprocessed* Google mobility data for the United States

Missing value counts for each variable.

``` r
raw_us_data %>%
  map(~ sum(is.na(.x)))
```

    ## $country_region_code
    ## [1] 0
    ## 
    ## $country_region
    ## [1] 0
    ## 
    ## $sub_region_1
    ## [1] 76
    ## 
    ## $sub_region_2
    ## [1] 3952
    ## 
    ## $date
    ## [1] 0
    ## 
    ## $retail_and_recreation_percent_change_from_baseline
    ## [1] 45790
    ## 
    ## $grocery_and_pharmacy_percent_change_from_baseline
    ## [1] 51807
    ## 
    ## $parks_percent_change_from_baseline
    ## [1] 151545
    ## 
    ## $transit_stations_percent_change_from_baseline
    ## [1] 125738
    ## 
    ## $workplaces_percent_change_from_baseline
    ## [1] 9634
    ## 
    ## $residential_percent_change_from_baseline
    ## [1] 111643

Unique country codes in the data. Only the United States, as expected.

``` r
raw_us_data %>%
  pull(country_region) %>%
  unique()
```

    ## [1] "United States"

All the states represented in the data. Note that “NA” denotes
national-level data.

``` r
raw_us_data %>%
  pull(sub_region_1) %>%
  unique()
```

    ##  [1] NA                     "Alabama"              "Alaska"               "Arizona"             
    ##  [5] "Arkansas"             "California"           "Colorado"             "Connecticut"         
    ##  [9] "Delaware"             "District of Columbia" "Florida"              "Georgia"             
    ## [13] "Hawaii"               "Idaho"                "Illinois"             "Indiana"             
    ## [17] "Iowa"                 "Kansas"               "Kentucky"             "Louisiana"           
    ## [21] "Maine"                "Maryland"             "Massachusetts"        "Michigan"            
    ## [25] "Minnesota"            "Mississippi"          "Missouri"             "Montana"             
    ## [29] "Nebraska"             "Nevada"               "New Hampshire"        "New Jersey"          
    ## [33] "New Mexico"           "New York"             "North Carolina"       "North Dakota"        
    ## [37] "Ohio"                 "Oklahoma"             "Oregon"               "Pennsylvania"        
    ## [41] "Rhode Island"         "South Carolina"       "South Dakota"         "Tennessee"           
    ## [45] "Texas"                "Utah"                 "Vermont"              "Virginia"            
    ## [49] "Washington"           "West Virginia"        "Wisconsin"            "Wyoming"

Counts of each county (and other second-level sub-regions) represented
in the data.

``` r
raw_us_data %>%
  count(sub_region_1, sub_region_2)
```

    ## # A tibble: 2,879 x 3
    ##    sub_region_1 sub_region_2        n
    ##    <chr>        <chr>           <int>
    ##  1 Alabama      Autauga County     76
    ##  2 Alabama      Baldwin County     76
    ##  3 Alabama      Barbour County     76
    ##  4 Alabama      Bibb County        76
    ##  5 Alabama      Blount County      76
    ##  6 Alabama      Bullock County     70
    ##  7 Alabama      Butler County      76
    ##  8 Alabama      Calhoun County     76
    ##  9 Alabama      Chambers County    76
    ## 10 Alabama      Cherokee County    76
    ## # … with 2,869 more rows

Date ranges included in the data for each state.

``` r
raw_us_data %>%
  group_by(sub_region_1) %>%
  summarize(
    min = min(date),
    max = max(date)
  )
```

    ## # A tibble: 52 x 3
    ##    sub_region_1         min        max       
    ##    <chr>                <date>     <date>    
    ##  1 Alabama              2020-02-15 2020-04-30
    ##  2 Alaska               2020-02-15 2020-04-30
    ##  3 Arizona              2020-02-15 2020-04-30
    ##  4 Arkansas             2020-02-15 2020-04-30
    ##  5 California           2020-02-15 2020-04-30
    ##  6 Colorado             2020-02-15 2020-04-30
    ##  7 Connecticut          2020-02-15 2020-04-30
    ##  8 Delaware             2020-02-15 2020-04-30
    ##  9 District of Columbia 2020-02-15 2020-04-30
    ## 10 Florida              2020-02-15 2020-04-30
    ## # … with 42 more rows

# Examining the *processed* Google mobility data for the United States

State codes included in the data. Note that “US” denotes national-level
data and “DC” denotes the District of Columbia.

``` r
us_data %>%
  pull(sub_region_1) %>%
  unique()
```

    ##  [1] "US" "AL" "AK" "AZ" "AR" "CA" "CO" "CT" "DE" "DC" "FL" "GA" "HI" "ID" "IL" "IN" "IA" "KS" "KY" "LA" "ME" "MD"
    ## [23] "MA" "MI" "MN" "MS" "MO" "MT" "NE" "NV" "NH" "NJ" "NM" "NY" "NC" "ND" "OH" "OK" "OR" "PA" "RI" "SC" "SD" "TN"
    ## [45] "TX" "UT" "VT" "VA" "WA" "WV" "WI" "WY"

# Examining the state-level data

Missing value counts for each variable.

``` r
state_level_data %>%
  map(~ sum(is.na(.x)))
```

    ## $region
    ## [1] 0
    ## 
    ## $date
    ## [1] 0
    ## 
    ## $retail_and_recreation
    ## [1] 0
    ## 
    ## $grocery_and_pharmacy
    ## [1] 0
    ## 
    ## $parks
    ## [1] 1
    ## 
    ## $transit_stations
    ## [1] 0
    ## 
    ## $workplaces
    ## [1] 0
    ## 
    ## $residential
    ## [1] 0
    ## 
    ## $density
    ## [1] 0
    ## 
    ## $lockdown
    ## [1] 0
    ## 
    ## $reopen
    ## [1] 0
    ## 
    ## $on_lockdown
    ## [1] 0

<!-- TODO: For some reason GitHub markdown doesn't like equation mode. -->

# Examining the R\_t data

State codes included in the data.

``` r
rt_data %>%
  pull(region) %>%
  unique()
```

    ##  [1] "AK" "AL" "AR" "AZ" "CA" "CO" "CT" "DC" "DE" "FL" "GA" "HI" "IA" "ID" "IL" "IN" "KS" "KY" "LA" "MA" "MD" "ME"
    ## [23] "MI" "MN" "MO" "MS" "MT" "NC" "ND" "NE" "NH" "NJ" "NM" "NV" "NY" "OH" "OK" "OR" "PA" "RI" "SC" "SD" "TN" "TX"
    ## [45] "UT" "VA" "VT" "WA" "WI" "WV" "WY"

Total number of regions included in the data. We have all 50 states plus
DC.

``` r
rt_data %>%
  pull(region) %>%
  n_distinct()
```

    ## [1] 51

# Density by region

Density by region (all 50 states plus DC). Data from the 2010 United
States Census.

``` r
ggplot(pop_density_data, aes(region, density)) +
  geom_point() +
  geom_segment(aes(x = region, y = 0, xend = region, yend = density)) +
  theme(axis.text.x = element_text(angle = 90, size = 8, vjust = 0.5))
```

<img src="eda_files/figure-gfm/density-by-region-1.png" width="70%" style="display: block; margin: auto;" />

# Examining the model data

<!-- TODO -->

# Examining the random forest models

Just the raw variable importance measures for now. Random forest models
were fit to the data after lagging the explanatory variables by 0, 1, …,
14 days. In each case below we just look at the model with the the
lowest MSE when fit to the data.

## Plain model (run on entire data set)

Lag that gave lowest MSE.

``` r
model_list <- rf_model_list$plain
mse_scores <- model_list %>% map(~ .x$mse)
which.min(mse_scores) - 1
```

    ## [1] 14

``` r
best_model <- model_list[[which.min(mse_scores)]]$model
importance(best_model)
```

    ##                        %IncMSE IncNodePurity
    ## region                37.84977     2.0863820
    ## retail_and_recreation 22.10919     0.9905361
    ## grocery_and_pharmacy  19.31431     1.2032472
    ## parks                 31.08711     1.1962763
    ## transit_stations      39.21450     2.7679716
    ## workplaces            24.99338     1.7234906
    ## residential           20.27467     0.5985146
    ## density               57.80772     3.7817772
    ## on_lockdown           33.59659     0.9347680

``` r
varImpPlot(best_model)
```

<img src="eda_files/figure-gfm/rf-plain-model-importance-plot-1.png" width="70%" style="display: block; margin: auto;" />

## Model excluding DC

Lag that gave lowest MSE.

``` r
model_list <- rf_model_list$no_dc
mse_scores <- model_list %>% map(~ .x$mse)
which.min(mse_scores) - 1
```

    ## [1] 14

``` r
best_model <- model_list[[which.min(mse_scores)]]$model
importance(best_model)
```

    ##                        %IncMSE IncNodePurity
    ## region                38.04241     2.0957105
    ## retail_and_recreation 21.85450     1.0206387
    ## grocery_and_pharmacy  22.01505     1.2970494
    ## parks                 30.99003     1.2398473
    ## transit_stations      40.16820     2.8414430
    ## workplaces            24.82309     1.7326578
    ## residential           19.04426     0.5758467
    ## density               52.80813     3.6167606
    ## on_lockdown           28.73380     0.7727600

``` r
varImpPlot(best_model)
```

<img src="eda_files/figure-gfm/rf-no_dc-model-importance-plot-1.png" width="70%" style="display: block; margin: auto;" />

## Model excluding NY

Lag that gave lowest MSE.

``` r
model_list <- rf_model_list$no_ny
mse_scores <- model_list %>% map(~ .x$mse)
which.min(mse_scores) - 1
```

    ## [1] 14

``` r
best_model <- model_list[[which.min(mse_scores)]]$model
importance(best_model)
```

    ##                        %IncMSE IncNodePurity
    ## region                41.79317     2.2308382
    ## retail_and_recreation 21.45794     0.8667433
    ## grocery_and_pharmacy  21.14979     1.2327605
    ## parks                 27.41939     1.1961690
    ## transit_stations      35.42505     2.5567468
    ## workplaces            23.39008     1.5946045
    ## residential           18.27219     0.5774190
    ## density               53.66439     3.6795922
    ## on_lockdown           35.02937     0.9147273

``` r
varImpPlot(best_model)
```

<img src="eda_files/figure-gfm/rf-no_ny-model-importance-plot-1.png" width="70%" style="display: block; margin: auto;" />

## Model excluding highest density states (CT, DC, MA, MD, NJ, and RI)

Lag that gave lowest MSE.

``` r
model_list <- rf_model_list$low_density
mse_scores <- model_list %>% map(~ .x$mse)
which.min(mse_scores) - 1
```

    ## [1] 14

``` r
best_model <- model_list[[which.min(mse_scores)]]$model
importance(best_model)
```

    ##                        %IncMSE IncNodePurity
    ## region                42.95120     1.8780874
    ## retail_and_recreation 18.94639     0.9359692
    ## grocery_and_pharmacy  18.99191     1.0389646
    ## parks                 31.89246     1.3244517
    ## transit_stations      40.75344     2.6990725
    ## workplaces            22.45649     1.5273503
    ## residential           15.43175     0.5545019
    ## density               52.44500     3.4073170
    ## on_lockdown           21.86113     0.5476800

``` r
varImpPlot(best_model)
```

<img src="eda_files/figure-gfm/rf-low_density-model-importance-plot-1.png" width="70%" style="display: block; margin: auto;" />

# Session info

``` r
sessionInfo()
```

    ## R version 4.0.0 (2020-04-24)
    ## Platform: x86_64-pc-linux-gnu (64-bit)
    ## Running under: Ubuntu 20.04 LTS
    ## 
    ## Matrix products: default
    ## BLAS:   /usr/lib/x86_64-linux-gnu/blas/libblas.so.3.9.0
    ## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.9.0
    ## 
    ## locale:
    ##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8    
    ##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8    LC_PAPER=en_US.UTF-8       LC_NAME=C                 
    ##  [9] LC_ADDRESS=C               LC_TELEPHONE=C             LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## other attached packages:
    ##  [1] tidyselect_1.1.0    rmarkdown_2.1       rlang_0.4.6         randomForest_4.6-14 lubridate_1.7.8    
    ##  [6] forcats_0.5.0       stringr_1.4.0       dplyr_0.8.5         purrr_0.3.4         readr_1.3.1        
    ## [11] tidyr_1.0.3         tibble_3.0.1        ggplot2_3.3.0       tidyverse_1.3.0     drake_7.12.0       
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] Rcpp_1.0.4.6      txtq_0.2.0        lattice_0.20-41   prettyunits_1.1.1 assertthat_0.2.1  digest_0.6.25    
    ##  [7] utf8_1.1.4        R6_2.4.1          cellranger_1.1.0  backports_1.1.6   reprex_0.3.0      evaluate_0.14    
    ## [13] httr_1.4.1        pillar_1.4.4      progress_1.2.2    readxl_1.3.1      rstudioapi_0.11   labeling_0.3     
    ## [19] igraph_1.2.5      munsell_0.5.0     broom_0.5.6       compiler_4.0.0    modelr_0.1.7      xfun_0.13        
    ## [25] pkgconfig_2.0.3   htmltools_0.4.0   fansi_0.4.1       crayon_1.3.4      dbplyr_1.4.3      withr_2.2.0      
    ## [31] grid_4.0.0        nlme_3.1-147      jsonlite_1.6.1    gtable_0.3.0      lifecycle_0.2.0   DBI_1.1.0        
    ## [37] magrittr_1.5      storr_1.2.1       scales_1.1.1      cli_2.0.2         stringi_1.4.6     farver_2.0.3     
    ## [43] fs_1.4.1          xml2_1.3.2        ellipsis_0.3.0    filelock_1.0.2    generics_0.0.2    vctrs_0.3.0      
    ## [49] tools_4.0.0       glue_1.4.0        hms_0.5.3         parallel_4.0.0    yaml_2.2.1        colorspace_1.4-1 
    ## [55] base64url_1.4     rvest_0.3.5       knitr_1.28        haven_2.2.0
