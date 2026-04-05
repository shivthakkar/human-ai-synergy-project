* Encoding: UTF-8.

DATASET ACTIVATE DataSet1.

**Demographics***

FREQUENCIES VARIABLES=Age Sex Education Female CollegeDegree EducationRecode4Level
  /STATISTICS=SKEWNESS SESKEW KURTOSIS SEKURT
  /BARCHART PERCENT
  /ORDER=ANALYSIS.


***Nominal Study Variables****
    
FREQUENCIES VARIABLES=Complete_Again_Pos Complete_Again_Neg Reasons_why_not_1 Reasons_why_not_2 
    Reasons_why_not_3 Reasons_why_not_4 Reasons_why_not_4_TEXT Reasons_Why_1 Reasons_Why_2 
    Reasons_Why_4 Reasons_Why_8 Reasons_Why_9 Reasons_Why_10 Reasons_Why_10_TEXT Use_of_ChatGPT Matches 
    Pistols Milk Binoculars Compass Silk Heating LifeRaft Multitool Flares Food Rope StellarMap 
    FirstAidKit FMReceiver CompleteAgain AI_Recommendations
  /HISTOGRAM NORMAL
  /ORDER=ANALYSIS.


SORT CASES  BY AI_Recommendations.
SPLIT FILE SEPARATE BY AI_Recommendations.

FREQUENCIES VARIABLES=Reasons_why_not_1 Reasons_why_not_2 Reasons_why_not_3 Reasons_why_not_4 
    Reasons_why_not_4_TEXT Reasons_Why_1 Reasons_Why_2 Reasons_Why_4 Reasons_Why_8 Reasons_Why_9 
    Reasons_Why_10 Reasons_Why_10_TEXT Use_of_ChatGPT CompleteAgain MatchesP PistolsP MilkP BinocularsP 
    CompassP SilkP HeatingP LifeRaftP MultitoolP FlaresP FoodP RopeP StellarMapP FirstAidKitP 
    FMReceiverP MatchesN PistolsN MilkN BinocularsN CompassN SilkN HeatingN LifeRaftN MultitoolN 
    FlaresN FoodN RopeN StellarMapN FirstAidKitN FMReceiverN
  /HISTOGRAM NORMAL
  /ORDER=ANALYSIS.

SPLIT FILE OFF.


SORT CASES  BY AI_Recommendations.
SPLIT FILE LAYERED BY AI_Recommendations.
USE ALL.
COMPUTE filter_$=(CompleteAgain=1).
VARIABLE LABELS filter_$ 'CompleteAgain=1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

FREQUENCIES VARIABLES=Reasons_Why_1 Reasons_Why_2 Reasons_Why_4 Reasons_Why_8 Reasons_Why_9 
    Reasons_Why_10 Reasons_Why_10_TEXT Use_of_ChatGPT
  /HISTOGRAM NORMAL
  /ORDER=ANALYSIS.

USE ALL.
COMPUTE filter_$=(CompleteAgain=0).
VARIABLE LABELS filter_$ 'CompleteAgain=0 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.


FREQUENCIES VARIABLES=Reasons_why_not_1 Reasons_why_not_2 Reasons_why_not_3 Reasons_why_not_4 
    Reasons_why_not_4_TEXT
  /HISTOGRAM NORMAL
  /ORDER=ANALYSIS.

FILTER OFF.
USE ALL.
EXECUTE.
SPLIT FILE OFF.

****Ordinal/Scale Variable Descriptives****
    
FREQUENCIES VARIABLES=AI_use_experience Motivation AITrust PerceivedExpertise LunarScorePre 
    LunarScoreFinal
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN MEDIAN MODE SKEWNESS SESKEW KURTOSIS SEKURT
  /HISTOGRAM NORMAL
  /ORDER=ANALYSIS.

SORT CASES  BY AI_Recommendations CompleteAgain.
SPLIT FILE LAYERED BY AI_Recommendations CompleteAgain.

FREQUENCIES VARIABLES=LunarScorePre LunarScoreFinal
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN MEDIAN MODE SKEWNESS SESKEW KURTOSIS SEKURT
  /HISTOGRAM NORMAL
  /ORDER=ANALYSIS.

SPLIT FILE OFF.


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
  /VARIABLES=AITrust PerceivedExpertise LunarScorePre LunarScoreFinal CompleteAgain 
    AI_Recommendations
  /PRINT=TWOTAIL NOSIG FULL
  /MISSING=PAIRWISE.


SORT CASES  BY AI_Recommendations.
SPLIT FILE LAYERED BY AI_Recommendations.

CORRELATIONS
  /VARIABLES=AITrust PerceivedExpertise LunarScorePre LunarScoreFinal CompleteAgain
  /PRINT=TWOTAIL NOSIG FULL
  /MISSING=PAIRWISE.

SPLIT FILE OFF.




DATASET ACTIVATE DataSet1.

























