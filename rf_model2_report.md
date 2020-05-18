# Random forest models – without regions, with lockdown indicator

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

    ##                         %IncMSE IncNodePurity
    ## retail_and_recreation 24.555880     1.3009188
    ## grocery_and_pharmacy  19.861037     1.0697163
    ## parks                 27.420885     1.2767903
    ## transit_stations      31.859492     2.0783232
    ## workplaces            26.212371     1.0233082
    ## residential           19.664684     0.7341088
    ## density               61.810411     4.9276564
    ## on_lockdown            8.753454     0.1500411

``` r
varImpPlot(best_model)
```

<img src="rf_model2_report_files/figure-gfm/rf-plain-model-importance-plot-1.png" width="70%" style="display: block; margin: auto;" />

## Model excluding DC

Lag that gave lowest MSE.

``` r
model_list <- rf_model_list$no_dc
mse_scores <- model_list %>% map(~ .x$mse)
which.min(mse_scores) - 1
```

    ## [1] 13

``` r
best_model <- model_list[[which.min(mse_scores)]]$model
importance(best_model)
```

    ##                         %IncMSE IncNodePurity
    ## retail_and_recreation 25.248074     1.3470973
    ## grocery_and_pharmacy  21.806806     1.1256284
    ## parks                 24.852876     1.4014710
    ## transit_stations      34.031937     2.1253602
    ## workplaces            27.491213     1.0197846
    ## residential           18.952186     0.7185936
    ## density               58.496659     4.9793662
    ## on_lockdown            7.065462     0.1523961

``` r
varImpPlot(best_model)
```

<img src="rf_model2_report_files/figure-gfm/rf-no_dc-model-importance-plot-1.png" width="70%" style="display: block; margin: auto;" />

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

    ##                         %IncMSE IncNodePurity
    ## retail_and_recreation 24.816643     1.2213002
    ## grocery_and_pharmacy  22.565720     1.0745318
    ## parks                 28.186964     1.3348409
    ## transit_stations      32.879897     1.9384486
    ## workplaces            24.873801     0.9831983
    ## residential           17.976727     0.6993792
    ## density               56.739786     4.8357179
    ## on_lockdown            7.665606     0.1507274

``` r
varImpPlot(best_model)
```

<img src="rf_model2_report_files/figure-gfm/rf-no_ny-model-importance-plot-1.png" width="70%" style="display: block; margin: auto;" />

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

    ##                         %IncMSE IncNodePurity
    ## retail_and_recreation 21.943859     1.0915155
    ## grocery_and_pharmacy  19.845521     1.0772739
    ## parks                 26.713494     1.2624325
    ## transit_stations      33.412680     2.0799396
    ## workplaces            26.676329     0.9863348
    ## residential           19.179243     0.6695979
    ## density               58.756490     4.4041222
    ## on_lockdown            7.414001     0.1320992

``` r
varImpPlot(best_model)
```

<img src="rf_model2_report_files/figure-gfm/rf-low_density-model-importance-plot-1.png" width="70%" style="display: block; margin: auto;" />
