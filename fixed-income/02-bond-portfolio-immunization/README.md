# Assignment 2 — Bond Portfolio Immunization
**Fixed Income · Nova SBE · Prof. Ante Sterc · March 13, 2026**

---

## Overview

This project implements classical bond portfolio immunization for an insurance company that has issued two Guaranteed Investment Contracts (GICs). The analysis covers initial immunization via duration matching, verification of immunization effectiveness under a parallel rate shift, and portfolio rebalancing at t = 1 using a four-asset constrained optimisation.

All calculations are implemented in Excel using continuous compounding and Excel Solver for the rebalancing optimisation.

---

## Problem Setup

**Liabilities:**

| GIC | Payment | Maturity |
|---|---|---|
| GIC 1 | €100,000 | T = 2 years |
| GIC 2 | €110,000 | T = 3 years |

**Interest rate assumptions:**
- t = 0: flat term structure at r₀ = 2.00% (continuous)
- Rate shift: parallel shift to r₁ = 2.40% (continuous), assumed to occur immediately after t = 0

---

## Methodology

### Exercise 1 — Immunization at t = 0

**Step 1 — Liability valuation and duration:**

```
VL(0) = 100,000 · e^{−0.02·2} + 110,000 · e^{−0.02·3} = €199,673.04
D_L   = [2 · PV(GIC1) + 3 · PV(GIC2)] / VL(0) = 2.5188 years
```

**Step 2 — Asset selection:**
- Floating Rate Bond (FRB), 4-year maturity: resets annually → price = par, duration = 1 year
- Coupon Bearing Bond (CBB 5%), 5-year maturity: price = €1.1404/face, duration = 4.5787 years

**Step 3 — Duration matching (two-equation linear system):**

```
w_FRB + w_CBB = 1
w_FRB · 1 + w_CBB · 4.5787 = 2.5188
```

Solution: w_FRB = 57.56%, w_CBB = 42.44%

**Immunizing portfolio:**

| Asset | Market Value | Face Value |
|---|---|---|
| FRB | €114,929.71 | €114,929.71 |
| CBB 5% | €84,743.33 | €74,311.96 |
| **Total** | **€199,673.04** | |

**Verification — Terminal Wealth at T = 3 (r shifts to 2.40%):**

After the rate shift, coupons are reinvested at 2.40% and the CBB's residual cash flows (t = 4, 5) are sold at t = 3 at their new market value. Total asset future value = €212,434.71; total liability future value = €212,429.03.

**Terminal Wealth = €5.67 ≈ 0** — immunization holds. The small positive residual arises from the higher convexity of the asset portfolio relative to the liability stream, consistent with theory.

---

### Exercise 2 — Portfolio Rebalancing at t = 1

At t = 1, the rate remains at 2.40%. Portfolio value = €202,478.70 (given). Two years of liabilities remain.

**Remaining liability duration:** 1.5178 years | **Convexity:** 2.5535 years²

**Available assets at t = 1:**

| Asset | Duration | Convexity |
|---|---|---|
| FRB (3 years remaining) | 1.0000 | 1.0000 |
| CBB 5% (4 years remaining) | 3.7372 | 14.5142 |
| 6-month ZCB (new) | 0.5000 | 0.2500 |
| CBB 2% (2-year, new) | 1.9803 | 3.9409 |

**Optimisation objective:** minimise squared deviations from current face values (transaction cost proxy), subject to:
- Full investment constraint (Σ weights = 1)
- Duration match: D_Assets = 1.5178 years
- Convexity constraint: C_Assets ≥ 2.5535 years²
- Concentration limit: no asset > 50% by market value

**Optimal rebalanced portfolio:**

| Asset | New Market Value | Weight | Trade |
|---|---|---|---|
| FRB | €101,239.35 | 50.00% | −€13,690.36 |
| CBB 5% | €42,860.67 | 21.17% | −€38,650.98 |
| ZCB | €47,084.12 | 23.25% | +€47,084.12 |
| CBB 2% | €11,294.56 | 5.58% | +€11,294.56 |

**Achieved:** D_Assets = 1.5178 (exact match), C_Assets = 3.8503 > 2.5535 (convexity condition satisfied with margin of +1.2969 years²).

---

## Files

| File | Description |
|---|---|
| `bond-portfolio-immunization.xlsx` | Excel workbook: liability pricing, Macaulay duration, CBB and FRB valuation, duration-matching weights, terminal wealth calculation, rebalancing Solver optimisation |
| `bond-portfolio-immunization-report.pdf` | Written report with full derivations, tables, and interpretation |

---

## Replication Notes

No external data is required. All inputs (liability amounts, coupon rates, interest rates) are hard-coded parameters from the case specification. To re-run the rebalancing optimisation (Exercise 2):

1. Open `bond-portfolio-immunization.xlsx`, navigate to the Exercise 2 sheet
2. Data → Solver
3. Objective: minimise sum of squared face value deviations
4. Subject to: duration = 1.5178, convexity ≥ 2.5535, Σ weights = 1, each weight ≤ 0.50
5. Method: GRG Nonlinear → Solve

---

*Group 8: Pietro De Bernardi (69791), Jerome Henderickx (77435), Eva Anna Marie Demasure (70301), Leith Konstantinos Alexandris-Baba (75673)*
