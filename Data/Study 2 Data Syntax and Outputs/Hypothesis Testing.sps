* Encoding: UTF-8.


***Test of H1 independently -  Supported****

LOGISTIC REGRESSION VARIABLES CompleteAgain
  /METHOD=ENTER AITrust 
  /CLASSPLOT
  /CASEWISE OUTLIER(2)
  /PRINT=GOODFIT CORR ITER(1) CI(99)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).


***Test of H2 Independent - Supported****

LOGISTIC REGRESSION VARIABLES CompleteAgain
  /METHOD=ENTER PerceivedExpertise 
  /CLASSPLOT
  /CASEWISE OUTLIER(2)
  /PRINT=GOODFIT CORR ITER(1) CI(99)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

***Test H1 and H2 Combined - Both Still Supported***

LOGISTIC REGRESSION VARIABLES CompleteAgain
  /METHOD=ENTER AITrust PerceivedExpertise 
  /CLASSPLOT
  /CASEWISE OUTLIER(2)
  /PRINT=GOODFIT CORR ITER(1) CI(99)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

***Test of H3a and H3b - Both Supported*******
    
UNIANOVA LunarScoreFinal BY ConditionRevision
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /POSTHOC=ConditionRevision(TUKEY T3) 
  /PLOT=PROFILE(ConditionRevision) TYPE=LINE ERRORBAR=CI MEANREFERENCE=NO YAXIS=AUTO
  /EMMEANS=TABLES(ConditionRevision) COMPARE ADJ(BONFERRONI)
  /PRINT ETASQ DESCRIPTIVE HOMOGENEITY OPOWER
  /CRITERIA=ALPHA(.01)
  /DESIGN=ConditionRevision.

UNIANOVA LunarScoreFinal BY CompleteAgain AI_Recommendations
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PLOT=PROFILE(CompleteAgain AI_Recommendations AI_Recommendations*CompleteAgain) TYPE=LINE 
    ERRORBAR=CI MEANREFERENCE=NO YAXIS=0
  /EMMEANS=TABLES(CompleteAgain) COMPARE ADJ(BONFERRONI)
  /EMMEANS=TABLES(AI_Recommendations) COMPARE ADJ(BONFERRONI)
  /EMMEANS=TABLES(CompleteAgain*AI_Recommendations) COMPARE(CompleteAgain) ADJ(BONFERRONI)
  /EMMEANS=TABLES(CompleteAgain*AI_Recommendations) COMPARE(AI_Recommendations) ADJ(BONFERRONI)
  /PRINT ETASQ DESCRIPTIVE HOMOGENEITY OPOWER
  /CRITERIA=ALPHA(.01)
  /DESIGN=CompleteAgain AI_Recommendations CompleteAgain*AI_Recommendations.

****Test of H3c *******
    
USE ALL.
COMPUTE filter_$=(CompleteAgain=1).
VARIABLE LABELS filter_$ 'CompleteAgain=1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

GLM LunarScorePre LunarScoreFinal BY AI_Recommendations
  /WSFACTOR=Scores 2 Polynomial 
  /METHOD=SSTYPE(3)
  /PLOT=PROFILE(AI_Recommendations*Scores) TYPE=LINE ERRORBAR=CI MEANREFERENCE=NO YAXIS=0
  /EMMEANS=TABLES(Scores) COMPARE ADJ(BONFERRONI)
  /EMMEANS=TABLES(AI_Recommendations) COMPARE ADJ(BONFERRONI)
  /EMMEANS=TABLES(AI_Recommendations*Scores) COMPARE(AI_Recommendations) ADJ(BONFERRONI)
  /EMMEANS=TABLES(AI_Recommendations*Scores) COMPARE(Scores) ADJ(BONFERRONI)
  /PRINT=DESCRIPTIVE ETASQ OPOWER HOMOGENEITY 
  /CRITERIA=ALPHA(.01)
  /WSDESIGN=Scores 
  /DESIGN=AI_Recommendations.

FILTER OFF.
USE ALL.
EXECUTE.

*****RQ1a - Yes, respondents were more likely to redo the task in the positive condition than the negative condition, but still not overly strong********
    
