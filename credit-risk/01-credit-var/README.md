# Project 5 — Credit Value-at-Risk
**Credit Risk · Nova SBE · 2025/26**

---

## Overview

This project computes Credit VaR for a corporate bond portfolio using three progressively generalised methods: an analytical bivariate normal framework, a two-bond Monte Carlo simulation with a factor-structured asset return model, and a full 17-bond portfolio simulation with both fixed and stochastic recovery rates.

All computations are implemented from first principles in Python, replicating the methodology of Chapter 4 of the course handouts.

---

## Methodology

### Exercise 1 — Analytical Credit VaR (ρ = 0.072)

The year-end value of each bond is computed as the present value of remaining cash flows discounted at one-year forward zero rates specific to each destination rating (Table 4.2):

```
P_j(k) = Σ CF_{j,t} · D(k,t)    where D(k,t) = 1 / (1 + r_{k,t})^t
```

Rating-migration thresholds are derived by inverting the standard normal CDF over the one-year transition probability matrix:

```
z_k = Φ⁻¹(1 − Σ_{j≤k} p_j)
```

The joint transition probability matrix is constructed using the bivariate standard normal CDF with correlation ρ = 0.072. Credit VaR is defined as:

```
Credit VaR = μ_V − V*
```

where μ_V is the expected portfolio value and V\* is the 1% quantile of the joint portfolio value distribution.

**Results:** μ_V = 213.27, V\* = 203.73, Credit VaR = **9.54**

### Exercise 2 — Monte Carlo Simulation (Two-Bond, N = 100,000)

Asset returns are modelled through the factor structure of Example 4.1.2:

```
r_Viv = 0.4T + 0.2L + ε_Viv
r_GM  = 0.9C + ε_GM
```

Idiosyncratic variances are derived from the unit-variance constraint:

```
σ²_{ε,i} = 1 − b_i^T Σ_F b_i
```

Giving σ_Viv = 0.8672, σ_GM = 0.4359.

**Results:** μ_V = 213.27, V\* = 204.39, Credit VaR = **8.88**

The simulation VaR is slightly lower than the analytical result because it yields an exact 99% quantile rather than a conservative discrete-grid estimate.

### Exercise 3 — Full Portfolio (17 Bonds, Fixed Recovery)

The simulation is extended to the full 17-bond portfolio from the data file, using constant recovery rates equal to each bond's mean value. Factor loadings β_{j,T}, β_{j,L}, β_{j,C} are read from the data file.

**Results:** μ_V = 1,744.71, V\* = 1,485.77, Credit VaR = **258.94** (≈ 15% of expected portfolio value)

### Exercise 4 — Full Portfolio (17 Bonds, Stochastic Recovery)

Recovery rates are modelled as Beta distributions parameterised by method of moments:

```
c_j = m_j(1−m_j)/s_j² − 1
α_j = m_j · c_j
β_j = (1−m_j) · c_j
```

**Results:** μ_V = 1,744.80, V\* = 1,459.52, Credit VaR = **285.28**

The increase of 26.34 relative to Exercise 3 arises from the compounding of joint default scenarios with low recovery realisations.

---

## Files

| File | Description |
|---|---|
| `credit-var.ipynb` | Full implementation: analytical VaR, two-bond MC, 17-bond MC with fixed and stochastic recovery |
| `credit-var-report.pdf` | Written report with derivations, results tables, and interpretation |

---

## Data

All numerical inputs (transition probability matrix, one-year forward zero rates, bond parameters, factor loadings, recovery rate statistics) are sourced from course handouts and provided in the notebook as hard-coded arrays. No external dataset is required.

---

*Group: Pietro De Bernardi (69791), Giammarco Ricciardilli (75040), Lucas Laussegger (73038)*
