# Project — Stochastic Consumption-Investment Model
**Numerical Methods for Economics and Finance · Nova SBE · Prof. André Silva · 2025/26**

---

## Overview

This project solves two variants of the canonical Ramsey stochastic growth model using **Dynare** (first-order perturbation), derives analytical policy function coefficients, and simulates the model over 500 periods. The work covers impulse response analysis, linearised policy function interpretation, and real business cycle volatility rankings.

---

## Model Specification

**Question 1 — No Depreciation**

```
v(k_t, A_t) = max_{k_{t+1}} [ log(A_t k_t^α − k_{t+1}) + β E_t v(k_{t+1}, A_{t+1}) ]

A_{t+1} = (1−ρ) + ρ A_t + ε_{t+1},   ε ~ N(0, σ_ε²)
```

Parameters: β = 0.8, α = 0.5, ρ = 0.95, σ_ε = 0.005

**Steady state:** k_ss = (βα)^{1/(1−α)} = 0.16, c_ss = 0.24

**Linearised policy function:**

```
k_t = 0.16 + 0.50 (k_{t−1} − k_ss) + 0.152 (A_{t−1} − 1) + 0.16 ε_t
```

where a₁ = α = 0.5 is the stable Blanchard-Kahn eigenvalue, a₂ = k_ss · ρ = 0.152, and a₃ = k_ss = 0.16.

**Question 2 — With Depreciation (δ = 0.10)**

The modified Euler equation gains the undepreciated residual term:

```
1/c_t = β E_t [ (α A_{t+1} k_t^{α−1} + (1−δ)) / c_{t+1} ]
```

**Steady state:** k_ss ≈ 2.041, y_ss ≈ 1.429, x_ss ≈ 0.204, c_ss ≈ 1.225

**500-Period Simulation — Relative Volatility Rankings**

| Variable | σ (% of SS) |
|---|---|
| Investment x_t | **3.33%** |
| Output y_t | 2.18% |
| Consumption c_t | 2.10% |

Investment is the most volatile aggregate in relative terms (σ_x/σ_c ≈ 1.59), consistent with the standard RBC prediction. The single source of uncertainty (the productivity shock) drives visible co-movement across all three series.

---

## Files

| File | Description |
|---|---|
| `ramsey.mod` | Dynare mod file — Question 1: no depreciation model, IRFs, policy function |
| `ramsey-depreciation.mod` | Dynare mod file — Question 2: model with δ = 0.10, IRFs, 500-period simulation |
| `stochastic-growth-model-report.pdf` | Written report with derivations, Dynare output, IRF interpretation, and simulation statistics |

---

## Requirements

- **MATLAB** R2022a or later
- **Dynare** 6.x ([https://www.dynare.org](https://www.dynare.org))

Dynare must be added to the MATLAB path before running:

```matlab
addpath('/path/to/dynare/matlab')
dynare ramsey.mod
dynare ramsey-depreciation.mod
```

No external data files are required. All model parameters are hard-coded in the `.mod` files.

---

*Pietro De Bernardi (69791), Marco Aldrighetti (72475), Alessandro De Riccardis (72086)*
