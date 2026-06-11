# Macro Trade Analysis
**Hedge Funds · Nova SBE · Prof. Carlos Duarte D'Almeida**

*Data as of the last week of February 2026. The macroeconomic assessment does not incorporate subsequent geopolitical developments.*

---

## Overview

This project translates a global macro outlook into two actionable FX derivatives trades, exploiting a structural mispricing between options market implied volatility and fundamental interest rate dynamics. Both trades are identified as directionally biased with strictly capped downside equal to the premium paid.

A custom Python quantitative model is built to compute **forward-implied yield differential volatility** under Covered Interest Parity (CIP), providing an institutional-grade alternative to surface Bloomberg ATM implied volatility.

---

## Macro Framework

Global markets in early 2026 are characterised by a dense cluster of policy risks driven by US trade protectionism, a potential shift in Federal Reserve leadership, and persistent Asian capital flow imbalances. The key structural insight is that options markets are anchoring to suppressed realised volatility while ignoring imminent binary macro catalysts.

**Trade 1 — Long Strangle USD/KRW**
- Rationale: The KRW is in a coiled spring state. Bank of Korea FX intervention is artificially suppressing implied volatility to the 12th percentile of its 5-year distribution. Two binary, directionally opposite catalysts — US tariff escalation (KRW depreciation) and domestic capital repatriation via Reshoring Investment Accounts (KRW appreciation) — are both plausible on a 3-month horizon.
- Structure: 3-month ATM strangle; maximum loss capped at premium paid.

**Trade 2 — Long Call USD/CHF**
- Rationale: Safe-haven crowding has compressed USD/CHF to its multi-year historical lower bound. Implied volatility on the forward yield differential stands in the bottom decile historically, while the USD/CHF SOFR yield spread (3.87 percentage points) is near multi-year highs.
- Structure: 3-month ATM call (strike 0.7668); premium ≈ 1.55% of notional.

---

## Quantitative Model

The Python script implements forward-implied yield differential volatility for both currency pairs using CIP:

```
Yield_Diff(t) = (1/T) × ln(Forward_3M(t) / Spot(t))
```

where T = 0.25 (3-month tenor). A 21-day rolling standard deviation annualised by √252 provides the volatility estimate. Z-scores and percentile ranks over a 5-year lookback are used to benchmark current implied volatility against history.

---

## Files

| File | Description |
|---|---|
| `macro-trade-volatility-model.py` | CIP-based forward implied yield differential volatility model for USD/KRW and USD/CHF |
| `macro-trade-report.pdf` | Full written report: macro analysis, trade construction, Bloomberg chart references |

---

## Data

The Python model requires two CSV files with spot and 3-month forward rates:

| File | Columns | Source |
|---|---|---|
| `USDKRW.csv` | `Date`, `USDKRW`, `USDKWN 3M` | Bloomberg Terminal |
| `USDCHF.csv` | `Date`, `USDCHF`, `USDCHF 3M` | Bloomberg Terminal |

> **Note:** These CSV files are excluded from the repository as they contain Bloomberg-sourced data subject to a proprietary data licence. Bloomberg Terminal access is required to replicate the model inputs. Bloomberg ATM implied volatility charts referenced in the report (Figures 3 and 5) are similarly excluded.

---
