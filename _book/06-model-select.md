# Model Selection {#select}


## Model Selection 



The goal of today’s lab is to practice forward and backward model selection. In addition to practice with model selection functions in R, you will manually conduct a backward selection procedure to better understand what occurs when you use model selection functions.


### Packages

You will need the following packages for today's lab: 


```r
library(tidyverse)
library(knitr)
library(broom)
library(leaps)
library(Sleuth3) #case1201 data
library(ISLR) #Hitters data
```

### Data

There are two datasets for this lab.

#### Part I

The dataset for Part I contains the SAT score (out of 1600) and other variables that may be associated with SAT performance for each of the 50 states in the U.S. The data is based on test takers for the 1982 exam. The following variables are in the dataset: 

- **`SAT`**: average total SAT score
- **`State`**: U.S. State
- **`Takers`**: percentage of high school seniors who took exam
- **`Income`**: median income of families of test-takers ($ hundreds)
- **`Years`**: average number of years test-takers had formal education in social sciences, natural sciences, and humanities
- **`Public`**: percentage of test-takers who attended public high schools
- **`Expend`**: total state expenditure on high schools ($ hundreds per student)
- **`Rank`**: median percentile rank of test-takers within their high school classes

#### Part II

The dataset for Part II contains the performance statistics and salaries of Major League Baseball players in the 1986 and 1987 seasons. The data is in the `Hitters` dataset in the `ISLR` package. Type `?Hitters` in the console to see the variables names and their definitions.

### Exercises

#### Part I

For the first part of the lab, you will return to the model selection activity you started in class using the SAT data. The data is in the `case1201` data frame in the `Sleuth3` package.


```r
sat_scores <- case1201 %>%
  select(-State) 
```

1. Manually perform backward selection using $Adj. R^2$ as the selection criterion. To help you get started, the full model and the code for the first set of models to test are below. Show each step of the selection process. Display the coefficients and $Adj. R^2$ of your final model.


```r
full_model <- lm(SAT ~ ., data = sat_scores)
```


```r
m1 <- lm(SAT ~ Income + Years + Public + Expend + Rank, data = sat_scores)
```


```r
m2 <- lm(SAT ~ Takers + Years + Public + Expend + Rank, data = sat_scores)
```


```r
m3 <- lm(SAT ~ Takers + Income + Public + Expend + Rank, data = sat_scores)
```


```r
m4 <- lm(SAT ~ Takers + Income + Years + Expend + Rank, data = sat_scores)
```


```r
m5 <- lm(SAT ~ Takers + Income + Years + Public + Rank, data = sat_scores)
```


```r
m6 <- lm(SAT ~ Takers + Income + Years + Public + Expend, data = sat_scores)
```

2. What is the best 5-variable model? Display the model output.

3. Use the `regsubsets` function to perform backward selection. What is the final model when $Adj. R^2$ is the selection criterion? Display the coefficients and the $Adj. R^2$ of the final model. *This should be the same result you got in Exercise 1.*

4. What is the final model when $BIC$ is the selection criterion? Display the coefficients and the $BIC$ of the final model.

5. Compare the final models selected by $Adj. R^2$ and $BIC$.
    - Do the models have the same number of predictors? Briefly explain.
    - Are the same predictor variables in each model? Briefly explain.
    
6. Consider the comparisons made in the previous exercise. Are these differences what you would expect given the selection criteria used? Briefly explain.

#### Part II

The data for this part of the lab is the `Hitters` dataset in the `ISLR` package. Your goal is to fit a regression model that uses the performance statistics of baseball players to predictor their salary. There are 19 potential predictor variables, so you will use the `regsubsets` function to conduct forward selection to choose a final model.

7. Read through the data dictionary for the `Hitters` dataset. You can access it by typing `?Hitters` in the console. What is the difference between the variables `HmRun` and `CHmRun`?

8. Some observations have missing values for `Salary`. Filter the data, so only observations that have values for `Salary` are included. You will use this filtered data for the remainder of the lab.

9. Fill in the code below to conduct forward selection and save the results in an object called `sel_summary` (selection summary).


```r
# The `nvmax` option indicates the maximum-sized variable subsets to consider in the model selection.
```


```r
regfit_forward <- regsubsets(_______, ________, method="forward", nvmax = 19)
sel_summary <- summary(_______)
```

10. The object `sel_summary` contains the summary statistics for the best fit model containing $k$ predictors, where $k = 1, \ldots, 19$. The object `sel_summary` is a list object, so it is cumbersome to extract the relevant summary statistics. Therefore, you can create a data frame called `summary_stats` such that each row represents the best fit model with $k$ predictors and each column is a summary statistic. For example, the second row contains the summary statistics of the best fit model that contains 2 variables.

Fill in the code below to create the data frame `summary_stats` that includes the $BIC$, $R^2$, $Adj. R^2$, and residual sum of squares (RSS) for each model in `sel_summary`. The data frame `summary_stats` will also include the column `np`, the number of predictors in the model represented on each row.


```r
summary_stats <- data.frame(bic = sel_summary$bic, 
                       adjr2 = _______, 
                       rsq = _______,
                       rss = _______) %>%
  mutate(np = row_number()) #number of variables
```


