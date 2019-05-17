# Simple Linear Regression {#slr}


## COMP: College Admissions



### Introduction {-}

The primary goal of today's assignment is to give you practice with some of the tools you will need to conduct regression analysis using R. An additional goal for today is for you to be introduced to your teams and practice collaborating using GitHub and RStudio. 

### Packages {-}

We will use the following packages in today's assignment:


```r
library(tidyverse)
library(skimr)
library(broom)
library(rcfss)
```

### Data {-}

We will analyze the `scorecard` dataset from the **rcfss** package. This dataset contains information about 1849 colleges obtained from the Department of Education's College Scorecard. Load the rcfss library into the global R environment and type `?scorecard` in the **console** to learn more about the dataset and variable definitions. This analysis will focus on the following variables: 

|  |  |
|-----------|------------------------------------------|
| `type` | Type of college (Public, Private - nonprofit, Private - for profit) |
| `cost` | The average annual cost of attendance, including tuition and feeds, books and supplies, and living expenses, minus the average grant/scholarship aid |
| `admrate` | Undergraduate admissions rate (from 0 - 100%) |

### Exercises {-}

#### Exploratory Data Analysis {-}

1. Plot a histogram to examine the distribution of `admrate`. Describe the shape of the distribution.

2. To better understand the distribution of `admrate`, we would like calculate measures of center and spread of the distribution. Fill in the code below to use the `skim` function to calculate summary statistics for `admrate`. Report the appropriate measures of center (mean or median) and spread (standard deviation or IQR) based on the shape of the distribution from Exercise 1.


```r
scorecard %>%
  select(admrate) %>%
  skim()
```

3. Plot the distribution of `cost` and calculate the appropriate summary statistics. Describe the distribution of `cost` (shape, center, and spread) using the plot and appropriate summary statistics.  

4. One nice feature of the `skim` function is that it provides information about the number of observations that are missing values of the variable. How many observations have missing values of `admrate`? How many observations have missing values of `cost`? 

