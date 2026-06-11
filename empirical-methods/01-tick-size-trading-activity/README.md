# Tick Size and Trading Activity
**Empirical Methods for Finance · Nova SBE · 2025/26**

---

## Overview

This assignment investigates the causal effect of the SEC Tick Size Pilot Program on equity trading activity for small-capitalisation stocks. The empirical strategy exploits the stratified random assignment of approximately 1,200 stocks to three treatment groups with progressively more restrictive tick size requirements, using a difference-in-differences (DiD) framework against a control group that remained on the $0.01 regime.

The analysis replicates and extends the methodology of Albuquerque, Song, and Yao (2020, *Journal of Financial Economics*).

---

## Identification Strategy

**Natural Experiment:** The SEC's Tick Size Pilot Program (October 2016 – September 2018) raised the minimum quoting increment from $0.01 to $0.05 for randomly assigned treatment stocks. Three treatment groups impose progressively binding constraints:

- **G1:** Quoting requirement only ($0.05 minimum quote)
- **G2:** Quoting + trading requirement (no sub-increment execution)
- **G3:** G2 requirements + trade-at prohibition (off-exchange venues must offer $0.05 price improvement)

**Sample Period:** January 1, 2016 – April 30, 2019 (pre-treatment baseline, active pilot, post-pilot reversal)

**Identification Assumption (Parallel Trends):** Supported by the SEC's stratified random assignment; verified through pre-trend analysis.

---

## Empirical Specifications

**Baseline (H1 — Average Treatment Effect):**

```
ln(Turnover)_it = α + β₁(G1×TreatmentPeriod) + β₂(G2×TreatmentPeriod)
                  + β₃(G3×TreatmentPeriod) + λ₁(G1×PostPilot) + ...
                  + θ'X_it + γ_i + δ_t + ε_it
```

**Extended (H2 — Heterogeneous Effects by Pre-Treatment Spread):**

Augmented with triple interactions: Gk × TreatmentPeriod × SmallSpread, where SmallSpread = 1 if the firm's average pre-treatment quoted spread was below $0.05.

All specifications include **firm and date fixed effects** with standard errors clustered at the firm level.

---

## Key Results

**H1 — Average Treatment Effects (active pilot period):**

| Group | Coefficient | % Change in Turnover | p-value |
|---|---|---|---|
| G1 | −0.0884 | −8.46% | 0.007 |
| G2 | −0.0662 | −6.41% | 0.065 |
| G3 | −0.0954 | −9.10% | 0.011 |

**H2 — Heterogeneous Effects (constrained stocks, pre-spread < $0.05):**

| Group | Triple Interaction | p-value |
|---|---|---|
| G1 × SmallSpread | −0.169 | 0.031 |
| G2 × SmallSpread | −0.161 | 0.074 |
| G3 × SmallSpread | −0.187 | 0.054 |

Volume suppression is driven almost entirely by constrained stocks, confirming that the $0.05 floor mechanically widens spreads and eliminates marginal trades.

---

## Files

| File | Description |
|---|---|
| `tick-size-trading-activity.do` | Stata do-file: data cleaning, variable construction, DiD estimation (H1 and H2), summary statistics, robustness checks |
| `tick-size-trading-activity-report.docx` | Written report with full methodology, results tables, and economic interpretation |

---

## Data

The empirical analysis uses daily stock-level data from the **Center for Research in Security Prices (CRSP)**, matched with the SEC Tick Size Pilot treatment-control assignment list.

> **Note:** CRSP data is excluded from this repository. It is available to students and researchers through institutional subscriptions (Nova SBE library, WRDS). The do-file assumes a Stata dataset structured consistently with CRSP's daily stock file format (variables: `permno`, `date`, `vol`, `shrout`, `bid`, `ask`, `ret`, `prc`).

**Data filters applied:**
- Ordinary common shares only (share codes 10/11)
- Mergers/acquisitions excluded at firm level
- Delistings excluded (codes 400–599)
- Daily observations with price < $1 excluded (ITT approach — firms retained)
- Winsorisation at 1st/99th percentile for all continuous variables

---

*Nova SBE 2025/26*
