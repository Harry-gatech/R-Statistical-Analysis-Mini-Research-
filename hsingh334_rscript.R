---
title: "Music as pain relief for Neonatal Infants during surgical procedure"
output: html_document
date: "04-12-2023"
authors: Hargobind Singh
---
  
```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```


```{r Import packages}

library(dplyr)
library(tidyr)
library(readr)
library(ggplot2)
library(readxl)


#The packages are being imported for the statistical tests on the dataset provided

```

```{r Load data}

Music_study_data_for_sharing <- read_excel("Music study - data for sharing.xlsx")
View(Music_study_data_for_sharing)

The dataset is being loaded from the imported dataset in R studio for the analysis purposes.


```
#Defining of research question and research hypothesis for the analysis being done. 

Question: Does exposure to music during neonatal surgical procedures reduce pain perceptions? 
  
Hypothesis: Infants exposed to music during neonatal surgical procedure have a 
lower pain perception comapred to infants that were not exposed to music.


```{r Selecting study group and NIPS 0 from data}

From the provided research question and hypothesis, the data is being fetched from the provided
data set.  

neonatal_analysis <- Music_study_data_for_sharing %>%
  select('Study Groups', 'NIPS 0') %>%
  drop_na()
summary(neonatal_analysis)


```


```{r Histogram Response Variable}
#visualizing the chosen response variable for outliers, variability etc

hist(neonatal_analysis$'NIPS 0')


```
```{r Visualization between the response variable and predictor variable}
#Visualization for the response variable and predictor variable to check the hypothesis

neonatal_analysis %>%
  ggplot(aes(x = `Study Groups`, y = `NIPS 0`, group = `Study Groups`)) +
  geom_boxplot() +
  theme_classic()

```

Music as Pain relief: The music as pain relief between the study groups. 
The music does look to reduce the pain based on the figure as the treatment 
group has a lower levels of pain distribution.

```
 

```
# Test assumptions

# Shapiro test is being employed to check for the normality distribution
# as it will determine what type of statistical test would be required for the same
#as Shapiro Wilk test helps to determine is the assumptions are reasonably met.


shapiro.test(subset(neonatal_analysis, `Study Groups` == "1")[['NIPS 0']])

shapiro.test(subset(neonatal_analysis, `Study Groups` == "0")[['NIPS 0']])



#As the data is not normal from the above test we are using fligner killen test for checking
#homogeneity of variance

fligner.test(neonatal_analysis$`NIPS 0` ~ neonatal_analysis$`Study Groups`)




```
For 'study groups 1': 
  
  Results: 
  # Shapiro-Wilk normality test
  
  #data:  subset(neonatal_analysis, `Study Groups` == "1")[["NIPS 0"]]
  #W = 0.82937, p-value = 2.199e-06
  
  #the P value is coming out to be quite low ( < 0.05)from the Shapiro wilk test therefore, 
  #we reject null hypothesis. 
  
  Conclusion: The Data does not follow normal distribution. 

#Shapiro wilk test for Study groups 0: 

Results: 
  
  #Shapiro-Wilk normality test
  
  #data:  subset(neonatal_analysis, `Study Groups` == "0")[["NIPS 0"]]
  #W = 0.6224, p-value = 1.213e-09
  
  #The p Value is coming out to be quite low (< 0.05), therefore, we reject the null hypothesis. 
  
  Conclusion: The data does not follow normal distribution.

Results: 
Fligner-Killeen test of homogeneity of variances

data:  neonatal_analysis$`NIPS 0` by neonatal_analysis$`Study Groups`
Fligner-Killeen:med chi-squared = 11.923, df = 1, p-value = 0.0005545

As the p value < 0.05 we reject null hypothesis of homogeneous of variances
Therefore, the variance of NIPS 0 pain scores differs significantly between music therapy group
and the control group. 



```
#Based on the results from the test, it is quite evident that the data is not normal, therefore
#we are going to follow non-parametric statistical test for the same. 
#I am using Wilcoxon Rank Sum test. 

# Wilcoxon Rank Sum test



wilcox.test(neonatal_analysis$`NIPS 0` ~ neonatal_analysis$`Study Groups`,
            paired = FALSE)

```

Results: 

Wilcoxon rank sum test with continuity correction

data:  neonatal_analysis$`NIPS 0` by neonatal_analysis$`Study Groups`
W = 1732, p-value = 0.0003337
alternative hypothesis: true location shift is not equal to 0

There is a significant difference between the two groups (Study Groups[0] Study Groups[1]).
to earlier Visualization, the location shift shows that the music therapy group pain scores
were lowered as compared to other non music therapy groups.
Based on the results, we can conclude that the exposing infants to music does help in 
significant reduction in pain scores compared to groups that were not exposed to music.
This Aligns with our original hypothesis: Infants exposed to music during neonatal surgical procedure have a 
lower pain perception compared to infants that were not exposed to music.












