* Encoding: UTF-8.

DATASET ACTIVATE DataSet1.

****Task Item Scoring Recodes and Total Task Score****


RECODE Matches Pistols Milk Binoculars Compass (1=0) (-99=0).
EXECUTE.

RECODE Silk Heating LifeRaft Multitool Flares (1=1) (-99=0).
EXECUTE.

RECODE Food Rope StellarMap FirstAidKit FMReceiver (1=2) (-99=0).
EXECUTE.

COMPUTE LunarScore=Sum(Matches,Food,Rope,Silk,Heating,Pistols,Milk,Binoculars,StellarMap,LifeRaft,
    Compass,Multitool,Flares,FirstAidKit,FMReceiver).
EXECUTE.

***Recode of Sex****

RECODE Sex (2=1) (1=0) (3=0) INTO Female.
EXECUTE.

***Education Recode****

RECODE Education (1 thru 3=0) (4 thru 7=1) INTO CollegeDegree.
EXECUTE.

RECODE Education (4=2) (5=3) (1 thru 3=1) (6 thru 7=4) INTO EducationRecode4Level.
EXECUTE.

***AI Trust Scoring****


RELIABILITY
  /VARIABLES=AITrust1 AITrust2 AITrust3 AITrust4 AITrust5
  /SCALE('AI Trust') ALL
  /MODEL=ALPHA
  /STATISTICS=DESCRIPTIVE SCALE CORR
  /SUMMARY=TOTAL.

COMPUTE AITrust=Mean(AITrust1,AITrust2,AITrust3,AITrust4,AITrust5).
EXECUTE.

****Perceived Expertise Scoring*****
    
RELIABILITY
  /VARIABLES=Expertise1 Expertise2 Expertise3 Expertise4
  /SCALE('Perceived Expertise') ALL
  /MODEL=ALPHA
  /STATISTICS=DESCRIPTIVE SCALE CORR
  /SUMMARY=TOTAL.

COMPUTE PerceivedExpertise=Mean(Expertise1,Expertise2,Expertise3,Expertise4).
EXECUTE.

RECODE Expertise4 (5=1) (4=2) (3=3) (2=4) (1=5) INTO Expertise4R.
EXECUTE.

***Use of ChatGPT Input****
    

RECODE Use_of_ChatGPT (3 thru 4=1) (1 thru 2=2) INTO AIInputUse.
EXECUTE.

RECODE Use_of_ChatGPT (4=1) (1 thru 3=2) INTO AIInputUse1.
EXECUTE.

* Identify Unusual Cases.

***Anomaly Detection - The others are Qualtrics Scores and Average Deviation**** 

DETECTANOMALY
  /VARIABLES CATEGORICAL=LunarScore SCALE=AITrust1 AITrust2 AITrust3 AITrust4 AITrust5 Expertise1 
    Expertise2 Expertise3 Expertise4 Condition AITrust PerceivedExpertise 
  /PRINT ANOMALYLIST 
  /SAVE ANOMALY(AnomalyIndex) 
  /HANDLEMISSING APPLY=NO
  /CRITERIA PCTANOMALOUSCASES=5 ANOMALYCUTPOINT=2 MINNUMPEERS=1 MAXNUMPEERS=15 NUMREASONS=1.

FREQUENCIES VARIABLES=Q_RecaptchaScore
  /ORDER=ANALYSIS.

FREQUENCIES VARIABLES=AveDevExpertise
  /ORDER=ANALYSIS.