```r
# See the [ggplot2 documentation](https://ggplot2.tidyverse.org/reference/geom_abline.html#arguments) for code to add a vertical line.
```

11. Use the data in the `summary_stats` data frame to plot $BIC$ versus the number of predictors. Include a vertical line on your plot that shows the number of predictors for the overall final model you would select based on $BIC$. Be sure your plot has clear and informative title and axes labels. 
    - How does $BIC$ change as the number of predictors increases? 
    - How many predictors are in the final model selected based on $BIC$?

*You can fill in the code below with either `max` or `min` to find the number of predictors in the final model selected based on $BIC$.*


```r
np_bic <- summary_stats %>%
  filter(bic == _____(bic)) %>%
  select(np) %>% 
  pull()
```


12. Use the data in the `summary_stats` data frame to plot $Adj. R^2$ versus the number of predictors. Include a vertical line on your plot that shows the number of predictors for the final model you would select based on $Adj. R^2$. Be sure your plot has clear and informative title and axes labels. 
    - How does $Adj. R^2$ change as the number of predictors increases? 
    - How many predictors are in the final model selected based on $Adj. R^2$?


13. Use the data in the `summary_stats` data frame to plot $R^2$ versus the number of predictors. Include a vertical line on your plot that shows the number of predictors for the final model selected based on $R^2$. Be sure your plot has clear and informative title and axes labels. 
    - How does $R^2$ change as the number of predictors increases? 
    - How many predictors are in the final model selected based on $R^2$?

14. Should $R^2$ be used as a model selection criterion? Briefly explain why or why not using your answers to Exercises 11 - 13.

15. Choose a final model to predict a baseball player's `Salary` from his performance statistics. Display the variables, their coefficients, and the summary statistics from the `summary_stats` data frame for this model. 

16. Briefly explain why you chose the model in the previous exercise.
    - Which model selection criteria did you use ($BIC$, $Adj. R^2$, $R^2$)? Why?
    - What other factors did you consider besides the value of the model selection criteria? 
    
### Acknowledgements

