# CDS Pricing
**Credit Risk · Nova SBE · 2025/26**

---

## Overview

This project prices a Credit Default Swap (CDS) from first principles using a bootstrapped term structure of default intensities. Three exercises are performed: extraction of the market-implied hazard rate term structure from observed CDS spreads, computation of the par spread for a 4-year CDS, and mark-to-market valuation of an existing position.

All calculations are implemented in Excel.

---

## Methodology

### Exercise 1 — Bootstrapping the Default Intensity Term Structure

The survival probability for horizon T is derived from the price of a defaultable zero-coupon bond under continuous compounding:

```
q(0,T) = 1 / e^{(r+s)·T}
```

where r = 3.5% (risk-free rate) and s is the observed CDS spread for each tenor. Three market quotes are used: 1-year (70 bp), 3-year (95 bp), 5-year (120 bp).

Survival probabilities and default intensities are bootstrapped sequentially:

| Period | Survival Probability | Default Intensity λ |
|---|---|---|
| 0 < t ≤ 1 | PS(0,1) = 0.98837 | **1.17%** |
| 1 < t ≤ 3 | PS(0,3) = 0.95317 | **1.81%** |
| 3 < t ≤ 5 | PS(0,5) = 0.90294 | **2.71%** |

The upward-sloping hazard rate term structure reflects increasing credit stress over longer horizons, consistent with the theoretical prediction for an investment-grade issuer with moderate near-term default risk.

### Exercise 2 — Par Spread of a 4-Year CDS

The par spread s\* is the coupon that sets the premium leg equal to the protection leg at inception. With quarterly payment dates t_i = i × 0.25 (i = 1, …, 16) and mid-period default approximation:

```
PV_prem = Σ [ Δ · e^{−r·t_i} · Q_i + (Δ/2) · e^{−r·t_{mid,i}} · ΔQ_i ]

PV_prot = Σ [ (1−R) · e^{−r·t_{mid,i}} · ΔQ_i ]

s* = PV_prot / RPV01
```

where ΔQ_i = Q(t_{i−1}) − Q(t_i) is the marginal default probability in period i.

**Results:**

| Component | Value |
|---|---|
| RPV01₄ᵧᵣ | 3.604141 |
| PV_prot | 0.040071 |
| **Par spread s\*** | **111.18 bp** |

The 4-year par spread of 111.18 bp lies between the 3-year (95 bp) and 5-year (120 bp) market quotes — consistent with an upward-sloping term structure of credit risk.

### Exercise 3 — Mark-to-Market Valuation

The protection buyer entered the CDS one year ago at a contractual spread of 60 bp. The current model-implied par spread for the now 4-year remaining CDS is 111.18 bp. Since spreads have widened, the position has gained value for the protection buyer:

```
MtM = (s_t − s_old) × RPV01_t × V
    = (0.011118 − 0.0060) × 3.604141 × 5,000,000
    = €92,230
```

The positive MtM confirms the gain to the protection buyer, as the current market spread exceeds the locked-in contractual rate.

---

## Files

| File | Description |
|---|---|
| `cds-pricing.xlsx` | Excel workbook: survival probability bootstrapping, quarterly cash flow schedule, premium leg and protection leg valuation, par spread solver, MtM calculation |
| `cds-pricing-report.pdf` | Written report with full derivations and results |

---

## Data

All inputs are synthetic parameters from the course assignment specification. No external dataset is required.

| Parameter | Value |
|---|---|
| Risk-free rate r | 3.50% (continuous) |
| CDS spreads (1y / 3y / 5y) | 70 bp / 95 bp / 120 bp |
| Recovery rate R | Given in assignment |
| Notional V | €5,000,000 |
| Contractual spread (old position) | 60 bp |
| Original CDS maturity | 5 years (now 4 years remaining) |

---
