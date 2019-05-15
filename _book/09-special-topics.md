# Special Topics {#special}


## Putting It All Together 



In this lab, you will put together everything you've learned thus far. Unlike previous lab assignments, your lab write up will be in the form of a small report (rather than numbered exercises). Though this analysis will not be as in-depth as your analysis in the final project, this assignment will give your group practice organizing the results of a statistical analysis to tell a complete narrative. 

You will also practice imputing missing data and using k-fold cross validation to assess your model's performance on test data.

### Packages

You will need the following packages for today's lab: 


```r
library(tidyverse)
library(dslabs)
## Fill in other packages as needed
```

### Data

The data for this lab is the `gapminder` dataset in the **dslabs** package. This dataset contains health and income data for 184 countries during the years 1960 to 2016. After loading the dslabs package, you can type `?gapminder` in the console to to see the variables in the dataset. 

**You will only use data from 2011 in this lab.** 

### Exercises

The goal of this analysis is to build a regression model that could be used to predict a country's gross domestic product (`gdp`) using the other characteristics included in the data. 

**<u>Introduction</u>**

Brief introduction of the data and the research question

**<u>Exploratory Data Analysis</u>** 

At a minimum, your exploratory data analysis should include the following: 

- Analysis of each variable 
- Dealing with missing values using imputation methods
- Analysis of the relationships between variables
- Discussion of any potential transformations, if needed

**<u>Regression Model</u>**

At a minimum, the discussion for the final regression model should include the following: 

- Brief discussion about the type of model you used (multiple linear regression, logistic, multinomial logistic regression) and why
- Discussion of any transformations on the response and/or explanatory variables, if applicable 
- Display of the final model
- Test of interesting interactions
- Conclusions drawn from the model, including any interesting insights based on the model coefficients

**<u>Assumptions</u>**

At a minimum, the discussion of model assumptions should include the following: 

- Appropriate residual plots
- Check for influential points
- Check for multicollinearity 
- Discussion of whether or not assumptions are met and how any issues may affect conclusions drawn from the model

**<u>Model Validation</u>** 

At a minimum, the discussion of the model validation should include the following: 

- Results and discussion from a 5-fold cross validation 

**<u>Conclusion</u>**

Brief summary of the conclusions drawn from the analysis.

## IN-CLASS: Missing Data Exercise





```r
library(tidyverse)
library(knitr)
library(broom)
library(skimr)
library(nnet)
```


```r
nhanes <- mice::nhanes2
nhanes
```

1. Explore missingness 


```r
library(nnet)
m <- multinom(age ~ bmi + hyp + chl, data = mice::nhanes2)
knitr::kable(tidy(m, conf.int = T),format = "markdown")
```


2. Complete-case analyis


```r
complete <- nhanes %>% drop_na()
m <- multinom(age ~ bmi + hyp + chl, data = complete)
knitr::kable(tidy(m, conf.int = T),format = "markdown")
```


3. Single imputation 




4. Indicator variables






