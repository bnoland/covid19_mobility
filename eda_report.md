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
    ## [1] 83
    ## 
    ## $sub_region_2
    ## [1] 4316
    ## 
    ## $date
    ## [1] 0
    ## 
    ## $retail_and_recreation_percent_change_from_baseline
    ## [1] 54515
    ## 
    ## $grocery_and_pharmacy_percent_change_from_baseline
    ## [1] 61248
    ## 
    ## $parks_percent_change_from_baseline
    ## [1] 165543
    ## 
    ## $transit_stations_percent_change_from_baseline
    ## [1] 136883
    ## 
    ## $workplaces_percent_change_from_baseline
    ## [1] 9850
    ## 
    ## $residential_percent_change_from_baseline
    ## [1] 121834

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
    ##  1 Alabama      Autauga County     83
    ##  2 Alabama      Baldwin County     83
    ##  3 Alabama      Barbour County     83
    ##  4 Alabama      Bibb County        83
    ##  5 Alabama      Blount County      83
    ##  6 Alabama      Bullock County     75
    ##  7 Alabama      Butler County      83
    ##  8 Alabama      Calhoun County     83
    ##  9 Alabama      Chambers County    83
    ## 10 Alabama      Cherokee County    83
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
    ##  1 Alabama              2020-02-15 2020-05-07
    ##  2 Alaska               2020-02-15 2020-05-07
    ##  3 Arizona              2020-02-15 2020-05-07
    ##  4 Arkansas             2020-02-15 2020-05-07
    ##  5 California           2020-02-15 2020-05-07
    ##  6 Colorado             2020-02-15 2020-05-07
    ##  7 Connecticut          2020-02-15 2020-05-07
    ##  8 Delaware             2020-02-15 2020-05-07
    ##  9 District of Columbia 2020-02-15 2020-05-07
    ## 10 Florida              2020-02-15 2020-05-07
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
    ## [1] 2
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

<img src="/home/bnoland/Documents/code/data_stuff/covid19_mobility/eda_report_files/figure-gfm/density-by-region-1.png" width="70%" style="display: block; margin: auto;" />

# Examining the model data

<!-- TODO -->

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
    ##  [7] utf8_1.1.4        R6_2.4.1          cellranger_1.1.0  backports_1.1.7   reprex_0.3.0      evaluate_0.14    
    ## [13] httr_1.4.1        pillar_1.4.4      progress_1.2.2    readxl_1.3.1      rstudioapi_0.11   labeling_0.3     
    ## [19] igraph_1.2.5      munsell_0.5.0     broom_0.5.6       compiler_4.0.0    modelr_0.1.7      xfun_0.13        
    ## [25] pkgconfig_2.0.3   htmltools_0.4.0   fansi_0.4.1       crayon_1.3.4      dbplyr_1.4.3      withr_2.2.0      
    ## [31] grid_4.0.0        nlme_3.1-147      jsonlite_1.6.1    gtable_0.3.0      lifecycle_0.2.0   DBI_1.1.0        
    ## [37] magrittr_1.5      storr_1.2.1       scales_1.1.1      cli_2.0.2         stringi_1.4.6     farver_2.0.3     
    ## [43] fs_1.4.1          xml2_1.3.2        ellipsis_0.3.0    filelock_1.0.2    generics_0.0.2    vctrs_0.3.0      
    ## [49] tools_4.0.0       glue_1.4.1        hms_0.5.3         parallel_4.0.0    yaml_2.2.1        colorspace_1.4-1 
    ## [55] base64url_1.4     rvest_0.3.5       knitr_1.28        haven_2.2.0