LOGISTIC REGRESSION VARIABLES CompleteAgain
  /METHOD=ENTER AI_Recommendations 
  /CONTRAST (AI_Recommendations)=Simple(1)
  /CLASSPLOT
  /CASEWISE OUTLIER(2)
  /PRINT=GOODFIT CORR ITER(1) CI(99)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

***RQ1b-Could not be tested as only 2 total respondents chose not to use any of the recommendations ******

USE ALL.
COMPUTE filter_$=(CompleteAgain=1).
VARIABLE LABELS filter_$ 'CompleteAgain=1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

NOMREG UseofAIInput (BASE=FIRST ORDER=ASCENDING) BY AI_Recommendations
  /CRITERIA CIN(99) DELTA(0) MXITER(100) MXSTEP(5) CHKSEP(20) LCONVERGE(0) PCONVERGE(0.000001) 
    SINGULAR(0.00000001) 
  /MODEL
  /STEPWISE=PIN(.05) POUT(0.1) MINEFFECT(0) RULE(SINGLE) ENTRYMETHOD(LR) REMOVALMETHOD(LR)
  /INTERCEPT=INCLUDE
  /PRINT=ASSOCIATION CELLPROB CLASSTABLE FIT CORB COVB PARAMETER SUMMARY LRT CPS STEP MFI IC.

USE ALL.
COMPUTE filter_$=(UseofAIInput=2 OR UseofAIInput=3).
VARIABLE LABELS filter_$ 'UseofAIInput=2 OR UseofAIInput=3 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

LOGISTIC REGRESSION VARIABLES UseofAIInput
  /METHOD=ENTER AI_Recommendations 
  /CONTRAST (AI_Recommendations)=Simple(1)
  /CLASSPLOT
  /CASEWISE OUTLIER(2)
  /PRINT=GOODFIT CORR ITER(1) CI(99)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

FILTER OFF.
USE ALL.
EXECUTE.

****Preparation for Interaction Tests*****
    
    
DESCRIPTIVES VARIABLES=AITrust PerceivedExpertise
  /STATISTICS=MEAN STDDEV MIN MAX.

COMPUTE AITrustMC=AITrust-3.2219.
EXECUTE.

COMPUTE ExpertiseMC=PerceivedExpertise-2.9266.
EXECUTE.

COMPUTE AITrustxCondition=AITrustMC*AI_Recommendations.
EXECUTE.

COMPUTE ExpertisexCondition=ExpertiseMC*AI_Recommendations.
EXECUTE.

COMPUTE AITrustxExpertise=ExpertiseMC*AITrustMC.
EXECUTE.

*****RQ2 - No interaction effect, but both predictors significant ****

LOGISTIC REGRESSION VARIABLES CompleteAgain
  /METHOD=ENTER AITrust AI_Recommendations 
  /METHOD=ENTER AITrustxCondition 
  /CONTRAST (AI_Recommendations)=Simple(1)
  /CLASSPLOT
  /CASEWISE OUTLIER(2)
  /PRINT=GOODFIT CORR ITER(1) CI(99)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

****RQ3 - Both predictors significant but no interaction effect*****

LOGISTIC REGRESSION VARIABLES CompleteAgain
  /METHOD=ENTER AI_Recommendations PerceivedExpertise 
  /METHOD=ENTER ExpertisexCondition 
  /CONTRAST (AI_Recommendations)=Simple(1)
  /CLASSPLOT
  /CASEWISE OUTLIER(2)
  /PRINT=GOODFIT CORR ITER(1) CI(99)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

****Test of all main effects from the RQ2 RQ3*****
    
LOGISTIC REGRESSION VARIABLES CompleteAgain
  /METHOD=ENTER AI_Recommendations PerceivedExpertise AITrust 
  /CONTRAST (AI_Recommendations)=Simple(1)
  /CLASSPLOT
  /CASEWISE OUTLIER(2)
  /PRINT=GOODFIT CORR ITER(1) CI(99)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).





LOGISTIC REGRESSION VARIABLES Choose_Help
  /METHOD=ENTER AITrust Condition 
  /METHOD=ENTER AITrustxIncentive 
  /CLASSPLOT
  /PRINT=GOODFIT CORR ITER(1) CI(99)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).


**RQ2 and RQ3 - Not significant interaction (RQ3), but both AI Trust and Perceived Expertise accounted for significant variance in AI use (RQ2)****
    
