# Analysis of Variance {#anova}


### COMP: Diamonds



### Introduction {-}

The goal of this assignment is to use Analysis of Variance (ANOVA) to compare means in multiple groups. Additionally, you will be introduced to new R functions used for [data wrangling](https://en.wikipedia.org/wiki/Data_wrangling) and summarizing data.

#### Packages {-}

We will use the following packages in today's assignment:



### Data {-}

In today's assignment, we will analyze the `diamonds` dataset from the ggplot2 package. Type `?diamonds` in the console for more information about the dataset including a data dictionary. This analysis will focus on the relationship between a diamond's carat weight and its color. Before starting the exercises, take a moment to read more about the diamond attributes on the Gemological Institute of America webpage: [https://www.gia.edu/diamond-quality-factor](https://www.gia.edu/diamond-quality-factor).


### Exercises {-}

The diamonds dataset contains the price and other characteristics for over 50,000 diamonds price from $326 to $18823. In this assignment, we will analyze the subset of diamonds that are priced $1200 or less. 

1. Create a dataframe called `diamonds_low` that is the subset of diamonds priced $1200 or less. How many observations are in `diamonds_low`? 

When using Analysis of Variance (ANOVA) to compare group means, it is ideal to have approximately the same number of observations in each group. Therefore, we will combine the worst two color groups, I and J, and create a new color category called "I/J". Since `color` is an ordinal (`<ord>`) variable, we need to use the `recode_factor` function in the dplyr package to create the new category. 

Use the `count` function before and after making the new color category to ensure the recoding worked as expected.








2. We begin by plotting the relationship between `color` and `carat`. Brainstorm ways to plot the relationship between the two variables, then make one of the plots. Be sure to include informative axes labels and an informative title.

*Note: [ggplot2 Cheat Sheet](https://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf) and [ggplot2 reference](https://ggplot2.tidyverse.org/reference/index.html) for plot ideas and help with code.*

3. Fill in the code below to calculate the mean and variance of `carat` at each level of `color`. 



Based on the plots and summary statistics, does there appear to be a relationship between carat weight the color of diamonds? In other words, does there appear to be a significant difference in the mean carat weight across colors?

4. When using ANOVA to compare means across groups, we make the following assumptions (note their similarity to the assumptions for regression): 

  - **Normality**: The distribution of $y$ is approximately normal within each category of $x$ - in the $k^{th}$ category, $y \sim (\mu_k, \sigma^2)$ . If the sample size is large, ANOVA is robust to some departures from Normality. 
  - **Independence**: All observations are independent from one another, i.e. one observation does not affect another.
  - **Constant Variance**: The distribution of $y$ within each category of $x$ has a common variance, $\sigma^2$. One way to assess if variances are sufficiently equal is to look at the ratio of the maximum group variance to the minimum group variance. If this ratio is less than 2, then we can conclude the variances are approximately equal. This isn't an exact threshold, but rather a commonly used guideline. *Note: There are formal tests for equal variance that are outside the scope of this class.*

Are the assumptions for ANOVA met? Comment on each assumption using the summary statistics and/or plots from previous exercises to support your conclusion. You may also calculate any additional summary statistics or make additional plots as needed.
  
*Regardless of the conclusions about the assumptions, we will proceed with the analysis in the remainder of this assignment as if the assumptions are met.*

5. Use the code below to calculate the ANOVA table. The `tidy` function from the broom package is used to put the ANOVA output in a dataframe, and with the `kable` function from the knitr package, you can display the results in an easy-to-read table.



6. Use the ANOVA table to calculate the total mean square, i.e. the sample variance of `carat`. Show your calculations. You can put the calculations in a code chunk to use R like a calculator. 

7. What is $\hat{\sigma}^2$, the estimated variance of `carat` within each level of `color`. 

8. We can use ANOVA to test if the true mean value of `carat` is equal for all levels of `color`, i.e. 

$$ H_0: \mu_1 = \mu_2 = \dots = \mu_6$$

State the alternative hypothesis is the context of the data. 

9. Based on the ANOVA table, what is your conclusion from the test of the hypotheses in the previous question? State the conclusion in the context of the data.

10. Use the code below to plot a 95% confidence interval for the mean carat weight at each level of color. Calculate the value of `sigma` by filling in the estimated variance from Exercise 7. 

The formula for the confidence interval for the mean of group $k$ is 

$$\bar{y}_k \pm t^* \frac{\hat{\sigma}}{\sqrt{n_k}}$$

*Note: The critical value $t^{*}$ is calculated using the *t* distribution with $n-K$ degrees of freedom.*

*Note: The standard error of the mean is calculated using $\hat{\sigma}$, the square root of the variance within each group calculated from the ANOVA table.*





11. For what color level is the mean carat weight the most different from all the others? 

12. Based on this analysis, describe the relationship between the color and the mean carat weight in diamonds that cost $1200 or less. *Refer to the diamond documentation to recall what the color scale means.*


*Knit then commit all remaining changes, write a commit message indiciating you’re finished, and push to GitHub. Before you finish, make sure all documents are updated on your GitHub repo.*

***
