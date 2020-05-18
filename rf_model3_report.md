# Random forest models – with regions, without lockdown indicator

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
    ## retail_and_recreation 22.06743     1.0786089
    ## grocery_and_pharmacy  17.01326     0.7998339
    ## parks                 24.74389     0.9150519
    ## transit_stations      26.74671     1.6886538
    ## workplaces            22.28359     0.7870410
    ## residential           17.19939     0.4867852
    ## density               55.10116     4.1478345
    ## region                39.93703     2.7989136

``` r
varImpPlot(best_model)
```

<img src="rf_model3_report_files/figure-gfm/rf-plain-model-importance-plot-1.png" width="70%" style="display: block; margin: auto;" />

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
    ## retail_and_recreation 22.48792     0.9922854
    ## grocery_and_pharmacy  17.98363     0.8907215
    ## parks                 24.37323     1.0230342
    ## transit_stations      29.85890     1.8251661
    ## workplaces            21.01068     0.7352790
    ## residential           15.88802     0.5105904
    ## density               55.97636     4.1279312
    ## region                35.34716     2.5251981

``` r
varImpPlot(best_model)
```

<img src="rf_model3_report_files/figure-gfm/rf-no_dc-model-importance-plot-1.png" width="70%" style="display: block; margin: auto;" />

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
    ## retail_and_recreation 22.22135     0.9323734
    ## grocery_and_pharmacy  19.26600     0.8057142
    ## parks                 22.68864     0.9659374
    ## transit_stations      25.38950     1.4213523
    ## workplaces            22.88107     0.7719500
    ## residential           14.50776     0.5105544
    ## density               52.20203     4.0425360
    ## region                35.84969     2.9136677

``` r
varImpPlot(best_model)
```

<img src="rf_model3_report_files/figure-gfm/rf-no_ny-model-importance-plot-1.png" width="70%" style="display: block; margin: auto;" />

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
    ## retail_and_recreation 20.81552     0.8431665
    ## grocery_and_pharmacy  18.72364     0.8335774
    ## parks                 22.71370     0.9538419
    ## transit_stations      28.42708     1.7624333
    ## workplaces            21.81797     0.7668006
    ## residential           14.07967     0.4414532
    ## density               52.41827     3.7633075
    ## region                34.30597     2.5066371

``` r
varImpPlot(best_model)
```

<img src="rf_model3_report_files/figure-gfm/rf-low_density-model-importance-plot-1.png" width="70%" style="display: block; margin: auto;" />
