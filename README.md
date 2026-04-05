# Human-AI Synergy: Quantifying the Impact of Explanation Quality on User Trust

![Python](https://img.shields.io/badge/Python-3.13-blue?logo=python)
![Jupyter](https://img.shields.io/badge/Jupyter-Notebook-orange?logo=jupyter)
![scikit-learn](https://img.shields.io/badge/scikit--learn-ML-green?logo=scikit-learn)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen)

A complete data science research project investigating how the quality of AI explanations affects human trust and behavioral decision-making.

> *"Technical accuracy alone is insufficient for AI adoption — Cognitive Fit and Explanation Quality are the true drivers of human-AI synergy."*

---

## Research Question

> *Does higher AI explanation transparency lead to higher user trust — and does that trust actually change behavior?*

---

## Project Overview

This project builds a full data science pipeline to measure how explanation transparency impacts human trust in AI, using the **Weight of Advice (WoA)** behavioral framework from decision science.

Two datasets were used:
- **Primary dataset:** 1,000 AI interaction records (23 variables) — CSV format
- **Secondary dataset:** 526 experimental behavioral records (158 variables) — SPSS `.sav` format sourced from the Open Science Framework (lunar estimation task)

---

## Key Findings

- **Transparency significantly predicts trust:** β = +1.475, p < 0.001 — for every unit increase in explanation transparency, trust increases by 1.475 points on a 10-point scale
- **AI Confidence Percentage** was the #1 trust driver, accounting for **44.7%** of feature importance in the best model
- **Attitude-behavior gap discovered:** stated trust only weakly predicts actual advice-following behavior (r = 0.078) — people who report high trust don't necessarily follow AI advice
- **Random Forest** was the best model, explaining **67.4%** of variance in trust scores (R² = 0.674), confirmed by 5-fold cross-validation (CV R² = 0.639)
- **Higher digital literacy and AI familiarity reduce naive trust** — experienced users require evidence, not just confidence signals
- R² improved progressively from **7% → 47% → 67%** as model complexity increased

---

## Model Performance Summary

| Model | Test R² | CV R² | Test MAE | RMSE |
|---|---|---|---|---|
| M1 — Simple Linear Regression | 0.071 | 0.032 | 1.482 | 1.815 |
| M2 — Multiple Linear Regression | 0.467 | 0.411 | 1.097 | 1.376 |
| **M3 — Random Forest ★ (Best)** | **0.674** | **0.639** | **0.891** | **1.075** |
| M4 — Logistic Regression | 68.0% acc. | 63.2% | — | F1 = 0.629 |

---

## Feature Importance (Random Forest)

| Rank | Feature | Importance |
|---|---|---|
| 1 | AI Confidence Percentage | 44.68% |
| 2 | Answer Accuracy Percentage | 23.54% |
| 3 | Decision Importance | 8.97% |
| 4 | Transparency Score | 6.21% |
| 5 | AI Familiarity Level | 4.63% |
| 6 | Has Cited Sources | 3.97% |
| 7 | Digital Literacy | 2.72% |
| 8 | Contains Hedging Words | 2.57% |

---

## The WoA Framework

Weight of Advice (WoA) measures how much a person actually updates their decision after receiving AI advice:

```
WoA = (Final Decision − Initial Decision) / (AI Score − Initial Decision)
```

| WoA Value | Meaning |
|---|---|
| WoA = 0 | Completely ignored AI |
| WoA = 0.5 | Split the difference equally |
| WoA = 1 | Fully adopted AI advice |

The secondary dataset revealed that despite high stated trust, WoA scores were weakly correlated (r = 0.078), exposing a critical **attitude-behavior gap** in human-AI interaction.

---

## Project Pipeline (9 Steps)

| Step | Description | Tools |
|---|---|---|
| 1. Data Acquisition | CSV + SPSS loading | pandas, pyreadstat |
| 2. Data Inspection | Shape, dtypes, missing values | pandas |
| 3. Data Cleaning | Missing values, outliers (IQR), label encoding | pandas, scipy |
| 4. Feature Engineering | Explanation Transparency Score (5-variable composite), WoA computation | numpy, sklearn |
| 5. EDA | Correlation heatmaps, distributions, trust by skepticism group | matplotlib, seaborn |
| 6. Modeling | Simple LR, Multiple LR, Random Forest, Logistic Regression | scikit-learn, statsmodels |
| 7. Evaluation | R², MAE, RMSE, 5-fold CV, confusion matrix, classification report | scikit-learn |
| 8. Visualization | 5 publication-ready figures | matplotlib, seaborn |
| 9. Behavioral Validation | Cross-dataset WoA analysis with secondary SPSS data | scipy, statsmodels |

---

## Tech Stack

| Tool | Purpose |
|---|---|
| Python 3.13 | Core language |
| pandas | Data manipulation |
| numpy | Numerical operations |
| scikit-learn | Machine learning models, cross-validation |
| statsmodels | Statistical regression output (p-values, confidence intervals) |
| scipy | Z-scores, normality tests, statistical functions |
| matplotlib / seaborn | Visualizations |
| pyreadstat | Reading SPSS `.sav` files |

---

## Repository Structure

```
human-ai-synergy-project/
│
├── DSProject_1.ipynb                                  # Main Jupyter Notebook (full 9-step pipeline)
├── DSProject 1.pdf                                    # Exported PDF with all outputs
├── Shivam_Thakkar_CS628_Final_Presentation.pptx       # Final presentation slides
│
├── Data/
│   ├── ai_skepticism_dataset.csv                      # Primary dataset (1,000 rows × 23 columns)
│   └── Study 2 Data Syntax and Outputs/
│       └── AI and Decision Making_FINAL_dataset.sav   # Secondary SPSS dataset (526 rows)
│
└── Visualization/
    ├── fig1_regression_confidence_bands.png            # Core transparency-trust relationship
    ├── fig2_feature_importance.png                     # Random Forest feature importance
    ├── fig3_trust_calibration_curve.png                # Trust calibration by skepticism group
    ├── fig4_model_dashboard.png                        # All 4 models compared
    ├── fig5_woa_aitrust.png                            # WoA behavioral validation
    └── ...additional diagnostic plots
```

---

## How to Run

1. **Clone the repository**
```bash
git clone https://github.com/shivthakkar/human-ai-synergy-project.git
cd human-ai-synergy-project
```

2. **Install dependencies**
```bash
pip install pandas numpy matplotlib seaborn scikit-learn pyreadstat scipy statsmodels
```

3. **Update file paths** in the notebook (Cells 2–3) to match your local directory

4. **Open in Jupyter or VS Code** and run all cells sequentially

---

## Implications

- AI systems should **calibrate confidence displays** — how AI communicates confidence matters more than structural explanation features
- **Behavioral nudges** are needed to bridge the gap between stated trust and actual advice-following
- High-literacy users require evidence-based explanations, not just confidence signals
- Technical accuracy alone is insufficient — explanation quality is a critical adoption driver

---

## Future Research Directions

- Include personality variables as trust moderators
- Test non-linear trust models (polynomial, interaction effects)
- Add cognitive load and domain expertise variables
- Replicate with real organizational decision-making data
- Longitudinal design to track trust calibration over time

---

## References

1. Ebermann, C., Selisky, M., & Weibelzahl, S. (2023). Explainable AI: The effect of contradictory decisions and explanations on users' acceptance. *International Journal of Human-Computer Interaction, 39*(9), 1807–1826.
2. Jiang, L., et al. (2023). Who should be first? How and when AI-human order influences procedural justice. *PLoS ONE, 18*(7), e0284840.
3. Lai, V., Chen, C., Smith-Renner, A. M., Liao, Q. V., & Tan, C. (2023). Towards a science of human-AI decision making. *FAccT '23 Proceedings.*
4. Neri, G., et al. (2025). Data visualization in AI-assisted decision-making: A systematic review. *Frontiers in Communication, 10*, 1605655.
5. Wen, Y., Wang, J., & Chen, X. (2025). Trust and AI weight: Human-AI collaboration in organizational management decision-making. *Frontiers in Organizational Psychology, 3*, 1419403.
6. Yaniv, I., & Kleinberger, E. (2000). Advice taking in decision making: Egocentric discounting and reputation formation. *Organizational Behavior and Human Decision Processes, 83*(2), 260–281.

---

## Connect

**LinkedIn:** [linkedin.com/in/shivamthakkar](https://linkedin.com/in/shivamthakkar)  
**GitHub:** [github.com/shivthakkar](https://github.com/shivthakkar)
