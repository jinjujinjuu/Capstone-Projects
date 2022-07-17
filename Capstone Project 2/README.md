Capstone Project 2: Analysis on Olist 

Source: https://www.kaggle.com/datasets/olistbr/marketing-funnel-olist

Context
Olist is the largest ecommerce department store in Brazil. 
Olist connects small businesses from all over Brazil to channels without hassle and it is very easy to get onboard. 
Those merchants are able to sell their products through the Olist Store and ship them directly to the customers using Olist logistics partners which is hasslefree for the merchants. 

Problem Statement
-	Which marketing channel (origin) generate the most leads?
-	What is the volume of leads generated monthly?
-	Conversation rate % of Marketing Qualified Leads to Seller?
-	Duration took for SR to convince Leads to join Olist?
-	Overall Best performing SR and worst performing SR? Top performing SR in closing different Leads Behaviour Profile (Cat, Eagle, Wolf, Shark)? 

Dataset
- Qualified leads which contains 8000 rows and 3 columns (lead id, first contact date, origin of the lead) 
- Closed deals table which consists of 842 rows with 9 columns (lead id, seller id, sales development id, sales representative id, won date, buniess segment, lead type. Lead behaviour profile, business type)

Flow of sellers joining Olist through a marketing and sales funnel: 
1.	Firstly, the qualified lead will first sign-up at a landing page via a channel.
2.	Then, the lead will get contacted by a Sales development Representative (SDR) to confirm some information, schedule a consultancy with a Sale representative
3.	The SR may close the deal or lose the deal 
4.	Lead becomes a seller and starts building his catalog on Olist to sell his products.

Primary key is mql_id (lead_id) in the qualified leads table. 
Foreign key is the mql_id  in closed deals table with reference to the primary key in the qualified leads table.

Data Preparation<br>
I dropped a few redundant columns in both tables as more than 90% of the data is empty. 
I also changed the data type of won date in closed deals table to show only the date, dropping the time. 
For origin column in qualified leads table, I replaced ‘other’, ‘unknown’ and null value and group it with other publicities. 
For the lead behaviour profile in closed deal table, I categorized those with more than 1 behaviour profile into 'mixed' group. 
There is also wrong value found in the data. For one of the leads, the won date (sign up date) is earlier than the first contact date which is impossible. 
I replaced the first contact date to the same date as won date.

Looking at the marketing channel effectiveness, the origin that generates the most number of leads is organic search, Paid search is the second biggest contributor to lead generation after 'organic search'. 
Then, followed by other publicities and social.<br>

Next query is to find out the monthly number of leads generated per month. 
The monthly no of leads generated is 2017 very little. 
In the beginning of 2018, there’s a surge of leads expressing interest to join Olist. 
With more leads, there is a higher chance of more sellers signing up.<br>

Third query returned the % of leads who signed up as sellers by year and month. 
Left join is used to join qualified leads table (on the left) and closed deal table (on the right) so that we can calculate the conversion rate per month. 
The conversion rate is not very ideal, most of the months have rates with less than 10%. 
The rates started picking up since August 2018 which is a good sign.<br>

Next query returns the duration took for the leads to sign up as sellers. 
I created a temporary table to calculate running total seller by year and also the total seller per year and calculate the running % per year with another query. 
For 2017, it took close to a year to close 80% of the sellers which is too long. 
But in 2018, we see an huge improvement, 80% of the sellers were closed within 2 months.<br>

Looking at the lead behaviour profile of the closed leads, almost half of them are cat, followed by eagle and wolf. <br>

Next query gives a ranking to the sales representative and return top 5 performing sales representative and also bottom 5 worst performing sales representative. 
Sale representative 4ef is the best overall performing and sale representative b90, 0a0 and 6aa are the worst overall performing with the same rank 20.<br>

The last query returns the top performing Sales representative for the different behavior profile. 
4ef who is the best overall performing sales representative, coming in 1st to close cat, eagle and also wolf except shark.

Insight<br>
- Organic search is the first biggest contribution in leads and Paid search is the second biggest contributor to lead generation after 'organic search', followed by 'social' and other publicities. 
- Almost half of the closed deals are cat (cooperation-focused), followed by eagle (relationship-focused), wolf (accuracy-focused) and shark (result-focused) with the lowest conversion rate of 3%.
- Sales performance could be improved by matching Sales Representatives with leads based on behaviour profile and conducting a review of Sales Representatives’ skill and equip them with the right sales strategies.
