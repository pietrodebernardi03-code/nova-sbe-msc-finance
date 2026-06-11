# Assignment — ETF Portfolio Optimization
**Financial Modeling · Nova SBE · 2025/26**

*Pareto Asset Management — Investment Prospectus · November 28, 2025*

---

## Overview

This project constructs a **Constrained Strategic Asset Allocation** portfolio for a conservative investor profile ("Balanced Preservation with Moderate Growth") — specifically, a couple aged 50–60 with €500,000 from a recent real estate sale and a 10–20 year investment horizon.

The strategy is implemented exclusively through UCITS-compliant, accumulating ETFs traded on major European exchanges. A Python script automates the rebalancing process, computing the trades required to realign the portfolio to target weights.

---

## Final Allocation

| ETF | Ticker | Asset Class | Weight | TER |
|---|---|---|---|---|
| iShares Core MSCI World | IWDA.AS | Developed Equities | 45.32% | 0.20% |
| iShares Core MSCI EM IMI | IS3N.DE | Emerging Equities | 5.00% | 0.18% |
| iShares Core Global Aggregate Bond | AGGH.MI | Global Bonds (EUR-hedged) | 10.00% | 0.10% |
| iShares $ Treasury Bond 1–3yr | 2B7S.DE | Short-Term US Treasuries | 29.68% | 0.07% |
| iShares Physical Gold ETC | SGLN.L | Gold | 10.00% | 0.12% |

**Portfolio Metrics (Historical Backtest, 2017–present)**

| Metric | Strategy | Benchmark (60/40) |
|---|---|---|
| Annualised Return | 5.92% | 6.50% |
| Annualised Volatility | 5.81% | 10.20% |
| Sharpe Ratio | **0.59** | 0.45 |
| Maximum Drawdown | −18.50% | −24.00% |
| Worst Year | −7.24% | −15.00% |
| Win Year % | 80.00% | 65.00% |

---

## Methodology

### Optimisation Framework

The portfolio is constructed via **constrained Mean-Variance Optimisation** (Markowitz 1952), solved numerically using the SLSQP algorithm. Constraints prevent the unconstrained optimiser from reaching leveraged or highly concentrated allocations (e.g., 55% in Gold or −310% in emerging markets) that are impractical for a private investor.

**Formal problem:**

```
min_w  w^T Σ w
s.t.   w^T μ = μ_target
       Σ w_i = 1
       bounds per asset class (see below)
```

**Allocation bounds:**

| Asset Class | Min | Max |
|---|---|---|
| Developed Equities (IWDA) | 10% | 50% |
| Emerging Equities (IS3N) | 5% | 30% |
| Global Bonds (AGGH) | 0% | 40% |
| Short-Term Treasuries (2B7S) | 0% | 30% |
| Gold (SGLN) | 2% | 10% |

The 10% cap on Gold was the decisive constraint preventing the Monte Carlo optimiser from allocating 55% to the commodity.

### Rebalancing Policy

Semi-annual review or triggered rebalancing when any asset class deviates by more than 5% from its target weight. The Python script computes the exact trades required given current market prices.

---

## Files

| File | Description |
|---|---|
| `etf-portfolio-optimization.ipynb` | Full pipeline: data retrieval (FRED API + Yahoo Finance), efficient frontier construction, constrained MVO, historical backtest, rebalancing script |
| `etf-portfolio-optimization-report.pdf` | Investment prospectus with strategy rationale, allocation methodology, performance analysis, and implementation guidance |
| `.env.example` | Template for the FRED API key |

---

## Setup

### API Key

This project retrieves macroeconomic data via the **FRED API** (Federal Reserve Economic Data). FRED access is free and requires a personal API key.

1. Register at [https://fred.stlouisfed.org/docs/api/api_key.html](https://fred.stlouisfed.org/docs/api/api_key.html)
2. Copy `.env.example` to `.env` and insert your key:

```bash
cp .env.example .env
# then edit .env and add your key
```

3. Install dependencies:

```bash
pip install pandas numpy scipy matplotlib fredapi python-dotenv yfinance
```

The `.env` file is excluded from version control via `.gitignore`.

---

*Group J — Nova SBE 2025/26*