DESCRIPTIVES VARIABLES=AITrust PerceivedExpertise
  /STATISTICS=MEAN STDDEV MIN MAX.

COMPUTE AITrustMC=AITrust-3.4928.
EXECUTE.

COMPUTE ExpertiseMC=PerceivedExpertise-3.1796.
EXECUTE.

COMPUTE AITrustxExpertise=AITrustMC*ExpertiseMC.
EXECUTE.

LOGISTIC REGRESSION VARIABLES Choose_Help
  /METHOD=ENTER AITrust PerceivedExpertise 
  /METHOD=ENTER AITrustxExpertise 
  /CLASSPLOT
  /PRINT=GOODFIT CORR ITER(1) CI(99)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

****Test of H2 - Supported - Those who adopted all of AI recommendations did better than those who didn't who did better than those who didn't choose to seek input (also shows results for RQ4)****

RECODE AIInputUse (SYSMIS=0) (1=1) (2=2) INTO InputSeekingndUse.
EXECUTE.

RECODE AIInputUse1 (SYSMIS=0) (1=1) (2=2) INTO InputSeekingndUse1.
EXECUTE.

UNIANOVA LunarScore BY Choose_Help
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /EMMEANS=TABLES(Choose_Help) COMPARE ADJ(BONFERRONI)
  /PRINT ETASQ DESCRIPTIVE HOMOGENEITY OPOWER
  /CRITERIA=ALPHA(.01)
  /DESIGN=Choose_Help.

UNIANOVA LunarScore BY AIInputUse
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /EMMEANS=TABLES(AIInputUse) COMPARE ADJ(BONFERRONI)
  /PRINT ETASQ DESCRIPTIVE HOMOGENEITY
  /CRITERIA=ALPHA(.01)
  /DESIGN=AIInputUse.

UNIANOVA LunarScore BY AIInputUse1
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /EMMEANS=TABLES(AIInputUse1) COMPARE ADJ(BONFERRONI)
  /PRINT ETASQ DESCRIPTIVE HOMOGENEITY
  /CRITERIA=ALPHA(.01)
  /DESIGN=AIInputUse1.

UNIANOVA LunarScore BY InputSeekingndUse
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /POSTHOC=InputSeekingndUse(TUKEY) 
  /EMMEANS=TABLES(InputSeekingndUse) COMPARE ADJ(BONFERRONI)
  /PRINT ETASQ DESCRIPTIVE HOMOGENEITY
  /CRITERIA=ALPHA(.01)
  /DESIGN=InputSeekingndUse.

UNIANOVA LunarScore BY InputSeekingndUse1
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /POSTHOC=InputSeekingndUse1(TUKEY) 
  /EMMEANS=TABLES(InputSeekingndUse1) COMPARE ADJ(BONFERRONI)
  /PRINT ETASQ DESCRIPTIVE HOMOGENEITY
  /CRITERIA=ALPHA(.01)
  /DESIGN=InputSeekingndUse1.

UNIANOVA LunarScore BY InPutSeekingandUse2
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /POSTHOC=InPutSeekingandUse2(TUKEY) 
  /EMMEANS=TABLES(InPutSeekingandUse2) COMPARE ADJ(LSD)
  /PRINT ETASQ DESCRIPTIVE HOMOGENEITY
  /CRITERIA=ALPHA(.01)
  /DESIGN=InPutSeekingandUse2.

****RQ5 - No interaction, and in fact AItrust is not a significant predictor of performance after accounting for whether or not to choose to seek input. ****
    *****In other words, trust in AI appears to be more related to the decision to seek the input rather than actual performance******  
    
COMPUTE AITrustxSeekInput=AITrustMC*Choose_Help.
EXECUTE.

***See PROCESS Output 1****

***This led to the question of whether decision choice mediates relationship between AI trust abnd performance***
    ***Couldn't use PROCESS as it doesn't permit a binary mediator****
    ****Syntax below - Results show that the decision to seek input does in indeed mediate the relationship between both AI trust/perceived expertise and actual performance****
 
REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS CI(99) R ANOVA COLLIN TOL CHANGE ZPP
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT LunarScore
  /METHOD=ENTER AITrust PerceivedExpertise
  /METHOD=ENTER Choose_Help
  /RESIDUALS DURBIN.

































