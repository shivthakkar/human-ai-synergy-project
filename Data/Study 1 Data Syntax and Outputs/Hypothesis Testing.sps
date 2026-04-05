* Encoding: UTF-8.


***Test of H1a - Not Supported****

LOGISTIC REGRESSION VARIABLES Choose_Help
  /METHOD=ENTER Condition 
  /CONTRAST (Condition)=Indicator
  /CLASSPLOT
  /PRINT=GOODFIT CORR ITER(1) CI(99)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).


***Test of H1b - Supported****

LOGISTIC REGRESSION VARIABLES Choose_Help
  /METHOD=ENTER AITrust 
  /CLASSPLOT
  /PRINT=GOODFIT CORR ITER(1) CI(99)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

*****RQ1 - There was no interaction between AI trust and incentive condition on use****
    
COMPUTE AITrustxIncentive=AITrustMC*Condition.
EXECUTE.

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