5. Later in the semester, we will techniques to deal with missing values in the data. For now, however, only include complete observations for the remainder of this analysis. You can use the `filter` function to select only the rows that values for both `cost` and `admrate`. (*Note: Learn more about the `filter` function in [Section 5.2 of R for Data Science] (https://r4ds.had.co.nz/transform.html#filter-rows-with-filter).*)

Fill in the code below to create a new dataset called `scorecard_new` that only includes observations with values for both `admrate` and `cost`.


```r
__________ <- scorecard %>%
  filter(!is.na(admrate),________)
```


```r
# 
```

**You will use `scorecard_new` for the rest of the assignment.**

6. Create a scatterplot to display the relationship between `cost` (response variable) and `admrate` (explanatory variable). Use the scatterplot to describe the relationship between the two variables.

7. The data contains information about the type of college, and we would like to incorporate this information into the scatterplot. One way to do this is to use a different color marker for each type of college. Fill in the code below the scatterplot from the previous exercise with the marker colors based on the variable `type`. Describe two new observations from this scatterplot that you didn't see in the previous plot.


```r
ggplot(data=scorecard_new, mapping=aes(x=admrate, y=cost, color=type)) + 
  _____________________
```

#### Simple Linear Regression {-}

8. Fit a regression model to describe the relationship between a college's admission rate and cost. Use the `tidy` function to display the model.

9. Interpret the slope in the context of the problem. Does the intercept have a meaningful interpretation? If so, write the interpretation in the context of the problem. Otherwise, explain why the interpretation is not meaningful. 

10. While the `tidy` function is used to display the model, we can obtain a one-row summary of the model using the `glance` function. Use the `glance` function to get a summary of the model fit in the previous exercise. See the [documentation for `glance`](https://rdrr.io/cran/broom/man/glance.lm.html) for the syntax and a list of values output from the function.

11. What is the value of $R^2$? Interpret this value in the context of the problem. Do you think this is a "good" value of $R^2$? Explain.

12. What is the value of $\hat{\sigma}$, the residual standard error.

13. What is the 95% confidence interval for the coefficient of `admrate`, i.e. the slope? Interpret the interval in the context of the data. 

14. We want to test the following hypotheses about the population slope $\beta_1$:

$$H_0: \beta_1 = 0 \hspace{5mm} \text{versus} \hspace{5mm} H_a: \beta_1 \neq 0$$

State what the null and alternative hypotheses mean in terms of the linear relationship between `admrate` and `cost`.

15. Consider the confidence interval from Exercise 13 and the hypotheses in Exercise 14. Does this confidence interval seem to be consistent with the null or alternative hypothesis? Briefly explain.  

*Knit then commit all remaining changes, write a commit message indiciating you’re finished, and push to GitHub. Before you finish, make sure all documents are updated on your GitHub repo.*


***

## IN-CLASS: Advertising & Sales



In this mini analysis, we will work with the `Advertising` data used in Chapters 2 and 3 of [@islr].


### Packages {-}



```r
library(readr)
library(tidyverse)
library(skimr)
library(broom)
```

### Data {-}

```r
advertising <- read_csv("data/advertising.csv")
```

This dataset contains the advertising spending and sales for 200 markets. The variables are

- `tv`: total spending on TV advertising (in $thousands)
- `radio`: total spending on radio advertising (in $thousands)
- `newspaper`: total spending on newspaper advertising (in $thousands)
- `sales`: total sales (in $millions)

### Exercises {-}

We'll begin the analysis by getting quick view of the data: 


```r
glimpse(advertising)
```

Next, we can calculate summary statistics for each of the variables in the data set. 


```r
advertising %>% skim()
```

1. What type of advertising has the smallest median spending?

2. What type of advertising has the largest variation in spending? 

3. Describe the shape of the distribution of `sales`. 

We are most interested in understanding how advertising spending affect sales. One way to quantify the relationship between the variables is by calculating the correlation matrix. 


```r
advertising %>% 
  cor()
```

1. What is the correlation between `radio` and `sales`? Interpret this value. 

2. What type of advertising has the strongest linear relationship with `sales`? 

Below are visualizations of `sales` versus each explanatory variable. 


```r
advertising %>%
  ggplot(mapping = aes(x=tv,y=sales)) + 
  geom_point(alpha=0.7) + 
  geom_smooth(method="lm",se=FALSE,color="blue") + 
  labs(title = "Sales vs. TV Advertising", 
       x= "TV Advertising (in $thousands)", 
       y="_____") #fill in the Y axis label
```


```r
advertising %>%
  ggplot(mapping = aes(x=radio,y=sales)) + 
  geom_point(alpha=0.7) + 
  geom_smooth(method="lm",se=FALSE,color="red") + 
  labs(title = "Sales vs. TV Advertising", 
       x= "Radio Advertising (in $thousands)", 
       y="Sales (in $millions)")
```


```r
advertising %>%
  ggplot(mapping = aes(x=newspaper,y=sales)) + 
  geom_point(alpha=0.7) + 
  geom_smooth(method="lm",se=FALSE,color="purple") + 
  labs(title = "Sales vs. Newspaper Advertising", 
       x= "Newspaper Advertising (in $thousands)", 
       y="Sales (in $millions)")
```

Since `tv` appears to have the strongest linear relationship with `sales`, let's calculate a simple linear regression model using these two variables. 


```r
ad_model <- lm(sales ~ tv, data=advertising)
ad_model
```

1. Write the model equation. 

2. Does it make sense to interpret the intercept? If so, interpret the intercept in the context of the problem. Otherwise, briefly explain why not.

3. Interpret the slope in the context of the problem.

***

## IN-CLASS: Carbohydrates in Beer



### Packages {-}

```r
library(tidyverse)
library(readr)
library(broom)
```


### Data {-}

```r
beer <- read_csv("data/beer.csv")
```

In this analysis, we will analyze the relationship between the amount of alcohol (`PercentAlcohol`) and the caloric content (`CaloriesPer12Oz`) in domestic beers. Let `PercentAlcohol` be the predictor variable and `CaloriesPer12Oz` the response variable. 

### Exercises {-}

**Due to limited class time, we will not do the exploratory data analysis in this example. In practice, however, you should always start with the exploratory data analysis.**


1. Fit a regression model to describe the relationship between `PercentAlcohol` and `CaloriesPer12Oz`. Display the model output.


```r
# code for regression model
```

2. Does it make sense to interpret the intercept? Why or why not?

3. Interpret the 95% confidence interval for the slope in the context of the data.

4. Calculate the critical value, $t^*$, used to calculate the 95% confidence interval. The code below is a guide; uncomment and complete the lines of code to calculate and display the critical value.


```r
n <- nrow(beer)

#df <- _________  

#crit_val <- qt(_____,df)
#crit_val
```

The critical value used to calculate the 95% confident interval for the slope is ____. 

5. Interpret the test statistic in the context of the data.

6. How was the p-value calculated? Fill in the code below to calculate the p-value. The code below is a guide; uncomment and complete the lines of code to calculate and display the p-value.


```r
#test_statistic <- _______

#prob <- 1 - pt(abs(test_statistic),df)

#p_value <- 2 * prob
#p_value
```

The p-value is ____ . Given there is no linear relationship between `PercentAlcohol` and `CaloriesPer12Oz`, the probability of obtaining a test statistic with magnitude ____ or more extreme is ____.

7. Fill in the code below to calculate the predicted calories and corresponding 90% interval for a single beer with alcohol content of 4.3%.


```r
x0 <-  data.frame(PercentAlcohol=4.3)
#predict.lm(model,x0,interval="________",conf.level=________) #<<
```


8. Fill in the code below to calculate the predicted calories and corresponding 90% interval for the subset of beers with alcohol content of 4.3%.


```r
x0 <-  data.frame(PercentAlcohol=4.3)
#predict.lm(model,x0,interval="________",conf.level=________) #<<
```

***



