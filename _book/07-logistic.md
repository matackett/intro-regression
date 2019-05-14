# Logistic Regression {#logistic}



## Logistic Regression



Over the past ten years, recommendation systems have become increasingly popular as more companies strive to offer customized user experiences. Amazon recommends products you may like based on your browse and purchase history, Netflix recommends movies and TV shows based on your viewing history, and music platforms like Spotify recommend songs you may like based on your listening history. While these recommendation systems are built using a variety of algorithms, they are all trying to achieve the same goal: use the characteristics of the products/movies/music a user is known to like to figure out the products/movies/music the user may like but hasn't discovered yet. 


```r
# See ["How Does Spotify Know You So Well?"](https://medium.com/s/story/spotifys-discover-weekly-how-machine-learning-finds-your-new-music-19a41ab76efe) for more information about Spotify's recommendation algorithms.
```

In today's lab, we will focus on using the characteristics of songs a user previously played to determine whether or not a user will like a new song. We will use logistic regression to build a model that predicts the probability a user likes a song using the relevant characteristics of that song.

### Packages

You will need the following packages for today's lab: 


```r
library(tidyverse)
library(broom)
## Fill in other packages as needed
```

### Data

The data in this lab is from the [Spotify Song Attributes](https://www.kaggle.com/geomack/spotifyclassification) data set in Kaggle. This data set contains song characteristics of 2017 songs played by a single user and whether or not he liked the song. Since this dataset contains the song preferences of a single user, the scope of the analysis is limited to this particular user.

You will use data `spotify.csv` to build the logistic regression model and test the performance of the model using the songs in `test_songs.csv`. 
Click [**here**](https://www2.stat.duke.edu/courses/Spring19/sta210.001/labs/data/spotify.csv) to download the dataset  `spotify.csv`, and click [**here**](https://www2.stat.duke.edu/courses/Spring19/sta210.001/labs/data/test_songs.csv) to download the dataset `test_songs.csv`. Upload both files to the to the `data` folder in your `lab-07` project. 

The  [Spotify documentation page](https://developer.spotify.com/documentation/web-api/reference/tracks/get-audio-features/) contains a description of the variables included in this dataset.

### Exercises

#### Exploratory Data Analysis
    
1. Read through the [Spotify documentation page](https://developer.spotify.com/documentation/web-api/reference/tracks/get-audio-features/) to learn more about the variables in the dataset. The response variable for this analysis is `like`, such that 1 indicates that the user likes the song and 0 otherwise. The remaining will be considered as predictor variables in the model.

```r
# Part of the code to make `x` a factor. 

# mutate(x = factor(x))
```

    - Which potential predictor variables are categorical? You only need to include the variables that are in the dataset.
    - Recode the each of the categorical predictors so they are a `factor` variable type.

2. Choose a quantitative predictor variable. Make the appropriate plot of the response versus this predictor variable. Describe the relationship between the two variables. 

3. Choose a categorical predictor variable. Make the appropriate plot of the response versus this predictor variable. Describe the relationship between the two variables.

4. Let's consider a potential interaction effect between the variables you choose in Exercises 2 and 3. Make the appropriate plots to examine the potential interaction effect. Do these plots suggest there is a significant interaction effect? Briefly explain.

*In practice, you should do exploratory data analysis for all potential explanatory variables. We did an abbreviated exploratory data analysis to make the assignment more manageable.*

#### Part II: Logistic Regression Model

5. Fit the full model and display the model output. The main objective for the model is to predict whether the user will like a song. Should we use this model for this objective? Briefly explain.  

6. Use the `step` function to perform backward selection. Display the output for the selected model.

7. Briefly describe the criteria used by `step` to select the final model. 

For the remainder of this lab, you will use the model chosen by model selection . In practice; however, you would not just stop with the results from the automated model selection procedure and would examine the model further to see if there are any significant interactions, higher-order terms, or if it could even be simplified. 

8. Consider the variable `duration_ms`. 
    
    - Interpret the coefficient of `duration_ms` and its 95% confidence interval in terms of the odds of the user liking a song.
    - Suppose instead of `duration_ms`, we use the variable `duration_s`, the duration of a song in seconds. What would be the effect of `duration_s` on the odds of the user liking a song? Include the updated coefficient and corresponding 95% confidence interval for `duration_s`. *Assume all other variables in the model are unchanged.*
    
9. Interpret `mode` and its 95% confidence interval in terms of the odds of the user liking a song. 

    - Based on this model, is there evidence of a significant difference in the user's preference between songs in a major key versus those in a minor key? 
    
#### Part III: Model Assessment

In the next few questions, we will do an abbreviated analysis of the residuals. 

10. Create a binned plot of the residuals versus the predicted probabilities. *You will first need to use the `augment` function with the options `type.predict = "response"` and `type.residuals = "response"` to get the predicted probabilities and corresponding residuals.*

11. Choose a quantitative predictor in the final model. Make the appropriate table or plot to examine the residuals versus this predictor variable.

12. Choose a categorical predictor in the final model. Make the appropriate table or plot to examine the residuals versus this predictor variable.

*In practice, you should examine plots of residuals versus <u>every</u> predictor variable to make a complete assessment of the model fit. For the sake of time on the lab, you will use these three plots to help make the assessment in Exercise 14.*

13. Plot the ROC curve and find the area under the curve. 

14. Based on the residual plots and the ROC curve, is this logistic model a good fit for the data? Briefly explain.

#### Part IV: Prediction

15. You are part of the data science team at Spotify, and your model will be used to make song recommendations to users. The goal is to recommend songs the user has a high probability of liking. 

As a group, choose a threshold value to distinguish between songs the user will like and those the user won't like. What is your threshold value? Use the ROC curve to help justify your choice. 

16. Now let's put your model and decision threshold to the test! Use your model to calculate the predicted probability that the user will like the following two songs:
 
    - "Sign of the Times" by Harry Styles
    - "Hotline Bling" by Drake
    
The data for the songs can be found in *test_songs.csv*. 

17. Using your decision threshold from Question 15, would you recommend "Sign of the Times" to this user? Would your recommend "Hotline Bling" to this user? Briefly explain your decision.

18. The user likes "Hotline Bling" but doesn't like "Sign of the Times". How good were your recommendations based on these two songs?

      - If they were good recommendations, explain how the model and threshold helped you distinguish between songs the user would like and those he wouldn't. 
      - If they were not good recommendations, explain the limitations in your model and/or threshold.

## Logistic Regression



The goal of this exercise is to walk through a logistic regression analysis. It will give you a basic idea of the analysis steps and thought-process; however, due to class time constraints, this analysis is not exhaustive.


```r
library(tidyverse)
library(broom)
library(rms)
## add any other packages as needed 
```

This data is from an ongoing cardiovascular study on residents of the town of Framingham, Massachusetts. The goal is to predict whether a patient has a 10-year risk of future coronary heart disease. The dataset includes the following: 

- `male`: 0 = Female; 1 = Male
- `age`: Age at exam time.
- `education`: 1 = Some High School; 2 = High School or GED; 3 = Some College or Vocational School; 4 = College
- `currentSmoker`: 0 = nonsmoker; 1 = smoker
- `cigsPerDay`: number of cigarettes smoked per day (estimated average)
- `BPMeds`: 0 = Not on Blood Pressure medications; 1 = Is on Blood Pressure medications
- `prevalentStroke`
- `prevalentHyp`
- `diabetes`: 0 = No; 1 = Yes
- `totChol`: total cholesterol (mg/dL)
- `sysBP`: systolic blood pressure (mmHg)
- `diaBP`: diastolic blood pressure (mmHg)
- `BMI`: BodyMass Index calculated as: Weight (kg) / Height(meter-squared)
- `heartRate` Beats/Min (Ventricular)
- `glucose`: total glucose mg/dL
- `TenYearCHD`: 0 = Patient doesn't have 10-year risk of future coronary heart disease; 1 = Patient has 10-year risk of future coronary heart disease;



```r
fram_data <- read_csv("data/framingham.csv") %>%
  drop_na() %>%
  mutate(education = case_when(
    education == 1 ~ "Some HS", 
    education == 2 ~ "HS or GED", 
    education == 3 ~ "Some College", 
    education == 4 ~ "College"
  ),
  currentSmoker = if_else(currentSmoker == 0, "nonsmoker", "smoker"),
  diabetes = if_else(diabetes == 0,"No", "Yes"),
  male = factor(male)
  )
```

- Fit a full model (main effects only) with `TenYearCHD` as the response. Display the model output. 

- Based on the goal of the analysis, should the full model be the final model? Why or why not? 

- Use the `step` function to conduct backward model selection. What is selection criteria used by the `step` function? 
    - Display the final model.

- There is reason to believe that the factors related to coronary heart disease may have different effects for men and women. We would like to include this information in the model. Use the drop-in-deviance test to test at least three interactions with `male`. 
    - Which interactions did you choose? Why?
    - Include the output from the tests. 
    
- Use the results from model selection and the drop-in-deviance test to select a final model. Display the model below. 

- Plot and analyze the binned residuals for the final model. Include all appropriate plots. What is your assessment on the model fit based on these plots? 

- Plot and analyze the ROC curve. Based on the ROC curve, does the model fit the data well? 

- A doctor plans to use the results from your model to help select patients for a new heart disease prevention program. She asks you which threshold would be best to select patients for this program. What threshold would you recommend to the doctor? Why?
    

### References

- Data obtained from [https://www.kaggle.com/neisha/heart-disease-prediction-using-logistic-regression/data](https://www.kaggle.com/neisha/heart-disease-prediction-using-logistic-regression/data)