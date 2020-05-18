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

    ##                         %IncMSE IncNodePurity
    ## retail_and_recreation 22.473510    0.91304897
    ## grocery_and_pharmacy  15.830614    0.69750187
    ## parks                 22.011135    0.79299837
    ## transit_stations      27.132600    1.61645411
    ## workplaces            18.795577    0.65840583
    ## residential           13.021818    0.35038309
    ## density               60.672573    4.66139731
    ## region                37.427373    3.07144446
    ## on_lockdown            6.752515    0.09106055

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

    ##                         %IncMSE IncNodePurity
    ## retail_and_recreation 21.675170    0.94272691
    ## grocery_and_pharmacy  15.636707    0.71612590
    ## parks                 22.509856    0.95891981
    ## transit_stations      27.082854    1.75507533
    ## workplaces            19.981051    0.62099429
    ## residential           13.652652    0.37735956
    ## density               58.391489    4.46212804
    ## region                37.716575    2.78878684
    ## on_lockdown            6.277285    0.09489861

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

    ##                         %IncMSE IncNodePurity
    ## retail_and_recreation 21.185674    0.85672117
    ## grocery_and_pharmacy  15.748409    0.68246255
    ## parks                 19.757683    0.77867704
    ## transit_stations      24.984142    1.45222955
    ## workplaces            19.461940    0.63134023
    ## residential           12.403228    0.37186264
    ## density               65.524751    4.74183956
    ## region                42.349352    2.97103649
    ## on_lockdown            5.213248    0.08915529

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

    ##                         %IncMSE IncNodePurity
    ## retail_and_recreation 20.127138    0.74967410
    ## grocery_and_pharmacy  16.223113    0.64554951
    ## parks                 22.490715    0.83708963
    ## transit_stations      29.404910    1.90086009
    ## workplaces            21.520031    0.64096459
    ## residential           14.044283    0.31636825
    ## density               69.862913    4.08633890
    ## region                33.121987    2.66348361
    ## on_lockdown            6.664574    0.09635609

``` r
varImpPlot(best_model)
```

<img src="/home/bnoland/Documents/code/data_stuff/covid19_mobility/rf_model1_report_files/figure-gfm/rf-low_density-model-importance-plot-1.png" width="70%" style="display: block; margin: auto;" />
