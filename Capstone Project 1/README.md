#Capstone 1: Diabetes and other health indicators

Context<br>
The data was collected and made available by National Institute of Diabetes and Digestive and Kidney Diseases” as part of the Pima Indians Diabetes Database. 
In particular, all patients here belong to the Pima Indian heritage (subgroup of Native Americans) and are females of ages 21 and above. 
Many of them are diabetic so NIH conducted a research.

Source: https://www.kaggle.com/datasets/uciml/pima-indians-diabetes-database

The dataset contains 768 datapoints with 9 columns.
<br>
<br>
Variable Description<br>
Pregnancies: Number of times pregnant<br>
Glucose: Plasma glucose concentration a 2 hours in an oral glucose tolerance test<br>
BloodPressure: Diastolic blood pressure (mm Hg)<br>
SkinThickness: Triceps skin fold thickness (mm)<br>
Insulin: 2-Hour serum insulin (mu U/ml)<br>
BMI: Body mass index (weight in kg/(height in m)^2)<br>
DiabetesPedigreeFunction: Diabetes pedigree function<br>
Age: Age (years)<br>
Outcome: Class variable (0 or 1)<br> 

Data Cleaning<br>
There is a lot of missing/null values so we cannot simply drop those observations. 
Pregnancies have a real possibility of having 0 value so I replaced the null values with 0.
For the rest of the columns (Glucose, Blood Pressure, BMI and Insulin and Skin Thickness), missing values are replaced with the median values. 

This dashboard provides an overview of the population that is affected by diabetes and other health indicators. 
It also shows % of patient exceeding the healthy range of each of the health indicators. 

Insights<br>
Overall, there is an alarming amount of 86% patients with high BMI exceeding the healthy range and also 78% of the patients exceeding the normal skin thickness of 23mm.<br>
Glucose has a strongest correlation with diabetes, followed by BMI. Both indicators have a moderate positive correlation with diabetes.<br>
High SkinThickness means higher BMI and a high BMI means a higher chance of Diabetes. There are more diabetic patients with high BMI and high skin thickness level.<br>
High insulin level means higher glucose level and that means there is a higher chance of being diabetic.<br>
Overall female Pima Indians population was at risk of having higher BMI and TSF numbers followed by high Glucose, BP, and Insulin levels.<br>
Younger population (patients in age group 20–30 years) is more at risk of diabetes and poor health in general.<br>
The body structure (BMI and TSF) and metabolism (Plasma Glucose and Serum Insulin) are significant indicators of diabetes and population health.<br>
Among the 34.9% of diabetic patients, most had high BMI, TSF, and Glucose numbers.

