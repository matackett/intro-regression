# Multiple Linear Regression {#mlr}


## Multiple Linear Regression 



The goal of this lab is to use multiple linear regression to understand the variation in the selling price of houses in King County, Washington. You will also gain practice using special predictors, such as categorical predictors and interaction effects, in the model, and you will be introduced to variable transformations.

### Packages

We will use the following packages in today's lab.



### Data 

The for today's lab contains the price and other characteristics of over 20,000 houses sold in King County, Washington (the county that includes Seattle). The dataset includes the following variables:

- `price`: selling price of the house
- `date`: date house was sold, measured in days since January 1, 2014
- `bedrooms`: number of bedrooms
- `bathrooms`: number of bathrooms
- `sqft`: interior square footage
- `floors`: number of floors
- `waterfront`: 1 if the house has a view of the waterfront, 0 otherwise
- `yr_built`: year the house was built
- `yr_renovated`: 0 if the house was never renovated, the year the house was renovated if else




### Exercises 

1. Use data visualization and summary statistics to examine the distribution of `bedrooms`. What is the maximum value? Does this value make sense? If not, what is this an indication of, i.e. how did this value get recorded in the data? Briefly explain.



2. We want to remove observations that have extreme values for bedrooms, i.e. those with values for `bedrooms` above the 95<sup>th</sup> percentile in the data. What is the 95<sup>th</sup> percentile for `bedrooms`? Use the `summarise` function to help you calculate this value.



3. Fill in the code below to filter the data so that the extreme observations are removed.  How many observations are in the updated dataset? 



We will use this dataset for the remainder of the analysis. 


4. Fit a regression model using square feet to explain variation in the price. Plot the residuals versus the predicted values. Based on this plot, what regression assumption appears to be violated? Briefly explain. 

Plot the histogram and Normal QQ-plot of the residuals. Based on these plots, what regression assumption appears to be violated? Briefly explain. 

5. One way to deal with violations in regression assumptions is to transform the response variable and use that transformed variable when fitting the regression model. (We will talk about this in class next week). Some common transformations used in regression are the natural log (`log(y)`), the square root (`sqrt(y)`), and the reciprocal (`1/y`). 

Each transformation is applied to the response variable `price`, and the distributions of the transformed data are shown below.



Which transformation should we use to fix the violations of the model assumptions observed in the previous exercise? Briefly explain your choice. 

6. Add the variable `logprice`, the log-transformed version of `price`, to the data frame. Fit a regression model with `logprice` as the response and `sqft` as the predictor variable. Create the residuals plots (residuals vs. predicted, histogram of residuals, Normal QQ-plot). Briefly comment on whether or not using the transformed variable improved on the model assumptions. 

7. Though we can explain about 48% of the variation in a house prices by the square footage, we would like to incorporate some of the other available house characteristics in the model.

Before fitting the model, use the code below to add the variable`floorsCat` that is the categorical version of the variable `floors`. Discuss with your group why it may make sense to treat `floors` as categorical, even though it represents a count.





Use the `count` function to see the number of observations at each level of `floorsCat`. What is the most common number of floors?



8. Use the code below to calculate the mean-centered versions of the variables `sqft`, `bedrooms`,  and `bathrooms` and add them to the data frame.



It is not appropriate to calculate the mean-centered version of the variable `waterfront`. Briefly explain why it isn't. 

9. Fit a regression model with `logprice` as the response variable, and the mean-centered variables from the previous exercise along with `waterfront` and `floorsCat` as the predictor variables. Display the model output.

10. What is the baseline level for the variable `floorsCat`?

11. Interpret the intercept of the model in the context of the data. Write the interpretation in terms of the **price**.

12. What is the intercept of the model for the subset of houses with 3 floors that are not on the waterfront? Write the intercept in terms of the **log(price)**.

13. We would like to consider potential interactions for the model. A significant **interaction** occurs when the relationship of a predictor variable with the response depends on the value of another predictor variable. 

Fill in the code below to plot the relationship between `logprice` and `bedrooms` by `waterfront`.  Based on this plot, do you think there is a significant interaction effect between `bedrooms` and `waterfront`? In other words, do you think the relationship between the logprice and the number of bedrooms differs based on whether or not a house is on the waterfront? Briefly explain.



**We will talk more about interaction effects in Monday's lecture. In HW 03, you explore potential interaction effects using this housing data.**

*You're done! Commit all remaining changes, use the commit message "Done with Lab 4!", and push. Before you wrap up the assignment, make sure the .Rmd and .md  documents are updated in your GitHub repo. There is a 10% penalty if the .Rmd file has to be knitted to display graphs, i.e. the graphs are not showing in the .md file on GitHub.*

### Acknowledgement

