* Encoding: UTF-8.

DATASET ACTIVATE DataSet1.

****Task Item Scoring Recodes and Total Task Score****

RECODE Task_Completion_Cont_1 Task_Completion_Cont_6 Task_Completion_Cont_7 Task_Completion_Cont_8 
    Task_Completion_Cont_11 (MISSING=0) (1=0) INTO Matches Pistols Milk Binoculars Compass.
EXECUTE.

RECODE Task_Completion_Cont_4 Task_Completion_Cont_5 Task_Completion_Cont_10 
    Task_Completion_Cont_12 Task_Completion_Cont_13 (MISSING=0) (1=1) INTO Silk Heating LifeRaft 
    Multitool Flares.
EXECUTE.

RECODE Task_Completion_Cont_2 Task_Completion_Cont_3 Task_Completion_Cont_9 Task_Completion_Cont_14 
    Task_Completion_Cont_15 (MISSING=0) (1=2) INTO Food Rope StellarMap FirstAidKit FMReceiver.
EXECUTE.

COMPUTE LunarScorePre=Sum(Matches,Food,Rope,Silk,Heating,Pistols,Milk,Binoculars,StellarMap,LifeRaft,
    Compass,Multitool,Flares,FirstAidKit,FMReceiver).
EXECUTE.



RECODE Task_Completion_Pos_1 Task_Completion_Pos_6 Task_Completion_Pos_7 Task_Completion_Pos_8 
    Task_Completion_Pos_11 (MISSING=0) (1=0) INTO MatchesP PistolsP MilkP BinocularsP CompassP.
EXECUTE.

RECODE Task_Completion_Pos_4 Task_Completion_Pos_5 Task_Completion_Pos_10 
    Task_Completion_Pos_12 Task_Completion_Pos_13 (MISSING=0) (1=1) INTO SilkP HeatingP LifeRaftP 
    MultitoolP FlaresP.
EXECUTE.

RECODE Task_Completion_Pos_2 Task_Completion_Pos_3 Task_Completion_Pos_9 Task_Completion_Pos_14 
    Task_Completion_Pos_15 (MISSING=0) (1=2) INTO FoodP RopeP StellarMapP FirstAidKitP FMReceiverP.
EXECUTE.

COMPUTE LunarScorePos=Sum(MatchesP,FoodP,RopeP,SilkP,HeatingP,PistolsP,MilkP,BinocularsP,StellarMapP,LifeRaftP,
    CompassP,MultitoolP,FlaresP,FirstAidKitP,FMReceiverP).
EXECUTE.




RECODE Task_Completion_Neg_1 Task_Completion_Neg_6 Task_Completion_Neg_7 Task_Completion_Neg_8 
    Task_Completion_Neg_11 (MISSING=0) (1=0) INTO MatchesN PistolsN MilkN BinocularsN CompassN.
EXECUTE.

RECODE Task_Completion_Neg_4 Task_Completion_Neg_5 Task_Completion_Neg_10 
    Task_Completion_Neg_12 Task_Completion_Neg_13 (MISSING=0) (1=1) INTO SilkN HeatingN LifeRaftN 
    MultitoolN FlaresN.
EXECUTE.

RECODE Task_Completion_Neg_2 Task_Completion_Neg_3 Task_Completion_Neg_9 Task_Completion_Neg_14 
    Task_Completion_Neg_15 (MISSING=0) (1=2) INTO FoodN RopeN StellarMapN FirstAidKitN FMReceiverN.
EXECUTE.

COMPUTE LunarScoreNeg=Sum(MatchesN,FoodN,RopeN,SilkN,HeatingN,PistolsN,MilkN,BinocularsN,StellarMapN,LifeRaftN,
    CompassN,MultitoolN,FlaresN,FirstAidKitN,FMReceiverN).
EXECUTE.


COMPUTE LunarScorePosttask=Sum(LunarScorePos,LunarScoreNeg).
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

*****Complete Again*****

COMPUTE CompleteAgain=Sum(Complete_Again_Neg,Complete_Again_Pos).
EXECUTE.    


* Identify Unusual Cases.

***Anomaly Detection - The others are Qualtrics Scores and Average Deviation**** 

DETECTANOMALY
  /VARIABLES SCALE=Expertise1 Expertise2 Expertise3 Expertise4 AITrust1 AITrust2 AITrust3 AITrust4 
    AITrust5 
  /PRINT ANOMALYLIST 
  /SAVE ANOMALY(AnomalyIndex) 
  /HANDLEMISSING APPLY=NO
  /CRITERIA PCTANOMALOUSCASES=5 ANOMALYCUTPOINT=2 MINNUMPEERS=1 MAXNUMPEERS=15 NUMREASONS=1.

FREQUENCIES VARIABLES=Q_RecaptchaScore
  /ORDER=ANALYSIS.

FREQUENCIES VARIABLES=AveDevExpertise
  /ORDER=ANALYSIS.

****H3 4-level factor****
 
IF  (AI_Recommendations=1 AND CompleteAgain=1) ConditionRevision=1.
EXECUTE.

IF  (AI_Recommendations=0 AND CompleteAgain=1) ConditionRevision=2.
EXECUTE.

IF  (AI_Recommendations=1 AND CompleteAgain=0) ConditionRevision=3.
EXECUTE.

IF  (AI_Recommendations=0 AND CompleteAgain=0) ConditionRevision=4.
EXECUTE.


*****AI Use****
    
RECODE Use_of_ChatGPT (3=1) (2=2) (1=3) INTO UseofAIInput.
EXECUTE.
