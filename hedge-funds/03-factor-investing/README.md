# Factor Investing
**Hedge Funds · Nova SBE · Prof. Carlos Duarte D'Almeida**

---

## Overview

This project constructs and backtests a monthly-rebalanced, long/short equity factor model on the S&P 500 universe, spanning January 2014 through December 2025. The strategy holds the 20 highest-scoring stocks long and the 20 lowest-scoring stocks short, with a strict in-sample/out-of-sample split at December 2020.

The central contribution is a **dynamic risk parity composite** that allocates factor weights inversely proportional to rolling 36-month factor volatility, outperforming both equal-weight and rank-rank aggregation methods out of sample.

---

## Factor Selection

| Factor | Bloomberg Field | Economic Rationale |
|---|---|---|
| Earnings Yield | `EBITDA_EV_YIELD` | Valuation anchor; EBITDA/EV captures capital structure-neutral value |
| Return on Equity | `RETURN_COM_EQY` | Quality proxy for durable profitability |
| Profit Margin | `PROF_MARGIN` | Quality filter isolating competitive advantage |
| Operating Income Growth | `OPER_INC_GROWTH` | Fundamental momentum overlay |

All fundamental data is lagged by three months to eliminate look-ahead bias.

---

## Methodology

**Data Processing**
- 3-month reporting lag applied to all fundamental fields
- Cross-sectional winsorisation at the 2nd/98th percentile to remove accounting anomalies
- Z-score standardisation with optional Winsorization

**Portfolio Construction**
- N = 20 long, N = 20 short
- Hysteresis buffer of N+6 to limit portfolio turnover
- Transaction cost: 5 basis points one-way

**Factor Combination Methods**

| Method | Description |
|---|---|
| Equal Weight | Mean of cross-sectional Z-scores across all four factors |
| Rank-Rank | Cross-sectional rank average (identifies factor cancellation problem) |
| Risk Parity | Capital weighted inversely to rolling 36-month factor volatility |

**Out-of-Sample Results (2021–present)**

| Strategy | Ann. Return | Sharpe | Max Drawdown |
|---|---|---|---|
| Equal Weight | 10.19% | 0.53 | −30.78% |
| Rank-Rank | 5.46% | 0.28 | −40.41% |
| Risk Parity | **11.07%** | **0.61** | −32.05% |

---

## Files

| File | Description |
|---|---|
| `factor-investing.py` | Full backtest pipeline: data loading, factor construction, Z-score engine, simulation, performance reporting, tear-sheet plots |
| `factor-investing-report.pdf` | Written report with strategy overview, methodology, in-sample and out-of-sample results |

---

## Data

The backtest reads a Bloomberg Excel export with five fields across the S&P 500 universe:

| Bloomberg Field | Usage |
|---|---|
| `PX_LAST` | Month-end price series for return computation |
| `EBITDA_EV_YIELD` | Earnings Yield factor |
| `RETURN_COM_EQY` | Return on Equity factor |
| `PROF_MARGIN` | Profit Margin factor |
| `OPER_INC_GROWTH` | Operating Income Growth factor |

> **Note:** The Bloomberg Excel file (`Data Assignment 3 2010.xlsx`) is excluded from this repository as it contains data sourced from the Bloomberg Terminal under an institutional data licence. Bloomberg Terminal access is required to replicate the input dataset.

To run the script, place the Excel file in the same directory and update `EXCEL_PATH` at the top of `factor-investing.py`.

---
