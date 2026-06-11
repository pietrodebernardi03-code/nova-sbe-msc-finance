# Portfolio Backtesting
**Hedge Funds · Nova SBE · Prof. Carlos Duarte D'Almeida**

---

## Overview

This project designs, backtests, and evaluates a systematic multi-asset portfolio strategy across three asset classes — equities, fixed income, and commodities — using futures contracts. The study period spans 2007–2026.

The core contribution is a **VIX-triggered regime-switching framework** that dynamically toggles between two static allocation methods depending on prevailing market volatility conditions, achieving superior risk-adjusted performance relative to either static strategy in isolation.

---

## Strategy Architecture

**Universe**
- Equities: S&P 500, Dow Jones, Nasdaq 100 futures
- Fixed Income: US Treasury futures (2Y, 5Y, 10Y)
- Commodities: Gold, Silver, Copper futures

**Signal Generation**
Each asset class is assigned its optimal signal type through grid-search optimisation over moving-average windows and volatility bands:

| Asset Class | Strategy | Window | Std Dev | Sharpe |
|---|---|---|---|---|
| Equities | Mean Reversion | 20d | 2.0σ | 0.43 |
| Bonds | Trend Following | 200d | 1.5σ | 0.35 |
| Commodities | Trend Following | 50d | 1.5σ | 0.27 |

**Portfolio Construction**
Two static allocations are evaluated — Capped-Weight Tangency (MVO with concentration limits) and Risk Parity — and combined via a dynamic regime-switching rule:

- VIX < 25 → deploy Tangency weights (growth-oriented)
- VIX ≥ 25 → deploy Risk Parity weights (defensive)

**Key Results (Regime-Switching)**

| Metric | Value |
|---|---|
| Information Sharpe Ratio | 0.690 |
| Maximum Drawdown | −4.49% |

The regime-switching strategy outperforms both static alternatives on a risk-adjusted basis, with drawdown improvement of 1.23 percentage points relative to the static Tangency portfolio.

---

## Files

| File | Description |
|---|---|
| `portfolio-backtesting.ipynb` | Full backtest pipeline: data ingestion, signal optimisation, portfolio construction, regime analysis, sensitivity tests |
| `portfolio-backtesting-report.pdf` | Written report with methodology, results tables, and interpretation |

---

## Data

Price data for all futures contracts is retrieved programmatically via **Yahoo Finance** (`yfinance`). No proprietary datasets are required.

```python
pip install yfinance pandas numpy scipy matplotlib
```

---

## Methodology Notes

- Equal-weighting within each asset class reduces idiosyncratic noise prior to cross-asset allocation
- Regime identification uses the CBOE VIX index as the switching variable
- Sensitivity analysis confirms robustness across VIX thresholds in the 20–30 range

---
