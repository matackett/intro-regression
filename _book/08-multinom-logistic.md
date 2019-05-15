# Multinomial Logistic Regression {#multinom-logistic}


## COMP: General Social Survey



The General Social Survey (GSS) has been used to measure trends in attitudes and behaviors in American society since 1972. In addition to collecting demographic information, the survey includes questions used to gauge attitudes about government spending priorities, confidence in institutions, lifestyle, and many other topics. A full description of the survey may be found [here](http://www.norc.org/Research/Projects/Pages/general-social-survey.aspx).

In today's lab, we will use multinomial logistic regression to understand the relationship between a person's political views and their attitudes towards government spending on mass transportation projects. To do so, we will use data from the 2010 GSS survey. Refer to the [Multinomial Logistic Regression notes](https://www2.stat.duke.edu/courses/Spring19/sta210.001/slides/lec-slides/18-multinomial-logistic-pt2.html#1) for help with concepts and code.



### Packages

You will need the following packages for today's lab: 


```r
library(tidyverse)
library(nnet)
library(knitr)
library(broom)
## Fill in other packages as needed
```

### Data

The data for this lab is from the 2016 General Social Survey. The original data set contains 2867 observations and 935 variables. Given the size of the dataset, we will handle it differently in our workflow than we've handled data in previous assignments. 


```r
# [Working with large files](https://help.github.com/en/articles/working-with-large-files)
```

The size of this dataset is 34.3 MB. Compare that to the Spotify dataset from last weeks' lab which was 149 KB (0.149 MB)! GitHub will not allow you to push files larger than 100 MB and will give you a warning when you push files as large as 50 MB. Though we could push the file we're working with today to GitHub, it's large enough that we'd still prefer not to. 

You have may noticed that each repo contains a file called `.gitignore`. It contains a list of the files you don't want commit or push to GitHub. If you look at the `.gitignore` file for today's lab, you will notice that `gss2016.csv` is listed at the bottom. 

- Click [**here**](https://www2.stat.duke.edu/courses/Spring19/sta210.001/labs/data/gss2016.csv) to download `gss2016.csv`.
- Upload `gss2016.csv` into the data folder of your project. 
- Notice that `gss2016.csv` does not appear in your Git pane. This is because it is being ignored by git, since it is listed in the `.gitignore` file.

You will use the following variables in the lab: 

- `natmass`: Respondent's answer to the following prompt:

    "We are faced with many problems in this country, none of which can be solved easily or inexpensively. I’m going to name some of these problems, and for each one I’d like you to tell me whether you think we’re spending too much money on it, too little money, or about the right amount...are we spending too much, too little, or about the right amount on mass transportation?"

- `age`: Age in years.
- `sex`: Sex recorded as *male* or *female*
- `sei10`: Socioeconomic index from 0 to 100
- `region`: Region where interview took place
- `polviews`: Respondent's answer to the following prompt: 

    "We hear a lot of talk these days about liberals and conservatives. I’m going to show you a seven-point scale on which the political views that people might hold are arranged from extremely liberal - point 1 - to extremely conservative - point 7. Where would you place yourself on this scale?"

Use the code below to read in the data.


```r
gss <- read_csv("data/gss2016.csv",
  na = c("", "Don't know", "No answer", 
         "Not applicable"), 
         guess_max = 2867) %>%
  select(natmass, age, sex, sei10, region, polviews) %>%
  drop_na()
```

The argument `guess_max = 2867` tells the `read_csv` function to use all of the observations in a column to determine its data type. Without this argument, only the first 1,000 observations would be used to make this determination. This becomes important for a variable like `age`; though `age` is coded as numeric data for most of the observations, there are some in which `age` is coded as `"89 or older"`. Without the `guess_max` argument, you will get warnings when loading the data.

Note also that only the variables of interest will be loaded, not the entire dataset. This will make for faster computation and knitting as you work on the lab. 

### Exercises

#### Part I: Exploratory Data Analysis


```r
# See [Reorder factor levels by hand](https://forcats.tidyverse.org/reference/fct_relevel.html) for documentation about `fct_relevel`.
```

1. The variable `natmass` will be the response variable in the model, and you want to compare more opinionated views to the moderate position. Recode `natmass` so it is a factor variable with `"About right"` as the baseline.

2. Recode `polviews` so it is a factor variable type with levels that are in an order that is consistent with question on the survey. *Note how the categories are spelled in the data.*

Make a plot of the distribution of `polviews`. Which political view occurs most frequently in this data set?

3. Make a plot displaying the relationship between `natmass` and `polviews`. Use the plot to describe the relationship between a person's political views and their views on mass transportation spending. 

4. You want to use `age` as a quantitative variable in your model; however, it is currently a character data type because some observations are coded as `"89 or older"`. Recode `age` so that is a numeric variable. *Note: Before making the variable numeric, you will need to replace the values `"89 or older"` with a single value.*

#### Part II: Multinomial Logistic Regression Model

5. You plan to fit a model using `age`, `sex`, `sei10`, and `region` to understand variation in opinions about spending on mass transportation. Briefly explain why you should fit a multinomial logistic model. 

6. Fit the model described in the previous exercise and display the model output. Make any necessary adjustments to the variables so the intercept will have a meaningful interpretation. Be sure `About Right` is the baseline level. Be sure the full model displays in the knitted document.

7. Interpret the intercept associated with <u>odds</u> of having an opinion of "Too much" versus "About right".

8. Consider the relationship between age and one's opinion about spending on mass transportation.
    
    - Interpret the coefficient of age in terms of the <u>log odds</u> of having an opinion of "Too little" versus "About right".
    - Interpret the coefficient of age in terms of the <u>odds</u> of having an opinion of "Too little" versus "About right".

9. In general, what is the relationship between an person's age and their opinions on mass transportation spending?

Now that you have adjusted for some demographic factors, let's examine whether a person's political views has a significant impact on their attitude towards spending on mass transportation.

10. Conduct the appropriate test to determine if `polviews` is a significant predictor of attitude towards spending on mass transportation. State the null and alternative hypothesis, display all relevant code and output, and state your conclusion in the context of the problem.

Choose the appropriate model based on the results from the test. Use this model for the next part of the lab. 

#### Part III: Model Fit

11. Calculate the predicted probabilities and residuals from your model.

12. Plot the binned residuals versus the predicted probabilities for each category of `natmass.` *You will have three plots.*


```r
# You can change the size of your plots, so you can fit multiple plots on a single page. Include the arguments `fig.height = ` and `fig.width = ` in the header of the code chunk to change the plot size. 

# See [Using R Markdown](https://rstudio.github.io/dygraphs/r-markdown.html) for an example.
```

13. Use binned residual plots to examine the residuals versus each of the quantitative variables.

    - Create binned plots of the residuals for each category of `natmass` versus `age`. *You will have three plots.*
    - Create binned plots of the residuals for each category of `natmass` versus `sei10`. *You will have three plots.*

14. To examine the residuals versus each categorical predictor, you will look at the average residuals for each each category of the categorical variables.

    - For each level of `natmass`, calculate the average residuals across categories of `sex`.
    - For each category of `natmass`, calculate the average residuals across categories of `region`.
    - For each category of `natmass`, calculate the average residuals across categories of `polviews`.

15. Based on the analysis of the residuals in Exercises 12 - 14, is the model an appropriate fit for the data? Explain. 

*Regardless of your asssesment of the residuals, use your model for the remainder of the lab.*

#### Part IV: Using the Model

16. Use your model to describe the relationship between one's political views and their attitude towards spending on mass transportation. 

17. Use your model to predict the category of `natmass` for each observation in your dataset. Display a table of the actual versus the predicted `natmass`. What is the misclassification rate?

### Acknowledgements

The "Data" section is largely inspired by [datasciencebox.org](https://datasciencebox.org/).

***

## IN-CLASS: Sesame Street






The main objective of this analysis is to understand how encouragement affects the frequency that children watch *Sesame Street*. We will use the following variables: 

**Response:**

- <font class="vocab">`viewcat`</font>
    + 1: rarely watched show
    + 2: once or twice a week
      + 3: three to five times a week
      + 4: watched show on average more than five times a week


**Predictors:**

- <font class="vocab">`age`:</font> child's age in months
- <font class="vocab">`prenumb`: </font>score on numbers pretest (0 to 54)
- <font class="vocab">`prelet`: </font>score on letters pretest (0 to 58)
- <font class="vocab">`viewenc`:</font> 1: encouraged to watch, 2: not encouraged
- <font class="vocab">`site:`</font>
    + 1: three to five year old from disadvantaged inner city area
    + 2: four year old from advantaged suburban area
    + 3: from advantaged rural area
    + 4: from disadvantaged rural area
    + 5: from Spanish speaking home



```r
# read in dataset
sesame <- read_csv("data/sesame.csv")
```


```r
# mean-center relevant continuous variables, make categorical variables factors
sesame <- sesame %>% 
  mutate(viewcat = as.factor(viewcat), 
         site = as.factor(site), 
         prenumbCent = prenumb - mean(prenumb), 
         preletCent = prelet - mean(prelet), 
         ageCent = age - mean(age),
         viewenc = ifelse(viewenc == 1, "Encouraged", "Not Encouraged"))
```
<br>

### Questions

1. We will build a model to predict how often a child in this study watched *Sesame Street*. What type of model should we build? Why? 

2. Describe how you would conduct exploratory data analysis. What plots and/or summary statistics would you include? What information would you learn from the exploratory data analysis?


```r
model1 <- multinom(viewcat ~ site + viewenc + prenumbCent + preletCent + ageCent,
                   data = sesame)
kable(tidy(model1, conf.int=TRUE, exponentiate = FALSE),
      format = "markdown")
```
<br>

3. Interpret the intercept associated with the odds of `viewcat == 2` versus `viewcat == 1`. 

4. Interpret the effect of the numbers pretest score on the odds of viewership. 


5. The primary objective of the experiment was to understand the effect of encouragement `viewenc` on viewership. Does encouragement have a significant effect on viewership? If so, describe the effect. Otherwise, explain why not. 

6.  We want to test if there are any significant interactions with `viewenc` and the pretests. We create a model that includes the variables from `model1` along with `viewenc*preletCent` and `viewenc*prenumbCent`. 


```r
model2 <- multinom(viewcat ~ site + viewenc + prenumbCent + preletCent + ageCent + 
                     viewenc*preletCent + viewenc*prenumbCent,
                   data = sesame)
```

The results from the drop-in-deviance test are shown below. Is there evidence of a significant interaction effect? Explain. 


```r
anova(model1, model2, test = "Chisq")
```

7. How would you assess the appropriateness of the model flit? Describe the plots, tables, and/or calculations you would create to assess model fit. 

### References

Data from [http://www2.stat.duke.edu/~jerry/sta210/sesamelab.html](http://www2.stat.duke.edu/~jerry/sta210/sesamelab.html)


***
