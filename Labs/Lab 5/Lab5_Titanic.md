# Lab 5 Titanic


## 

# Titanic Data and Notes

| PassengerId | Survived | Pclass | Name | Sex | Age | SibSp | Parch | Ticket | Fare | Cabin | Embarked |
|---:|---:|---:|:---|:---|---:|---:|---:|:---|---:|:---|:---|
| 1 | 0 | 3 | Braund, Mr. Owen Harris | male | 22 | 1 | 0 | A/5 21171 | 7.2500 | NA | S |
| 2 | 1 | 1 | Cumings, Mrs. John Bradley (Florence Briggs Thayer) | female | 38 | 1 | 0 | PC 17599 | 71.2833 | C85 | C |
| 3 | 1 | 3 | Heikkinen, Miss. Laina | female | 26 | 0 | 0 | STON/O2. 3101282 | 7.9250 | NA | S |
| 4 | 1 | 1 | Futrelle, Mrs. Jacques Heath (Lily May Peel) | female | 35 | 1 | 0 | 113803 | 53.1000 | C123 | S |
| 5 | 0 | 3 | Allen, Mr. William Henry | male | 35 | 0 | 0 | 373450 | 8.0500 | NA | S |

| PassengerId | Survived | Pclass | Name | Sex | Age | SibSp | Parch | Ticket | Fare | Cabin | Embarked |
|---:|---:|---:|:---|:---|---:|---:|---:|:---|---:|:---|:---|
| 887 | 0 | 2 | Montvila, Rev. Juozas | male | 27 | 0 | 0 | 211536 | 13.00 | NA | S |
| 888 | 1 | 1 | Graham, Miss. Margaret Edith | female | 19 | 0 | 0 | 112053 | 30.00 | B42 | S |
| 889 | 0 | 3 | Johnston, Miss. Catherine Helen “Carrie” | female | NA | 1 | 2 | W./C. 6607 | 23.45 | NA | S |
| 890 | 1 | 1 | Behr, Mr. Karl Howell | male | 26 | 0 | 0 | 111369 | 30.00 | C148 | C |
| 891 | 0 | 3 | Dooley, Mr. Patrick | male | 32 | 0 | 0 | 370376 | 7.75 | NA | Q |

    Rows: 12 Columns: 3
    ── Column specification ────────────────────────────────────────────────────────
    Delimiter: ","
    chr (3): Variable, Definition, Key

    ℹ Use `spec()` to retrieve the full column specification for this data.
    ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

| Variable | Definition | Key |
|:---|:---|:---|
| PassengerId | Passenger ID | NA |
| Survival | Survival | 0 = No, 1 = Yes |
| Pclass | Ticket class | 1 = 1st, 2 = 2nd, 3 = 3rd |
| Name | Pasenger name | NA |
| Sex | Sex | NA |
| Age | Age in years | NA |
| Sibsp | \# of siblings / spouses aboard the Titanic | NA |
| Parch | \# of parents / children aboard the Titanic | NA |
| Ticket | Ticket number | NA |
| Fare | Passenger fare | NA |
| Cabin | Cabin number | NA |
| Embarked | Port of Embarkation | C = Cherbourg, Q = Queenstown, S = Southampton |

#### **Question 1: According to Wikipedia, there was an estimated 2,224 passengers and crew onboard the Titanic when it sank. How many of them do we have information for in this dataset? Of the people we have data for, how many of them survived and how many did not? What is the overall survival rate?**

| Total_Passenger | Survivors | Deaths | Survival_Rate | Death_Rate |
|----------------:|----------:|-------:|--------------:|-----------:|
|             891 |       342 |    549 |      38.38384 |   61.61616 |

#### **Question 2. How many passengers on the Titanic were males and how many were females? What do you find when you break it down by ticket class?**

| Sex    |   n |
|:-------|----:|
| female | 314 |
| male   | 577 |

| Sex    | Pclass |   n |
|:-------|-------:|----:|
| female |      1 |  94 |
| female |      2 |  76 |
| female |      3 | 144 |
| male   |      1 | 122 |
| male   |      2 | 108 |
| male   |      3 | 347 |

