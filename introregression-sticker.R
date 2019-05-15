
library(hexSticker)
library(readr)
library(tidyverse)
library(tibble)
library(showtext)
library(nnet)
library(knitr)

bikeshare <- read_csv("https://raw.githubusercontent.com/matackett/data/master/capital-bikeshare.csv")  
bikeshare <- bikeshare %>%
  mutate(season = case_when(
    season==1 ~ "Winter",
    season==2 ~ "Spring",
    season==3 ~ "Summer",
    season==4 ~ "Fall"
  )) %>% 
  select(season,atemp,cnt) 

# fit multinomial logistic model 
# add predicted probabilities to bikeshare data
m <- multinom(season ~  atemp,data=bikeshare)
pred <- as.data.frame(predict.glm(m,type="response"))
bikeshare <- bind_cols(bikeshare,pred)


## Make Sticker

# k means clustering for plot p1

bike.cl <- kmeans(bikeshare[,2:3], 4, nstart = 20)
bikeshare <- 
  bikeshare %>% 
  mutate(cluster=as.factor(bike.cl$cluster))

alpha.level = 0.5

set.seed(1234)
p <- bikeshare %>%
  filter(atemp <= 0.75) %>%
  sample_n(100) %>%
  ggplot(aes(x=atemp,y=cnt)) +
  geom_point(alpha=alpha.level, aes(color = season)) +
  geom_smooth(method = "lm", se = FALSE, color = "#888B8D", size = 0.5) +
  theme_minimal() +
  theme(legend.position="none") +
  theme(axis.title=element_blank(),
        axis.text.x=element_blank(),
        axis.text.y=element_blank())
  

# add font to be used in sticker function
font_add_google("Open Sans", "open")


# create and save sticker
col = "#008EAA"
sticker(p, package="Intro Regression",p_color=col, p_family="open", 
        p_size= 4.75, s_x=1, s_y=0.75, s_width=1.3, s_height=1, h_fill = "#FFFFFF", 
        h_color=col, h_size =0.8,
        filename="img/introregression-sticker.png")
