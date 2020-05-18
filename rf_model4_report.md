# Random forest models – without regions, without lockdown indicator

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
    ## retail_and_recreation 26.10292     1.2378036
    ## grocery_and_pharmacy  20.99591     1.1130752
    ## parks                 25.81044     1.2659006
    ## transit_stations      32.69705     2.1212419
    ## workplaces            25.59781     1.0229632
    ## residential           16.06027     0.6656216
    ## density               60.29407     5.2412102

``` r
varImpPlot(best_model)
```

<img src="rf_model4_report_files/figure-gfm/rf-plain-model-importance-plot-1.png" width="70%" style="display: block; margin: auto;" />

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
    ## retail_and_recreation 25.75411     1.1919238
    ## grocery_and_pharmacy  21.49904     1.0789697
    ## parks                 27.56988     1.3990468
    ## transit_stations      34.07087     2.2610085
    ## workplaces            24.46207     0.9525977
    ## residential           17.99704     0.6671761
    ## density               63.99683     5.0689474

``` r
varImpPlot(best_model)
```

<img src="rf_model4_report_files/figure-gfm/rf-no_dc-model-importance-plot-1.png" width="70%" style="display: block; margin: auto;" />

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
    ## retail_and_recreation 25.73983     1.1607959
    ## grocery_and_pharmacy  19.79487     1.0359287
    ## parks                 27.42025     1.2275112
    ## transit_stations      35.08907     2.0362529
    ## workplaces            25.00926     1.0013027
    ## residential           17.33125     0.6220514
    ## density               65.31703     5.2647298

``` r
varImpPlot(best_model)
```

<img src="rf_model4_report_files/figure-gfm/rf-no_ny-model-importance-plot-1.png" width="70%" style="display: block; margin: auto;" />

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
    ## retail_and_recreation 22.74227     1.0689128
    ## grocery_and_pharmacy  20.32275     1.0068085
    ## parks                 26.03735     1.1942095
    ## transit_stations      34.54396     2.2316005
    ## workplaces            27.66150     0.9540423
    ## residential           16.59418     0.5963254
    ## density               63.84272     4.7769672

``` r
varImpPlot(best_model)
```

<img src="rf_model4_report_files/figure-gfm/rf-low_density-model-importance-plot-1.png" width="70%" style="display: block; margin: auto;" />