![](Lab5_Titanic_files/figure-commonmark/unnamed-chunk-5-1.png)

#### **Question 3. How many passengers of each sex survived and how many of them did not? What is the survival rate for passengers of each sex?**

| Sex    | Survived |   n | percentage |
|:-------|:---------|----:|-----------:|
| female | no       |  81 |      25.80 |
| female | yes      | 233 |      74.20 |
| male   | no       | 468 |      81.11 |
| male   | yes      | 109 |      18.89 |

#### **Question 4. For how many passengers do we have age information (including estimated age)? For how many is the age information missing? What is the age distribution for passengers whose age information is available?**

| age_info  |   n |
|:----------|----:|
| available | 714 |
| missing   | 177 |

![](Lab5_Titanic_files/figure-commonmark/unnamed-chunk-7-1.png)

      PassengerId       Survived          Pclass          Name          
     Min.   :  1.0   Min.   :0.0000   Min.   :1.000   Length:714        
     1st Qu.:222.2   1st Qu.:0.0000   1st Qu.:1.000   Class :character  
     Median :445.0   Median :0.0000   Median :2.000   Mode  :character  
     Mean   :448.6   Mean   :0.4062   Mean   :2.237                     
     3rd Qu.:677.8   3rd Qu.:1.0000   3rd Qu.:3.000                     
     Max.   :891.0   Max.   :1.0000   Max.   :3.000                     
         Sex                 Age            SibSp            Parch       
     Length:714         Min.   : 0.42   Min.   :0.0000   Min.   :0.0000  
     Class :character   1st Qu.:20.12   1st Qu.:0.0000   1st Qu.:0.0000  
     Mode  :character   Median :28.00   Median :0.0000   Median :0.0000  
                        Mean   :29.70   Mean   :0.5126   Mean   :0.4314  
                        3rd Qu.:38.00   3rd Qu.:1.0000   3rd Qu.:1.0000  
                        Max.   :80.00   Max.   :5.0000   Max.   :6.0000  
        Ticket               Fare           Cabin             Embarked        
     Length:714         Min.   :  0.00   Length:714         Length:714        
     Class :character   1st Qu.:  8.05   Class :character   Class :character  
     Mode  :character   Median : 15.74   Mode  :character   Mode  :character  
                        Mean   : 34.69                                        
                        3rd Qu.: 33.38                                        
                        Max.   :512.33                                        

    `stat_bin()` using `bins = 30`. Pick better value `binwidth`.

![](Lab5_Titanic_files/figure-commonmark/unnamed-chunk-7-2.png)

#### **Question 5. Show the age distribution per ticket class, per sex. What do you find?**

![](Lab5_Titanic_files/figure-commonmark/unnamed-chunk-8-1.png)

#### **Question 6. How do the sex, ticket class, and age of a passenger affect their chance of survival? Try to use a single plot to answer this question.**

![](Lab5_Titanic_files/figure-commonmark/unnamed-chunk-9-1.png)

#### **Question 7. Show the distribution of the number of family members (including siblings, spouses, parents, and children) that each passenger was accompanied by. Were most passengers travelling solo or with family?**

![](Lab5_Titanic_files/figure-commonmark/unnamed-chunk-10-1.png)

![](Lab5_Titanic_files/figure-commonmark/unnamed-chunk-10-2.png)

#### **Question 8. Which ticket class did most of the largest families get? And which ticket class has the lowest proportion of female passengers who travelled solo out of all the female passengers in that class?**

![](Lab5_Titanic_files/figure-commonmark/unnamed-chunk-11-1.png)

![](Lab5_Titanic_files/figure-commonmark/unnamed-chunk-11-2.png)

#### **Question 9. In this dataset, the Fare variable does not represent the fare per person. Instead, each ticket number has a corresponding fare, and some passengers share one single ticket number. Therefore, the Fare variable is the total fare for a group of passengers sharing the same ticket number. Knowing this, calculate the average fare per person. You don’t need to show a table or a figure for this question, just show the code for the calculation.**

#### **Question 10. What is the distribution of the per-ticket fare for each ticket class?**
