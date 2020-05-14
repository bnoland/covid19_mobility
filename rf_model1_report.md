# Random forest models – with regions, with lockdown indicator

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
    ## retail_and_recreation 22.11653     1.0801529
    ## grocery_and_pharmacy  18.94269     0.8756668
    ## parks                 24.90086     1.1488436
    ## transit_stations      27.84742     2.0195211
    ## workplaces            24.69761     1.1132648
    ## residential           14.75144     0.5178978
    ## density               63.30014     5.0842157
    ## region                36.96368     2.7875978
    ## on_lockdown           21.38329     0.3494278

``` r
varImpPlot(best_model)
```

<img src="/home/bnoland/Documents/code/data_stuff/covid19_mobility/rf_model1_report_files/figure-gfm/rf-plain-model-importance-plot-1.png" width="70%" style="display: block; margin: auto;" />

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
    ## retail_and_recreation 19.46546     1.1748559
    ## grocery_and_pharmacy  17.29981     0.9568561
    ## parks                 27.79390     1.2758562
    ## transit_stations      31.25781     2.0537838
    ## workplaces            23.32435     1.1012566
    ## residential           13.60370     0.4983689
    ## density               58.28550     4.8198043
    ## region                34.64513     2.6555651
    ## on_lockdown           22.83604     0.2997592

``` r
varImpPlot(best_model)
```

<img src="/home/bnoland/Documents/code/data_stuff/covid19_mobility/rf_model1_report_files/figure-gfm/rf-no_dc-model-importance-plot-1.png" width="70%" style="display: block; margin: auto;" />

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
    ## retail_and_recreation 19.64939     0.9289759
    ## grocery_and_pharmacy  20.09786     0.9044383
    ## parks                 25.01380     1.1829653
    ## transit_stations      30.23134     1.9036896
    ## workplaces            21.34488     1.0077035
    ## residential           15.12524     0.5173501
    ## density               62.75983     4.9654613
    ## region                34.95724     2.7739503
    ## on_lockdown           23.21899     0.3448406

``` r
varImpPlot(best_model)
```

<img src="/home/bnoland/Documents/code/data_stuff/covid19_mobility/rf_model1_report_files/figure-gfm/rf-no_ny-model-importance-plot-1.png" width="70%" style="display: block; margin: auto;" />

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
    ## retail_and_recreation 22.13780     1.1628813
    ## grocery_and_pharmacy  16.63807     0.8390426
    ## parks                 29.90682     1.1073105
    ## transit_stations      29.88693     2.1693149
    ## workplaces            23.63036     1.1468740
    ## residential           14.07404     0.5212620
    ## density               53.52231     4.3199662
    ## region                30.82444     2.5179267
    ## on_lockdown           19.74175     0.2585568

``` r
varImpPlot(best_model)
```

<img src="/home/bnoland/Documents/code/data_stuff/covid19_mobility/rf_model1_report_files/figure-gfm/rf-low_density-model-importance-plot-1.png" width="70%" style="display: block; margin: auto;" />
