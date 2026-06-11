# MSc in Finance — Quantitative Portfolio
**· Nova School of Business and Economics, Carcavelos, Portugal**
*Pietro De Bernardi*

---

This repository contains the quantitative academic work produced during the MSc in Finance programme at Nova SBE. Projects span systematic trading, derivatives pricing, credit risk modelling, fixed income analytics, portfolio optimisation, numerical methods, and applied econometrics, implemented across Python, MATLAB/Dynare, Stata, and Excel.

All code is provided for academic and portfolio purposes. Proprietary datasets (Bloomberg, CRSP, OptionMetrics, Robinhood/RH) are excluded in compliance with their respective data-use agreements; each project's README specifies the required data sources and access procedures.

---

## Repository Structure

```
nova-sbe-msc-finance/
│
├── hedge-funds/
│   ├── 01-portfolio-backtesting/        Python · Trend-following & mean-reversion backtest
│   ├── 02-macro-trade-analysis/         Python · FX volatility models & macro trade ideas (USD/KRW, USD/CHF)
│   ├── 03-factor-investing/             Python · L/S equity factor backtest (S&P 500)
│   └── 04-statistical-arbitrage/        Python · Pairs trading portfolio (6 pairs, 132 trades, Sharpe 1.14)
│
├── derivatives/
│   └── 01-msft-options-analysis/        Python · IV surface, Breeden-Litzenberger RND, delta-hedging (MSFT)
│
├── credit-risk/
│   ├── 01-credit-var/                   Python · Credit VaR via analytical & Monte Carlo methods
│   └── 02-cds-pricing/                  Excel · CDS par spread bootstrapping & mark-to-market
│
├── fixed-income/
│   ├── 01-yield-curve-fitting/          Excel · YTM estimation, Nelson-Siegel & Svensson (German Bunds)
│   └── 02-bond-portfolio-immunization/  Excel · Duration matching, convexity, portfolio rebalancing
│
├── financial-modeling/
│   └── 01-etf-portfolio-optimization/   Python · Constrained MVO portfolio + FRED API
│
├── machine-learning/
│   └── 01-credit-score-prediction/      Python · Credit score classification pipeline
│
├── numerical-methods/
│   └── 01-stochastic-growth-model/      MATLAB/Dynare · Ramsey model, IRFs, 500-period simulation
│
├── empirical-methods/
│   └── 01-tick-size-trading-activity/   Stata · DiD analysis on SEC Tick Size Pilot (CRSP)
│
└── research-methods/
    └── 01-tick-size-turnover/           Stata · DiD + heterogeneous effects on trading turnover
```

---

## Technical Stack

| Language | Version | Key Libraries / Tools |
|---|---|---|
| Python | 3.10+ | `pandas`, `numpy`, `scipy`, `statsmodels`, `matplotlib`, `scikit-learn`, `xgboost`, `yfinance`, `fredapi` |
| MATLAB | R2024a | Dynare 6.x |
| Stata | 17+ | `reghdfe`, `xtset`, cointegration routines |
| Excel | Microsoft 365 | Solver (GRG Nonlinear), numerical optimisation |

---

## Data Sources

| Project | Source | Access |
|---|---|---|
| Portfolio Backtesting | Yahoo Finance (`yfinance`) | Free, public |
| Macro Trade Analysis | Bloomberg Terminal | Institutional — not included |
| Factor Investing | Bloomberg Terminal | Institutional — not included |
| Statistical Arbitrage | Yahoo Finance (`yfinance`) | Free, public |
| MSFT Options Analysis | OptionMetrics via Nova SBE | Institutional — not included |
| Credit VaR | Synthetic / handout data | Provided in-course |
| CDS Pricing | Synthetic / handout data | Provided in-course |
| Yield Curve Fitting | Bloomberg Terminal (German Bunds) | Institutional — not included |
| Bond Immunization | Synthetic case data | No external data required |
| ETF Portfolio Optimization | FRED API + Yahoo Finance | Free, public API key required |
| Credit Score Prediction | Course dataset | Not included |
| Stochastic Growth Model | Synthetic | No external data |
| Tick Size (Empirical) | CRSP via Nova SBE | Institutional — not included |
| Tick Size (Research) | CRSP / RH via Nova SBE | Institutional — not included |

---

## Academic Context

All projects were completed as part of the following courses at Nova SBE during the academic year 2025/2026):

- **Hedge Funds** — Prof. Carlos Duarte D'Almeida
- **Derivatives** — Prof. Gustavo Freire
- **Credit Risk** — Prof. Ante Sterc
- **Fixed Income** — Prof. Ante Sterc
- **Financial Modeling** — Prof. Tatyana Marchuk
- **Introduction to Machine Learning** — Prof. Sabina Zejnilovic
- **Numerical Methods for Economics and Finance** — Prof. André Silva
- **Empirical Methods for Finance** — Prof. Virginia Gianinazzi
- **Research Methods for Finance** — Prof. Julio A. Crego, T.A. Fabian Waßmann

---

*For questions or collaboration inquiries, please open an issue or contact via GitHub.*
