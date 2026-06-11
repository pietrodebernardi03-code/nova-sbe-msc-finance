# Assignment 1 — Yield Curve Fitting
**Fixed Income · Nova SBE · Prof. Ante Sterc · February 27, 2026**

---

## Overview

This project estimates the term structure of interest rates for the German government bond market using parametric yield curve models. The analysis is conducted on a cross-section of 13 Bunds (BUBILLs, BKOs, OBLs, DBRs) with a common settlement date of February 7, 2023, covering maturities from 0.04 to 30.5 years.

Three tasks are performed: continuous-compounding YTM estimation from full (dirty) prices, calibration of Nelson-Siegel and Svensson models via numerical optimisation in Excel Solver, and a quantitative comparison of model fit.

---

## Data

Settlement date: **February 7, 2023**. Clean prices are sourced from Bloomberg last trades and converted to full prices by adding accrued interest computed via `YEARFRAC` with the ACT/ACT day count convention per bond.

> **Note:** The Bloomberg price data is embedded in the Excel workbook but is sourced from the Bloomberg Terminal under an institutional data licence. The workbook is provided for methodological transparency; the underlying prices cannot be independently redistributed.

**Bond universe (13 instruments):**

| Instrument | Maturities Covered |
|---|---|
| BUBILL (zero-coupon T-bills) | 0.04y – 0.45y |
| BKO (2-year notes) | 1.1y – 2.1y |
| OBL (5-year notes) | 3.2y – 5.2y |
| DBR (10–30 year Bunds) | 6.0y – 30.5y |

---

## Methodology

### Exercise 1 — Yield to Maturity (Continuous Compounding)

For each bond, YTM is solved numerically to match the full market price to the present value of all future cash flows discounted at a constant continuous rate:

```
Full Price = Σ CF_t · e^{-YTM · t}
```

Time to maturity is computed as `YEARFRAC(settlement, maturity, basis=1)`.

**Key result:** The YTM curve exhibits a pronounced short-end peak at ~2.53% (1-year maturity) and converges to 2.1–2.2% at long maturities — consistent with the ECB tightening cycle of early 2023.

### Exercise 2 — Nelson-Siegel and Svensson Calibration

Both models are calibrated by minimising the sum of squared price errors (SSE) using **Excel Solver** (GRG Nonlinear method).

**Nelson-Siegel spot rate:**
```
r(0,T) = β₁ + β₂·[(1 − e^{−T/λ₁})/(T/λ₁)]
        + β₃·[(1 − e^{−T/λ₁})/(T/λ₁) − e^{−T/λ₁}]
```

**Svensson** adds a second hump term with parameters β₄ and λ₂, allowing independent control of the long end of the curve.

**Initialisation strategy:** parameters are set using their economic interpretation (β₁ = long-run rate anchor = 2.2%, β₂ = slope = short − long rate, curvature terms set to 0) to avoid local minima and prevent negative long-term forward rates.

**Calibrated parameters:**

| Parameter | Nelson-Siegel | Svensson |
|---|---|---|
| β₁ (level) | 0.0221 | 0.0208 |
| β₂ (slope) | 0.0163 | −0.0062 |
| β₃ (curvature 1) | −0.0272 | 0.0242 |
| λ₁ | 0.4779 | 0.3136 |
| β₄ (curvature 2) | — | −0.0001 |
| λ₂ | — | 2.9300 |

### Exercise 3 — Model Comparison

Svensson provides strictly lower SSE, reducing the 1-year BKO pricing error from −0.507% (Nelson-Siegel) to −0.016%. However, Nelson-Siegel is structurally more parsimonious and robust to overfitting — the preferred choice when the goal is out-of-sample stability rather than in-sample precision.

Both models converge to 2.1–2.2% at long horizons. Differences are most pronounced at short maturities, where Svensson's second curvature term allows a more flexible shape.

---

## Files

| File | Description |
|---|---|
| `yield-curve-fitting.xlsx` | Excel workbook: full price computation, YTM solver, Nelson-Siegel and Svensson calibration via Solver, fitted yield curves, discount factors, model comparison |
| `yield-curve-fitting-report.pdf` | Written report with methodology, results tables, and model comparison |

---

## Replication Notes

To re-run the Solver optimisation in Excel:
1. Open `yield-curve-fitting.xlsx`
2. Go to the Nelson-Siegel or Svensson sheet
3. Data → Solver → Set Objective (SSE cell) → Minimize → By Changing Variable Cells (β and λ parameters) → Solve
4. Ensure GRG Nonlinear is selected as the solving method

---

*Group 8: Pietro De Bernardi (69791), Jerome Henderickx (77435), Eva Anna Marie Demasure (70301), Leith Konstantinos Alexandris-Baba (75673)*
