# MSc in Finance — Quantitative Portfolio

**Nova School of Business and Economics · Carcavelos, Portugal**

*Pietro De Bernardi*

---

This repository contains the quantitative academic work produced during the MSc in Finance programme at Nova SBE. Projects span systematic trading, credit risk modelling, portfolio optimisation, numerical methods, and applied econometrics, implemented across Python, MATLAB/Dynare, and Stata.

All code is provided for academic and portfolio purposes. Proprietary datasets (Bloomberg, CRSP, OptionMetrics, Robinhood/RH) are excluded in compliance with their respective data-use agreements; each project's README specifies the required data sources and access procedures.

---

## Repository Structure

```
nova-sbe-msc-finance/
│
├── hedge-funds/
│   ├── 01-portfolio-backtesting/      Python · Trend-following & mean-reversion backtest
│   ├── 02-macro-trade-analysis/       Python · FX volatility models & macro trade ideas
│   ├── 03-factor-investing/           Python · L/S equity factor backtest (S&P 500)
│   └── 04-statistical-arbitrage/      Python · Pairs trading portfolio (6 pairs, 132 trades)
│
├── credit-risk/
│   └── 01-credit-var/                 Python · Credit VaR via analytical & Monte Carlo methods
│
├── financial-modeling/
│   └── 01-etf-portfolio-optimization/ Python · Constrained MVO portfolio + FRED API
│
├── numerical-methods/
│   └── 01-stochastic-growth-model/    MATLAB/Dynare · Ramsey model, IRFs, 500-period simulation
│
├── empirical-methods/
│   └── 01-tick-size-trading-activity/ Stata · DiD analysis on SEC Tick Size Pilot (CRSP)
│
└── research-methods/
    └── 01-tick-size-turnover/         Stata · DiD + heterogeneous effects on trading turnover
```

---

## Technical Stack

| Language | Version | Key Libraries |
|---|---|---|
| Python | 3.10+ | `pandas`, `numpy`, `scipy`, `statsmodels`, `matplotlib`, `yfinance`, `fredapi` |
| MATLAB | R2024a | Dynare 6.x |
| Stata | 17+ | `reghdfe`, `xtset`, `cointegration` routines |

---

## Data Sources

| Project | Source | Access |
|---|---|---|
| Portfolio Backtesting | Yahoo Finance (`yfinance`) | Free, public |
| Macro Trade Analysis | Bloomberg Terminal | Institutional — not included |
| Factor Investing | Bloomberg Terminal | Institutional — not included |
| Statistical Arbitrage | Yahoo Finance (`yfinance`) | Free, public |
| Credit VaR | Synthetic / handout data | Provided in-course |
| ETF Portfolio Optimization | FRED API | Free, public API key required |
| Stochastic Growth Model | Synthetic | No external data |
| Tick Size (Empirical) | CRSP via Nova SBE | Institutional — not included |
| Tick Size (Research) | CRSP / RH via Nova SBE | Institutional — not included |

---

## Academic Context

All projects were completed as part of the following courses at Nova SBE (2025-2026):

- **Hedge Funds** — Prof. Carlos Duarte D'Almeida
- **Credit Risk** — Prof. Ante Sterc
- **Financial Modeling** — Prof. Tatyana Marchuk
- **Numerical Methods for Economics and Finance** — Prof. André Silva
- **Empirical Methods for Finance** — Prof. Virginia Gianinazzi
- **Research Methods for Finance** — Prof. Julio A. Crego, T.A. Fabian Waßmann

---

*For questions or collaboration inquiries, please open an issue or contact via GitHub.*