Part II of this lab was inspired by Lab 6.5 in [An Introduction to Statistical Learning](http://www-bcf.usc.edu/~gareth/ISL/) and [Variable Selection in Regression](https://www.andrew.cmu.edu/user/achoulde/95791/homework/homework3.html).


## Model Selection




```r
library(tidyverse)
library(knitr)
library(broom)
library(Sleuth3)
library(leaps)
```



```r
sat_scores <- case1201 %>%
  select(-State) #remove the state variable
```

### Backward selection "manually"

- Manually perform backward selection using Adj. $R^2$ as the selection criteria. Show each step of the selection process. To help you get started, the full model and the code for the first set of models to test are below. You will need to find Adj. $R^2$ for each model.


```r
full_model <- lm(SAT ~ ., data = sat_scores)
```


```r
m1 <- lm(SAT ~ Income + Years + Public + Expend + Rank, data = sat_scores)
```


```r
m2 <- lm(SAT ~ Takers + Years + Public + Expend + Rank, data = sat_scores)
```


```r
m3 <- lm(SAT ~ Takers + Income + Public + Expend + Rank, data = sat_scores)
```


```r
m4 <- lm(SAT ~ Takers + Years + Income + Expend + Rank, data = sat_scores)
```


```r
m5 <- lm(SAT ~ Takers + Years + Public + Income + Expend, data = sat_scores)
```


```r
m6 <- lm(SAT ~ Takers + Years + Public + Income + Rank, data = sat_scores)
```

Continue the model selection until you have a final model. Show each step of the model selection process.


### Backward selection using regsubsets

- Use the `regsubsets` function to perform backward selection using Adj. $R^2$ as the selection criteria. Are the variables the same as the ones at you chose? Is the Adj. $R^2$ the same? 

### Changing selection criteria

- Use the `regsubsets` function to perform backward selection using BIC as the selection criteria. What variables were chosen for the follow model? How does this model compare to the one selected using Adj. $R^2$?

- Use the `step` function to perform backward selection using AIC as the selection criteria. What variables were chosen for the follow model? How does this model compare to the models chosen from the other selection criteria? 


### Different selection procedure

- Use forward or stepwise selection to choose a model. Choose the criteria you will use to select the model.

- How does this model compare to the previous selected models? 


### Choosing a final model 

- You likely have at least 2 different models chosen by the various model selection procedures. Which variables will you include in your final model? Why did you choose this to be your final model?

## Model Selection Criteria: AIC & BIC



This document discusses some of the mathematical details of Akaike's Information Criterion (AIC) and Schwarz's Bayesian Information Criterion (BIC).   We assume the reader knowledge of the matrix form for multiple linear regression.Please see [Matrix Form of Linear Regression](https://github.com/STA210-Sp19/supplemental-notes/blob/master/regression-basics-matrix.pdf) for a review.

### Maximum Likelihood Estimation of $\boldsymbol{\beta}$ and $\sigma$

To understand the formulas for AIC and BIC, we will first briefly explain the likelihood function and maximum likelihood estimates for regression. 

Let $\mathbf{Y}$ be $n \times 1$ matrix of responses, $\mathbf{X}$, the $n \times (p+1)$ matrix of predictors, and $\boldsymbol{\beta}$, $(p+1) \times 1$ matrix of coefficients. If the multiple linear regression model is correct then,

\begin{equation}
\label{norm-assumption}
\mathbf{Y} \sim N(\mathbf{X}\boldsymbol{\beta}, \sigma^2)
\end{equation}

When we do linear regression, our goal is to estimate the unknown parameters $\boldsymbol{\beta}$ and $\sigma^2$ from (\ref{norm-assumption}). In [Matrix Form of Linear Regression](https://github.com/STA210-Sp19/supplemental-notes/blob/master/regression-basics-matrix.pdf), we showed a way to estimate these parameters using matrix alegbra. Another approach for estimating $\boldsymbol{\beta}$ and $\sigma^2$ is using *maximum likelihood estimation*.

A **likelihood function** is used to summarise the evidence from the data in support of each possible value of a model parameter. Using (\ref{norm-assumption}), we will write the likelihood function for linear regression as

\begin{equation}
\label{lr}
L(\mathbf{X}, \mathbf{Y}|\boldsymbol{\beta}, \sigma^2) = \prod\limits_{i=1}^n (2\pi \sigma^2)^{-\frac{1}{2}} \exp\bigg\{-\frac{1}{2\sigma^2}\sum\limits_{i=1}^n(Y_i - \mathbf{X}_i \boldsymbol{\beta})^T(Y_i - \mathbf{X}_i \boldsymbol{\beta})\bigg\}
\end{equation}

where $Y_i$ is the $i^{th}$ response and $\mathbf{X}_i$ is the vector of predictors for the $i^{th}$ observation. One approach estimating $\boldsymbol{\beta}$ and $\sigma^2$ is to find the values of those parameters that maximize the likelihood in (\ref{lr}), i.e. **maximum likelhood estimation**. To make the calculations more manageable, instead of maximizing the likelihood function, we will instead maximize its logarithm, i.e. the log-likelihood function. The values of the parameters that maximize the log-likelihood function are those that maximize the likelihood function. The log-likelihood function we will maximize is 

\begin{equation}
\label{logL}
\begin{aligned}
\log L(\mathbf{X}, \mathbf{Y}|\boldsymbol{\beta}, \sigma^2) &= \sum\limits_{i=1}^n -\frac{1}{2}\log(2\pi\sigma^2) -\frac{1}{2\sigma^2}\sum\limits_{i=1}^n(Y_i - \mathbf{X}_i \boldsymbol{\beta})^T(Y_i - \mathbf{X}_i \boldsymbol{\beta}) \\[10pt]
&= -\frac{n}{2}\log(2\pi\sigma^2) - \frac{1}{2\sigma^2}(\mathbf{Y} - \mathbf{X} \boldsymbol{\beta})^T(\mathbf{Y} - \mathbf{X} \boldsymbol{\beta})\\
\end{aligned}
\end{equation}

[--insert details MLES--]

The maximum likelihood estimate of $\boldsymbol{\beta}$ and $\sigma^2$ are 

\begin{equation}
\label{mle}
\hat{\boldsymbol{\beta}} = (\mathbf{X}^T\mathbf{X})^{-1}\mathbf{X}^T\mathbf{Y} \hspace{10mm} \hat{\sigma}^2 = \frac{1}{n}(\mathbf{Y} - \mathbf{X} \boldsymbol{\beta})^T(\mathbf{Y} - \mathbf{X} \boldsymbol{\beta}) = \frac{1}{n}RSS
\end{equation}

where $RSS$ is the residual sum of squares. Note that the maximum likelihood estimate is not exactly equal to the estimate of $\sigma^2$ we typically use $\frac{RSS}{n-p-1}$. This is because the maximum likelihood estimate of $\sigma^2$ in (\ref{mle}) is a *biased* estimator of $\sigma^2$. When $n$ is much larger than the number of predictors $p$, then the differences in these two estimates are trivial. 

### AIC 

Akaike's Information Criterion (AIC) is 

\begin{equation}
\label{aic}
AIC = -2 \log L + 2(p+1)
\end{equation}

where $\log L$ is the log-likelihood. This is the general form of AIC that can be applied to a variety of models, but for now, let's focus on AIC for mutliple linear regression. 

\begin{equation}
\label{aic-reg}
\begin{aligned}
AIC &= -2 \log L + 2(p+1) \\[10pt]
&= -2\bigg[-\frac{n}{2}\log(2\pi\sigma^2) - \frac{1}{2\sigma^2}(\mathbf{Y} - \mathbf{X} \boldsymbol{\beta})^T(\mathbf{Y} - \mathbf{X} \boldsymbol{\beta})\bigg] + 2(p+1) \\[10pt]
&= n\log\big(2\pi\frac{RSS}{n}\big) + \frac{1}{RSS/n}RSS \\[10pt]
&= n\log(2\pi) + n\log(RSS) - n\log(n) + 2(p+1)
\end{aligned}
\end{equation}

### BIC 

[---]





