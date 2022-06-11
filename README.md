# Team_suicide_squad

Technical Report: 

Extract:
Three files from kaggle are used in this ETL project. All files are .csv files downloaded from kaggle into the Resources folder used for this project. 

Two .csv files from the World Happiness Report dataset, one for the year 2015 and one for the year 2016. (.../Resources/2015.csv and ../Resources/2016.csv) (a/k/a “Happiness data)
One file from the “Suicide Rates Overview 1985 to 2016” (../Resources/master.csv) (a/k/a “Suicide data”)


Transforming:

The next step is to filter the Suicide dataset to the relevant years, 2015 and 2016, which are the years shared in both datasets. Using sqlalchemy, the Suicide data was filtered via query on [year] fo “2015 “ and “2016” to create two data frames for the years. 

To merge the datasets, the lowercase “country” column in the Suicide data frames needed to be renamed “Country” to match the capitalized “Country” column in the Happiness data set. 

In the course of investigating the data, we found that the number of countries contained in the suicide dataset for both years was vastly different: 62 countries in the 2015 set but just 10 in the 2016 set. As a result, we have elected to use only 2015 data for this analysis. 

The Happiness data contains 158 countries for the year 2015. 

The Suicide data shows the suicides per 100k people across 10-12 age-gender cohorts (e.g., 15-24 men, 15-24 women, 25-34 men, 25-34 women, 35-44 men, 35-44 women, etc.), while the Happiness data has only one record per country. Since the scope of our analysis is broad, we are aggregating the Suicide data in the following way:
In two new data frames, each per country:
Sum the [suicide_no] across all the age cohorts and genders 
Sum the [population] across all the age cohorts and genders

These data frames were then merged to a new data frame, “suicides_agg”, which contained the country name, sum of the population per country, and sum to the number of suicides per country. 

To compare the number of suicides between countries with vastly different populations, we created a new column that expresses the number of suicides per 100,000 people in the country (“avg_suicides”).

Next, we merged the Suicide data with the Happiness data to create a frame that contained all Happiness data and the aggregated Suicide data from the “suicide_agg” data frame. Once combined, we proceeded to load the data into Postgres. 


Loading:

We used sqlalchemy to load the data into Postgres, and encountered issues when initially loading. These ultimately were resolved by addressing how the columns were named: spacing versus underscores; capitalized versus all lower case. Once all columns followed the same naming conventions and all common columns across the table had the exact same names, the load into Postgres proceeded without errors. 


Initial Findings:

We created several sctatter plots to broadly examine possible correlations in the data set. Though preliminary, it appears that there is not a relationship between a country’s Happiness Score and the number of Suicides per 100,000 People. 

However, there does appear to be a somewhat positive correlation between the Economy - as measured by GDP per Capita - and the Suicides per 100,000 people. The Economy appears to have a strong, positive relationship with a country’s Happiness Score.
