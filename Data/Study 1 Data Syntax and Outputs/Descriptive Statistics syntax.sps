* Encoding: UTF-8.

DATASET ACTIVATE DataSet1.

**Demographics***

FREQUENCIES VARIABLES=Age Sex Education Female CollegeDegree EducationRecode4Level
  /STATISTICS=SKEWNESS SESKEW KURTOSIS SEKURT
  /BARCHART PERCENT
  /ORDER=ANALYSIS.


***Nominal Study Variables****
    
FREQUENCIES VARIABLES=Choose_Help Task_Completion_1 Task_Completion_2 Task_Completion_3 
    Task_Completion_4 Task_Completion_5 Task_Completion_6 Task_Completion_7 Task_Completion_8 
    Task_Completion_9 Task_Completion_10 Task_Completion_11 Task_Completion_12 Task_Completion_13 
    Task_Completion_14 Task_Completion_15 Reasons_why_not_1 Reasons_why_not_2 Reasons_why_not_3 
    Reasons_why_not_4 Reasons_why_not_5 Reasons_why_not_6 Reasons_why_not_7 Reasons_why_not_8 
    Reasons_why_not_9 Reasons_why_not_9_TEXT Reasons_Why_1 Reasons_Why_2 Reasons_Why_3 Reasons_Why_4 
    Reasons_Why_5 Reasons_Why_6 Reasons_Why_7 Reasons_Why_8 Reasons_Why_9 Reasons_Why_10 
    Reasons_Why_10_TEXT Use_of_ChatGPT AIInputUse InputSeekingndUse Condition
  /STATISTICS=SKEWNESS SESKEW KURTOSIS SEKURT
  /ORDER=ANALYSIS.

****Ordinal/Scale Variable Descriptives****
    
FREQUENCIES VARIABLES=AI_use_experience Human_Expert Motivation AITrust PerceivedExpertise 
    LunarScore
  /STATISTICS=STDDEV MEAN MEDIAN MODE SKEWNESS SESKEW KURTOSIS SEKURT
  /HISTOGRAM NORMAL
  /ORDER=ANALYSIS.


**** Reliability Estimates****

RELIABILITY
  /VARIABLES=AITrust1 AITrust2 AITrust3 AITrust4 AITrust5
  /SCALE('AI Trust') ALL
  /MODEL=ALPHA
  /STATISTICS=DESCRIPTIVE SCALE CORR
  /SUMMARY=TOTAL.
   
RELIABILITY
  /VARIABLES=Expertise1 Expertise2 Expertise3 Expertise4
  /SCALE('Perceived Expertise') ALL
  /MODEL=ALPHA
  /STATISTICS=DESCRIPTIVE SCALE CORR
  /SUMMARY=TOTAL.

****Correlations among Key Stdy Variables*****
    

CORRELATIONS
  /VARIABLES=Choose_Help AI_use_experience Motivation AIInputUse InputSeekingndUse AITrust 
    PerceivedExpertise LunarScore
  /PRINT=TWOTAIL NOSIG FULL
  /MISSING=PAIRWISE.

STATS CORRELATIONS VARIABLES=Choose_Help AI_use_experience Motivation AIInputUse InputSeekingndUse AITrust 
    PerceivedExpertise LunarScore
/OPTIONS CONFLEVEL=95 METHOD=FISHER
/MISSING EXCLUDE=YES PAIRWISE=YES.