The data used in this lab was obtained from [https://github.com/proback/BYSH](https://github.com/proback/BYSH).



## Data Wrangling & Multiple Linear Regression 



When doing statistical analyses in practice, there is often a lot of time spent on cleaning and preparing the data. The goal of today's lab is to practice cleaning messy data, so it can be used in a regression analysis. You will also practice interpreting the results from a regression model that has numeric and categorical predictors and a log-transformed response variable. 

### Packages

We will use the following packages in today's lab.



### Data 

Today's data is about Airbnb listings in Asheville, NC. The data was obtained from [http://insideairbnb.com/](http://insideairbnb.com/index.html); it was originally scraped from [airbnb.com](https://www.airbnb.com/).  

You can see a visualization of some of the data used in today's lab at [http://insideairbnb.com/asheville/](http://insideairbnb.com/asheville/).



We will use the following variables in this lab: 

- `price`: Cost per night (in U.S. dollars)
- `cleaning_fee`: Cleaning fee (in U.S. dollars)
- `property_type`: Type of dwelling (House, Apartment, etc.)
- `room_type`: 
    - *Entire home/apt* (guests have entire place to themselves)
    - *Private room* (Guests have private room to sleep, all other rooms shared)
    - *Shared room* (Guests sleep in room shared with others) 
- `number_of_reviews`: Total number of reviews for the listing
- `review_scores_rating`: Average review score (0 - 100)



### Exercises 

#### Data wrangling

1. We would like to use variables from both the `basic_info` and `details` data frames in this analysis. Both dataframes have the variable `id` that uniquely identifies each Airbnb listing. Because we need data from `basic_info` and `details`, we only want to include observations that are in both the `basic_info` and `details` datasets. Therefore, we will use an `inner_join` to combine the two data sets. (Note: Both data frames include a variable called `id` that uniquely identifies each Airbnb listing. R will use this variable to join the two data frames.)







How many observations are in `airbnb`? How many variables?

2. Some Airbnb rentals have cleaning fees, and we want to include the cleaning fee when we calculate the total rental cost. Use the code below to see how the data in the column `cleaning_fee` is currently stored in the `airbnb` data frame.



The column `cleaning_fee` currently contains what type of data? Why do you think the data is stored this way even though `cleaning_fee` is a quantitative variable?


3. Since `cleaning_fee` is a quantitative variable, we need to make sure it is stored as numeric data in the dataframe. To do so, we will first use the `extract` function in `tidyr` package to create a column of cleaning fees that don't have the dollar sign. Then, we will use the `as.numeric()` function to make the extracted data the numeric data type `double`.





Use the `typeof` function to confirm that `cleaning_fee` is now stored as a `double` data type.

4. Use the `skim` function to view a summary of the `cleaning_fee` data. How many observations have missing values for `cleaning_fee`? What do you think is the most likely reason for the missing observations of `cleaning_fee`? In other words, what does a missing value of `cleaning_fee` indicate?

5. Fill in the code below to impute the missing values of `cleaning_fee` with an appropriate numeric value. Then use the `skim` function to confirm that there are no longer missing values of `cleaning_fee`.







*This is an example of data that is missing not at random, since there is a specific pattern/explanation to the misisng data.  We will talk more about dealing with missing data later in the semester.*




6. Next, we look at the variable `property_type`. 
    - Use the `count` function to determine how many categories are in the variable `property` and the frequency of each category.
    - What are the top 4 most common property types? These make up what proportion of the observations? 
    

7. Since an overwhelming majority of the observations in the data are one of the top 4 property types, we would like to create a simplified version of the `proprety_type` variable that has 5 categories: *House*, *Apartment*, *Guest suite*, *Bungalow*, and *Other*. Fill in the code below to create `prop_type_simp`.



Use the code below to check that `prop_type_simp` was correctly made.



8. Airbnb is most commonly used for travel purposes, i.e. as an alternative to traditional hotels. We only want to include Airbnb listings in our regression analysis that are intended for travel purposes. What are the 5 most common values for the variable `minimum_nights`? Which value in the top 5 stands out? What is the likely intended purpose for Airbnb listings with this seemingly unusual value for `minimum_nights`?

Filter the `airbnb` data so that it only includes observations with  `minimum_nights <= 3`. You will use this filtered dataset for the remainder of the lab.


#### Regression Analysis

9. For the response variable, will use the cost to stay at an Airbnb location for 3 nights. Create a new variable called `price_3_nights` that uses `price` and `cleaning_fee` to calculate the total cost to stay at the Airbnb property for 3 nights. Be sure to add this variable to your dataframe.

10. Use histograms to examine the distributions of `price_3_nights` and `log(price_3_nights)`. Based on the histograms,  which variable should you use for the regression model? Briefly explain.  

Use this variable as the response for the remainder of the lab.

11. Fit a regression model called `model1` with the response variable from the previous question and the following predictor variables: `prop_type_simp`, `number_of_reviews`, and `review_scores_rating`. Display the model output. 

12. Interpret the coefficient `review_scores_rating` in terms of `price_3_nights`.

13. Interpret the coefficient of `prop_type_simpGuest suite` in terms of `price_3_nights`.

14. We want to determine if `room_type` is a significant predictor of the cost for 3 nights, given everything else in the model. Fit a regression model called `model2` that includes all of the predictor variables in `model1` and `room_type`. Display the model output. 

Use the code below to conduct a Nested F test to determine if `room_type` is a significant predictor of the minimum cost. What is your conclusion from the Nested F test? 




15. Suppose you are planning to visit Asheville over spring break, and you want to stay in an Airbnb. You find an Airbnb that is an apartment with a private room, has 10 reviews, and an average rating of 90. Use `model2` to predict the total cost to stay at this Airbnb for 3 nights. Include the appropriate 95% interval with your prediction. Report the prediction and interval in terms of `price_3_nights`. 

*You're done! Commit all remaining changes, use the commit message "Done with Lab 5!", and push. Before you wrap up the assignment, make sure the .Rmd and .md  documents are updated in your GitHub repo. There is a 10% penalty if the .Rmd file has to be knitted to display graphs, i.e. the graphs are not showing in the .md file on GitHub.*

### Acknowledgement

The data from this lab is from [insideairbnb.com](http://insideairbnb.com/index.html)

## Analyzing Wages 







### Initial model



### Model with mean-centered variables



- Calculate the regression model using the mean-centered variables. 



- How did the model change?

### Model with indicator variables

- Use the code below to create a categorical variable for `Educ`.



- Calculate the regression model using `EducCat` instead of `Educ`.



## NOTES: Matrix Form of Linear Regression



This document provides the details for the matrix form of multiple linear regression. We assume the reader has familiarity with some matrix alegbra. Please see Chapter 1 of [*An Introduction to Statistical Learning*](https://www-bcf.usc.edu/~gareth/ISL/) for a brief review of matrix algebra. 

### Introduction 


Suppose we have $n$ observations. Let the $i^{th}$ be $(x_{i1}, \ldots, x_{ip}, y_i)$, such that $x_{i1}, \ldots, x_{ip}$ are the explanatory variables (predictors) and $y_i$ is the response variable. We assume the data can be modeled using the least-squares regression model, such that the mean response for a given combination of explanatory variables follows the form in (\ref{basic_model}).

\begin{equation}
\label{basic_model}
y = \beta_0 + \beta_1 x_1 + \dots + \beta_p x_p 
\end{equation}

We can write the response for the $i^{th}$ observation as shown in (\ref{ind_response})

\begin{equation}
\label{ind_response}
y_i = \beta_0 + \beta_1 x_{i1} + \dots + \beta_p x_{ip} + \epsilon_i 
\end{equation}

such that $\epsilon_i$ is the amount $y_i$ deviates from $\mu\{y|x_{i1}, \ldots, x_{ip}\}$, the mean response for a given combination of explanatory variables. We assume each $\epsilon_i \sim N(0,\sigma^2)$, where $\sigma^2$ is a constant variance for the distribution of the response $y$ for any combination of explanatory variables $x_1, \ldots, x_p$. 

### Matrix Form for the Regression Model 

We can represent the (\ref{basic_model}) and (\ref{ind_response}) using matrix notation. Let 

\begin{equation}
\label{matrix notation}
\mathbf{Y} = \begin{bmatrix}y_1 \\ y_2 \\ \vdots \\y_n\end{bmatrix} 
\hspace{15mm}
\mathbf{X} = \begin{bmatrix}x_{11} & x_{12} & \dots & x_{1p} \\
x_{21} & x_{22} & \dots & x_{2p} \\
\vdots & \vdots & \ddots & \vdots\\
x_{n1} & x_{n2} & \dots & x_{np} \end{bmatrix}
\hspace{15mm}
\boldsymbol{\beta}= \begin{bmatrix}\beta_0 \\ \beta_1 \\ \vdots \\ \beta_p \end{bmatrix} 
\hspace{15mm}
\boldsymbol{\epsilon}= \begin{bmatrix}\epsilon_1 \\ \epsilon_2 \\ \vdots \\ \epsilon_n \end{bmatrix}
\end{equation}

Thus, 

$$\mathbf{Y} = \mathbf{X}\boldsymbol{\beta} + \mathbf{\epsilon}$$

Therefore the estimated response for a given combination of explanatory variables and the associated residuals can be written as

\begin{equation}
\label{matrix_mean}
\hat{\mathbf{Y}} = \mathbf{X}\hat{\boldsymbol{\beta}} \hspace{10mm} \mathbf{e} = \mathbf{Y} - \mathbf{X}\hat{\boldsymbol{\beta}}
\end{equation}

### Estimating the Coefficients

The least-squares model is the one that minimizes the sum of the squared residuals. Therefore, we want to find the coefficients, $\hat{\boldsymbol{\beta}}$ that minimizes

\begin{equation}
\label{sum_sq_resid}
\sum\limits_{i=1}^{n} e_{i}^2 = \mathbf{e}^T\mathbf{e} = (\mathbf{Y} - \mathbf{X}\hat{\boldsymbol{\beta}})^T(\mathbf{Y} - \mathbf{X}\hat{\boldsymbol{\beta}})
\end{equation}

where $\mathbf{e}^T$, the transpose of the matrix $\mathbf{e}$. 

\begin{equation}
\label{model_equation}
(\mathbf{Y} - \mathbf{X}\hat{\boldsymbol{\beta}})^T(\mathbf{Y} - \mathbf{X}\hat{\boldsymbol{\beta}}) = (\mathbf{Y}^T\mathbf{Y} - 
\mathbf{Y}^T \mathbf{X}\hat{\boldsymbol{\beta}} - (\hat{\boldsymbol{\beta}}{}^{T}\mathbf{X}^T\mathbf{Y} +
\hat{\boldsymbol{\beta}}{}^{T}\mathbf{X}^T\mathbf{X}
\hat{\boldsymbol{\beta}})
\end{equation}

Note that $(\mathbf{Y^T}\mathbf{X}\hat{\boldsymbol{\beta}})^T = \hat{\boldsymbol{\beta}}{}^{T}\mathbf{X}^T\mathbf{Y}$. Since these are both constants (i.e. $1\times 1$ vectors), $\mathbf{Y^T}\mathbf{X}\hat{\boldsymbol{\beta}} = \hat{\boldsymbol{\beta}}{}^{T}\mathbf{X}^T\mathbf{Y}$. Thus, (\ref{model_equation}) becomes 

\begin{equation}
\mathbf{Y}^T\mathbf{Y} - 2 \mathbf{X}^T\hat{\boldsymbol{\beta}}{}^{T}\mathbf{Y} + \hat{\boldsymbol{\beta}}{}^{T}\mathbf{X}^T\mathbf{X}
\hat{\boldsymbol{\beta}}
\end{equation}

Since we want to find the $\hat{\boldsymbol{\beta}}$ that minimizes (\ref{sum_sq_resid}), will find the value of $\hat{\boldsymbol{\beta}}$ such that the derivative with respect to $\hat{\boldsymbol{\beta}}$ is equal to 0. 

\begin{equation}
\begin{aligned}
\frac{\partial \mathbf{e}^T\mathbf{e}}{\partial \hat{\boldsymbol{\beta}}} & = \frac{\partial}{\partial \hat{\boldsymbol{\beta}}}(\mathbf{Y}^T\mathbf{Y} - 2 \mathbf{X}^T\hat{\boldsymbol{\beta}}{}^T\mathbf{Y} + \hat{\boldsymbol{\beta}}{}^{T}\mathbf{X}^T\mathbf{X}\hat{\boldsymbol{\beta}}) = 0 \\[10pt]
&\Rightarrow - 2 \mathbf{X}^T\mathbf{Y} + 2 \mathbf{X}^T\mathbf{X}\hat{\boldsymbol{\beta}} = 0 \\[10pt]
& \Rightarrow 2 \mathbf{X}^T\mathbf{Y} = 2 \mathbf{X}^T\mathbf{X}\hat{\boldsymbol{\beta}} \\[10pt]
& \Rightarrow \mathbf{X}^T\mathbf{Y} = \mathbf{X}^T\mathbf{X}\hat{\boldsymbol{\beta}} \\[10pt]
& \Rightarrow (\mathbf{X}^T\mathbf{X})^{-1}\mathbf{X}^T\mathbf{Y} = (\mathbf{X}^T\mathbf{X})^{-1}\mathbf{X}^T\mathbf{X}\hat{\boldsymbol{\beta}} \\[10pt]
& \Rightarrow (\mathbf{X}^T\mathbf{X})^{-1}\mathbf{X}^T\mathbf{Y} = \mathbf{I}\hat{\boldsymbol{\beta}}
\end{aligned}
\end{equation}

Thus, the estimate of the model coefficients is $\hat{\boldsymbol{\beta}} = (\mathbf{X}^T\mathbf{X})^{-1}\mathbf{X}^T\mathbf{Y}$.


### Variance-covariance matrix of the coefficients

We will use two properties to derive the form of the variance-covarinace matrix of the coefficients: 

1. $E[\boldsymbol{\epsilon}\boldsymbol{\epsilon}^T] = \sigma^2I$
2. $\hat{\boldsymbol{\beta}} = \boldsymbol{\beta} + (\mathbf{X}^T\mathbf{X})^{-1}\epsilon$

First, we will show that $E[\boldsymbol{\epsilon}\boldsymbol{\epsilon}^T] = \sigma^2I$
\begin{equation}
\label{expected_error}
\begin{aligned}
E[\boldsymbol{\epsilon}\boldsymbol{\epsilon}^T] &= E \begin{bmatrix}\epsilon_1  & \epsilon_2 & \dots & \epsilon_n \end{bmatrix}\begin{bmatrix}\epsilon_1 \\ \epsilon_2 \\ \vdots \\ \epsilon_n \end{bmatrix}  \\[10pt]
& = E \begin{bmatrix} \epsilon_1^2  & \epsilon_1 \epsilon_2 & \dots & \epsilon_1 \epsilon_n \\
\epsilon_2 \epsilon_1 & \epsilon_2^2 & \dots & \epsilon_2 \epsilon_n \\ 
\vdots & \vdots & \ddots & \vdots \\ 
\epsilon_n \epsilon_1 & \epsilon_n \epsilon_2 & \dots & \epsilon_n^2 
\end{bmatrix} \\[10pt]
& = \begin{bmatrix} E[\epsilon_1^2]  & E[\epsilon_1 \epsilon_2] & \dots & E[\epsilon_1 \epsilon_n] \\
E[\epsilon_2 \epsilon_1] & E[\epsilon_2^2] & \dots & E[\epsilon_2 \epsilon_n] \\
\vdots & \vdots & \ddots & \vdots \\ 
E[\epsilon_n \epsilon_1] & E[\epsilon_n \epsilon_2] & \dots & E[\epsilon_n^2]
\end{bmatrix}
\end{aligned}
\end{equation}

Recall, the regression assumption that the errors $\epsilon_i's$ are Normally distributed with mean 0 and variance $\sigma^2$. Thus, $E(\epsilon_i^2) = Var(\epsilon_i) = \sigma^2$ for all $i$. Additionally, recall the regression assumption that the errors are uncorrelated, i.e. $E(\epsilon_i \epsilon_j) = Cov(\epsilon_i, \epsilon_j) = 0$ for all $i,j$. Using these assumptions, we can write (\ref{expected_error}) as 

\begin{equation}
E[\mathbf{\epsilon}\mathbf{\epsilon}^T]  = \begin{bmatrix} \sigma^2  & 0 & \dots & 0 \\
0 & \sigma^2  & \dots & 0 \\
\vdots & \vdots & \ddots & \vdots \\
0 & 0 & \dots & \sigma^2
\end{bmatrix} = \sigma^2 \mathbf{I}
\end{equation}

where $\mathbf{I}$ is the $n \times n$ identity matrix.


Next, we show that $\hat{\boldsymbol{\beta}} = \boldsymbol{\beta} + (\mathbf{X}^T\mathbf{X})^{-1}\epsilon$.

Recall that the $\hat{\boldsymbol{\beta}} = (\mathbf{X}^T\mathbf{X})^{-1}\mathbf{X}^T\mathbf{Y}$ and $\mathbf{Y} = \mathbf{X}\mathbf{\beta} + \mathbf{\epsilon}$.  Then,

\begin{equation}
\begin{aligned}
\hat{\boldsymbol{\beta}} &= (\mathbf{X}^T\mathbf{X})^{-1}\mathbf{X}^T\mathbf{Y} \\[10pt]
&= (\mathbf{X}^T\mathbf{X})^{-1}\mathbf{X}^T(\mathbf{X}\boldsymbol{\beta} + \boldsymbol{\epsilon}) \\[10pt]
&= \boldsymbol{\beta} + (\mathbf{X}^T\mathbf{X})^{-1}\mathbf{X}^T \mathbf{\epsilon} \\
\end{aligned}
\end{equation}


Using these two properties, we derive the form of the variance-covariance matrix for the coefficients. Note that the covariance matrix is $E[(\hat{\boldsymbol{\beta}} - \boldsymbol{\beta})(\hat{\boldsymbol{\beta}} - \boldsymbol{\beta})^T]$

\begin{equation}
\begin{aligned}
E[(\hat{\boldsymbol{\beta}} - \boldsymbol{\beta})(\hat{\boldsymbol{\beta}} - \boldsymbol{\beta})^T] &= E[(\boldsymbol{\beta} + (\mathbf{X}^T\mathbf{X})^{-1} \mathbf{X}^T \boldsymbol{\epsilon} - \boldsymbol{\beta})(\boldsymbol{\beta} + (\mathbf{X}^T\mathbf{X})^{-1} \mathbf{X}^T \boldsymbol{\epsilon} - \boldsymbol{\beta})^T]\\[10pt]
& = E[(\mathbf{X}^T\mathbf{X})^{-1} \mathbf{X}^T \boldsymbol{\epsilon}\boldsymbol{\epsilon}^T\mathbf{X}(\mathbf{X}^T\mathbf{X})^{-1}] \\[10pt]
& = (\mathbf{X}^T\mathbf{X})^{-1} \mathbf{X}^T E[\boldsymbol{\epsilon}\boldsymbol{\epsilon}^T]\mathbf{X}(\mathbf{X}^T\mathbf{X})^{-1}\\[10pt]
& = (\mathbf{X}^T\mathbf{X})^{-1} \mathbf{X}^T (\sigma^2\mathbf{I})\mathbf{X}(\mathbf{X}^T\mathbf{X})^{-1}\\
&= \sigma^2\mathbf{I}(\mathbf{X}^T\mathbf{X})^{-1}\mathbf{X}^T\mathbf{X}(\mathbf{X}^T\mathbf{X})^{-1}\\[10pt]
& = \sigma^2\mathbf{I}(\mathbf{X}^T\mathbf{X})^{-1}\\[10pt]
&  = \sigma^2(\mathbf{X}^T\mathbf{X})^{-1} \\
\end{aligned}
\end{equation}

***













## NOTES: Log Transformations






This document provides details about the model interpretion when the predictor and/or response variables are log-transformed. For simplicity, we will discuss transformations for the simple linear regression model: 

\begin{equation}
\label{orig}
y = \beta_0 + \beta_1 x
\end{equation}


All results and interpretations can be easily extended to transformations in multiple regression models.

*Note*: *log* refers to the natural logarithm. 

### Log-transformation on the response variable

Suppose we fit a linear regression model with $\log(y)$, the log-transformed $y$, as the response variable. Under this model, we assume a linear relationship exists between $x$ and $\log(y)$, such that $\log(y) \sim N(\beta_0 + \beta_1 x, \sigma^2)$ for some $\beta_0$, $\beta_1$ and $\sigma^2$. In other words, we can model the relationship between $x$ and $\log(y)$ using the model in (\ref{log-y}).

\begin{equation}
\label{log-y}
\log(y) = \beta_0 + \beta_1 x
\end{equation}

If we interpret the model in terms of $\log(y)$, then we can use the usual interpretations for slope and intercept. When reporting results, however, it is best to give all interpretations in terms of the original response variable $y$, since interpretations using log-transformed variables are often more difficult to truly understand.

In order to get back on the original scale, we need to use the exponential function (also known as the anti-log), $\exp\{x\} = e^x$. Therefore, we use the model in (\ref{log-y}) for interpretations and predictions, we will use (\ref{exp-y}) to state our conclusions in terms of $y$.

\begin{equation}
\label{exp-y}
\begin{aligned}
&\exp\{\log(y)\} = \exp\{\beta_0 + \beta_1 x\} \\[10pt]
\Rightarrow &y = \exp\{\beta_0 + \beta_1 x\} \\[10pt]
\Rightarrow &y = \exp\{\beta_0\}\exp\{\beta_1 x\}
\end{aligned}
\end{equation}

In order to interpret the slope and intercept, we need to first understand the relationship between the mean, median and log transformations.

#### Mean, Median, and Log Transformations 

Suppose we have a dataset `y` that contains the following observations:



If we log-transform the values of `y` then calculate the mean and median, we have
 


If we calculate the mean and median of `y`, then log-transform the mean and median, we have



This is a simple illustration to show 

1. $\text{Mean}[{\log(y)}] \neq \log[\text{Mean}(y)]$ - the mean and log are not commutable

2. $\text{Median}[\log(y)] = \log[\text{Median}(y)]$ - the median and log are commutable

#### Interpretaton of model coefficients

Using (\ref{log-y}), the mean $\log(y)$ for any given value of $x$ is $\beta_0 + \beta_1 x$; however, this does **not** indicate that the mean of $y = \exp\{\beta_0 + \beta_1 x\}$ (see previous section). From the assumptions of linear regression, we assume that for any given value of $x$, the distribution of $\log(y)$ is Normal, and therefore symmetric. Thus the median of $\log(y)$ is equal to the mean of $\log(y)$, i.e $\text{Median}(\log(y)) = \beta_0 + \beta_1 x$. 

Since the log and the median are commutable, $\text{Median}(\log(y)) = \beta_0 + \beta_1 x \Rightarrow \text{Median}(y) = \exp\{\beta_0 + \beta_1 x\}$. Thus, when we log-transform the response variable, the interpretation of the intercept and slope are in terms of the effect on the **median** of $y$. 

**Intercept**: The intercept is expected median of $y$ when the predictor variable equals 0. Therefore, when $x=0$, 

\begin{equation}
\begin{aligned}
&\log(y) = \beta_0 + \beta_1 \times 0 = \beta_0 \\[10pt]
\Rightarrow &y = \exp\{\beta_0\}
\end{aligned}
\end{equation}

*Interpretation: When $x=0$, the median of $y$ is expected to be $\exp\{\beta_0\}$.*

**Slope**: The slope is the expected change in the median of $y$ when $x$ increases by 1 unit. The change in the median of $y$ is

\begin{equation}
\exp\{[\beta_0 + \beta_1 (x+1)] - [\beta_0 + \beta_1 x]\} = \frac{\exp\{\beta_0 + \beta_1 (x+1)\}}{\exp\{\beta_0 + \beta_1 x\}} = \frac{\exp\{\beta_0\}\exp\{\beta_1 x\}\exp\{\beta_1\}}{\exp\{\beta_0\}\exp\{\beta_1 x\}} = \exp\{\beta_1\}
\end{equation}

Thus, the median of $y$ for $x+1$ is $\exp\{\beta_1\}$ times the median of $y$ for $x$.  

*Interpretation: When $x$ increases by one unit, the median of $y$ is expected to multiply by a factor of $\exp\{\beta_1\}$.*

### Log-transformation on the predictor variable 

Suppose we fit a linear regression model with $\log(x)$, the log-transformed $x$, as the predictor variable. Under this model, we assume a linear relationship exists between $\log(x)$ and $y$, such that $y \sim N(\beta_0 + \beta_1 \log(x), \sigma^2)$ for some $\beta_0$, $\beta_1$ and $\sigma^2$. In other words, we can model the relationship between $\log(x)$ and $y$ using the model in (\ref{log-x}).

\begin{equation}
\label{log-x}
y = \beta_0 + \beta_1 \log(x)
\end{equation}

**Intercept**: The intercept is the mean of $y$ when $\log(x) = 0$, i.e. $x = 1$. 

*Interpretation: When $x = 1$ $(\log(x) = 0)$, the mean of $y$ is expected to be $\beta_0$.*

**Slope**: The slope is interpreted in terms of the change in the mean of $y$ when $x$ is mutliplied by a factor of $C$, since $\log(Cx) = \log(x) + \log(C)$. Thus, when $x$ is multiplied by a factor of $C$, the change in the mean of $y$ is 

\begin{equation}
\begin{aligned}
[\beta_0 + \beta_1 \log(Cx)] - [\beta_0 + \beta_1 \log(x)] &= \beta_1 [\log(Cx) - \log(x)] \\[10pt] 
& = \beta_1[\log(C) + \log(x) - \log(x)] \\[10pt] 
& = \beta_1 \log(C)
\end{aligned}
\end{equation}

Thus the mean of $y$ changes by $\beta_1 \log(C)$ units. 

*Interpretation: When $x$ is multiplied by a factor of $C$, the mean of $y$ is expected to change by $\beta_1 \log(C)$ units. For example, if $x$ is doubled, then the mean of $y$ is expected to change by $\beta_1 \log(2)$ units.*

### Log-transformation on the the response and predictor variable

Suppose we fit a linear regression model with $\log(x)$, the log-transformed $x$, as the predictor variable and $\log(y)$, the log-transformed $y$, as the response variable. Under this model, we assume a linear relationship exists between $\log(x)$ and $\log(y)$, such that $\log(y) \sim N(\beta_0 + \beta_1 \log(x), \sigma^2)$ for some $\beta_0$, $\beta_1$ and $\sigma^2$. In other words, we can model the relationship between $\log(x)$ and $\log(y)$ using the model in (\ref{log-x-y}).

\begin{equation}
\label{log-x-y}
\log(y) = \beta_0 + \beta_1 \log(x)
\end{equation}

Because the response variable is log-transformed, the interpretations on the original scale will be in terms of the median of $y$ (see the section on the log-transformed response variable for more detail).

**Intercept**: The intercept is the mean of $y$ when $\log(x) = 0$, i.e. $x = 1$.  Therefore, when $\log(x) = 0$, 

\begin{equation}
\begin{aligned}
&\log(y) = \beta_0 + \beta_1 \times 0 = \beta_0 \\[10pt]
\Rightarrow &y = \exp\{\beta_0\}
\end{aligned}
\end{equation}

*Interpretation: When $x = 1$ $(\log(x) = 0)$, the median of $y$ is expected to be $\exp\{\beta_0\}$.*

**Slope**: The slope is interpreted in terms of the change in the median $y$ when $x$ is mutliplied by a factor of $C$, since $\log(Cx) = \log(x) + \log(C)$. Thus, when $x$ is multiplied by a factor of $C$, the change in the median of $y$ is 

\begin{equation}
\begin{aligned}
\exp\{[\beta_0 + \beta_1 \log(Cx)] - [\beta_0 + \beta_1 \log(x)]\} &= 
\exp\{\beta_1 [\log(Cx) - \log(x)]\} \\[10pt] 
& = \exp\{\beta_1[\log(C) + \log(x) - \log(x)]\} \\[10pt] 
& = \exp\{\beta_1 \log(C)\} = C^{\beta_1}
\end{aligned}
\end{equation}

Thus, the median of $y$ for $Cx$ is $C^{\beta_1}$ times the median of $y$ for $x$.  

*Interpretation: When $x$ is multiplied by a factor of $C$, the median of $y$ is expected to multiple by a factor of $C^{\beta_1}$. For example, if $x$ is doubled, then the median of $y$ is expected to multiply by $2^{\beta_1}$.*

***






## NOTES: Model Diagnostics



This document discusses some of the mathematical details of the model diagnostics - leverage, standardized residuals, and Cook's distance. We assume the reader knowledge of the matrix form for multiple linear regression.Please see [Matrix Form of Linear Regression](https://github.com/STA210-Sp19/supplemental-notes/blob/master/regression-basics-matrix.pdf) for a review.

### Introduction 

Suppose we have $n$ observations. Let the $i^{th}$ be $(x_{i1}, \ldots, x_{ip}, y_i)$, such that $x_{i1}, \ldots, x_{ip}$ are the explanatory variables (predictors) and $y_i$ is the response variable. We assume the data can be modeled using the least-squares regression model, such that the mean response for a given combination of explanatory variables follows the form in (\ref{basic_model}).

\begin{equation}
\label{basic_model}
y = \beta_0 + \beta_1 x_1 + \dots + \beta_p x_p 
\end{equation}

We can write the response for the $i^{th}$ observation as shown in (\ref{ind_response})

\begin{equation}
\label{ind_response}
y_i = \beta_0 + \beta_1 x_{i1} + \dots + \beta_p x_{ip} + \epsilon_i 
\end{equation}

such that $\epsilon_i$ is the amount $y_i$ deviates from $\mu\{y|x_{i1}, \ldots, x_{ip}\}$, the mean response for a given combination of explanatory variables. We assume each $\epsilon_i \sim N(0,\sigma^2)$, where $\sigma^2$ is a constant variance for the distribution of the response $y$ for any combination of explanatory variables $x_1, \ldots, x_p$. 

### Matrix Form for the Regression Model 

We can represent the (\ref{basic_model}) and (\ref{ind_response}) using matrix notation. Let 

\begin{equation}
\label{matrix notation}
\mathbf{Y} = \begin{bmatrix}y_1 \\ y_2 \\ \vdots \\y_n\end{bmatrix} 
\hspace{15mm}
\mathbf{X} = \begin{bmatrix}x_{11} & x_{12} & \dots & x_{1p} \\
x_{21} & x_{22} & \dots & x_{2p} \\
\vdots & \vdots & \ddots & \vdots\\
x_{n1} & x_{n2} & \dots & x_{np} \end{bmatrix}
\hspace{15mm}
\boldsymbol{\beta}= \begin{bmatrix}\beta_0 \\ \beta_1 \\ \vdots \\ \beta_p \end{bmatrix} 
\hspace{15mm}
\boldsymbol{\epsilon}= \begin{bmatrix}\epsilon_1 \\ \epsilon_2 \\ \vdots \\ \epsilon_n \end{bmatrix}
\end{equation}

Thus, 

$$\mathbf{Y} = \mathbf{X}\boldsymbol{\beta} + \mathbf{\epsilon}$$

Therefore the estimated response for a given combination of explanatory variables and the associated residuals can be written as

\begin{equation}
\label{matrix_mean}
\hat{\mathbf{Y}} = \mathbf{X}\hat{\boldsymbol{\beta}} \hspace{10mm} \mathbf{e} = \mathbf{Y} - \mathbf{X}\hat{\boldsymbol{\beta}}
\end{equation}

### Hat Matrix & Leverage

Recall from the notes [**Matrix Form of Linear Regression**](https://github.com/STA210-Sp19/supplemental-notes/blob/master/regression-basics-matrix.pdf) that $\hat{\boldsymbol{\beta}}$ can be written as the following: 

\begin{equation}
\label{beta-hat}
\hat{\boldsymbol{\beta}} = (\mathbf{X}^T\mathbf{X})^{-1}\mathbf{X}^T\mathbf{Y}
\end{equation}

Combining (\ref{matrix_mean}) and (\ref{beta-hat}), we can write $\hat{\mathbf{Y}}$ as the following: 

\begin{equation}
\label{y-hat}
\begin{aligned}
\hat{\mathbf{Y}} &= \mathbf{X}\hat{\boldsymbol{\beta}} \\[10pt]
&= \mathbf{X}(\mathbf{X}^T\mathbf{X})^{-1}\mathbf{X}^T\mathbf{Y}\\
\end{aligned}
\end{equation}

We define the **hat matrix** as an $n \times n$ matrix of the form $\mathbf{H} = \mathbf{X}(\mathbf{X}^T\mathbf{X})^{-1}\mathbf{X}^T$. Thus (\ref{y-hat}) becomes 

\begin{equation}
\label{y-hat-matrix}
\hat{\mathbf{Y}} = \mathbf{H}\mathbf{Y}
\end{equation}

The diagonal elements of the hat matrix are a measure of how far the predictor variables of each observation are from the means of the predictor variables. For example, $h_{ii}$ is a measure of how far the values of the predictor variables for the $i^{th}$ observation, $x_{i1}, x_{i2}, \ldots, x_{ip}$, are from the mean values of the predictor variables, $\bar{x}_1, \bar{x}_2, \ldots, \bar{x}_p$. In the case of simple linear regression, the $i^{th}$ diagonal, $h_{ii}$, can be written as

$$h_{ii} =  \frac{1}{n} + \frac{(x_i - \bar{x})^2}{\sum_{j=1}^{n}(x_j-\bar{x})^2}$$

We call these diagonal elements, the **leverage** of each observation. 

The diagonal elements of the hat matrix have the following properties: 

- $0 \leq h_ii \leq 1$
- $\sum\limits_{i=1}^{n} h_{ii} = p+1$, where $p$ is the number of predictor variables in the model.
- The mean hat value is $\bar{h} = \frac{\sum\limits_{i=1}^{n} h_{ii}}{n} = \frac{p+1}{n}$. 

Using these properties, we consider a point to have **high leverage** if it has a leverage value that is more than 2 times the average. In other words, observations with leverage greater than $\frac{2(p+1)}{n}$ are considered to be **high leverage** points, i.e. outliers in the predictor variables. We are interested in flagging high leverage points, because they may have an influence on the regression coefficients. 

When there are high leverage points in the data, the regression line will tend towards those points; therefore, one property of high leverage points is that they tend to have small residuals. We will show this by rewriting the residuals from (\ref{matrix_mean}) using (\ref{y-hat-matrix}).

\begin{equation}
\label{resid-hat}
\begin{aligned}
\mathbf{e} &= \mathbf{Y} - \hat{\mathbf{Y}} \\[10pt]
& = \mathbf{Y} - \mathbf{H}\mathbf{Y} \\[10pt]
&= (1-\mathbf{H})\mathbf{Y}
\end{aligned}
\end{equation}

Note that the identity matrix and hat matrix are **idempotent**, i.e. $\mathbf{I}\mathbf{I} = \mathbf{I}$, $\mathbf{H}\mathbf{H} = \mathbf{H}$. Thus, $(\mathbf{I} - \mathbf{H}$ is also idempotent. These matrices are also symmetric. Using these properties and  (\ref{resid-hat}), we have that the variance-covariance matrix of the residuals $\boldsymbol{e}$, is 


\begin{equation}
\label{resid-var}
\begin{aligned}
Var(\mathbf{e}) &= \mathbf{e}\mathbf{e}^T \\[10pt]
&=  (1-\mathbf{H})Var(\mathbf{Y})^T(1-\mathbf{H})^T \\[10pt]
&= (1-\mathbf{H})\hat{\sigma}^2(1-\mathbf{H})^T  \\[10pt]
&= \hat{\sigma}^2(1-\mathbf{H})(1-\mathbf{H})  \\[10pt]
&= \hat{\sigma}^2(1-\mathbf{H})
\end{aligned}
\end{equation}

where $\hat{\sigma}^2 = \frac{\sum_{i=1}^{n}e_i^2}{n-p-1}$ is the estimated regression variance. Thus, the variance of the $i^{th}$ residual is $Var(e_i) = \hat{\sigma}^2(1-h_{ii})$. Therefore, the higher the leverage, the smaller the variance of the residual. Because the expected value of the residuals is 0, we conclude that points with high leverage tend to have smaller residuals than points with lower leverage.

### Standardized Residuals 

In general, we standardize a value by shifting by the expected value and rescaling by the standard deviation (or standard error). Thus, the $i^{th}$ standardized residual takes the form 

$$std.res_i = \frac{e_i - E(e_i)}{SE(e_i)}$$

The expected value of the residuals is 0, i.e. $E(e_i) = 0$. From (\ref{resid-var}), the standard error of the residual is $SE(e_i) = \hat{\sigma}\sqrt{1-h_{ii}}$. Therefore, 

\begin{equation}
\label{std.resid.}
std.res_i = \frac{e_i}{\hat{\sigma}\sqrt{1-h_{ii}}}
\end{equation}

### Cook's Distance

Cook's distance is a measure of how much each observation influences the model coefficients, and thus the predicted values. The Cook's distance for the $i^{th}$ observation can be written as 

\begin{equation}
\label{cooksd}
D_i = \frac{(\hat{\mathbf{Y}} -\hat{\mathbf{Y}}_{(i)})^T(\hat{\mathbf{Y}} -\hat{\mathbf{Y}}_{(i)})}{(p+1)\hat{\sigma}}
\end{equation}

where $\hat{\mathbf{Y}}_{(i)}$ is the vector of predicted values from the model fitted when the $i^{th}$ observation is deleted. Cook's Distance can be calculated without deleting observations one at a time, since (\ref{cooksd-v2}) below is mathematically equivalent to  (\ref{cooksd}). 

\begin{equation}
\label{cooksd-v2}
D_i = \frac{1}{p+1}std.res_i^2\Bigg[\frac{h_{ii}}{(1-h_{ii})}\Bigg] = \frac{e_i^2}{(p+1)\hat{\sigma}^2(1-h_{ii})}\Bigg[\frac{h_{ii}}{(1-h_{ii})}\Bigg]
\end{equation}






