# What Can We Learn from Option Prices?
**Derivatives (2218) · Nova SBE · Prof. Gustavo Freire**

---

## Overview

This project extracts market-implied information from Microsoft (MSFT) option prices across three interconnected analyses: implied volatility surface construction, risk-neutral density estimation via Breeden-Litzenberger, and discrete delta-hedging with quantified tracking errors. The underlying dataset covers MSFT options from November 2024 through February 2025, spanning the January 2025 earnings announcement.

MSFT was selected for its exceptional options liquidity (weekly expirations across many strikes), high information flow around Azure guidance and AI earnings releases, and deep two-sided institutional market ensuring reliable implied volatility data.

---

## Analyses

### 1 — Implied Volatility Surface

**Settlement date:** January 30, 2025 (post-earnings, peak volume; S = $415)

The IV surface is constructed across moneyness (K/S) and days to expiry. Key findings:

- The Black-Scholes assumption of constant σ is violated: the surface exhibits both a volatility smirk across moneyness and term structure variation across maturities
- OTM puts trade at higher IV than ITM calls, reflecting the premium investors pay to hedge left-tail risk
- Average IV and skew co-move in response to uncertainty shocks (December 2024, mid-January 2025), but **de-link around the earnings announcement**: only IV jumps while skew stays flat, capturing the symmetric uncertainty of earnings events where investors brace for both upside and downside

### 2 — Risk-Neutral Density (Breeden-Litzenberger)

**Dates compared:** January 30, 2025 vs. February 27, 2025 (same expiry: December 19, 2025)

**Methodology:**
- Fit a quadratic polynomial to IV as a function of moneyness K/S (rather than strike K) to avoid conditioning problems and reduce the impact of individual price errors on C''(K)
- Compute C(K) using Black-Scholes with the fitted IV
- Apply Breeden-Litzenberger to recover the risk-neutral density:

```
f^Q(K) = e^{rT} · ∂²C(K)/∂K²
```

**Results:**
- Date 1 (post-earnings): the implied RND is less right-skewed than the Black-Scholes lognormal, confirming that the market prices excess downside risk relative to the parametric model
- Date 2 (one month later): the smile flattens and the implied density converges toward lognormal, showing that the earnings shock has been absorbed into prices

### 3 — Delta-Hedging

**Option:** Near-ATM MSFT call, K = 425, ~28 days to expiry (ATM maximises gamma — the hardest case to hedge)

**Results:**

| Frequency | Final Error | % of Payoff | Interpretation |
|---|---|---|---|
| Daily | +$1.29 | +10.2% | Portfolio over-performs; trending rally causes delta over-accumulation |
| Weekly | −$1.24 | −9.1% | Portfolio under-performs; lagged rebalancing misses growing delta |

Payoff: $13.11 vs. premium paid of $8.125

**Error sources:** discrete gamma P&L (rebalancing intervals), volatility mismatch between entry IV and realised volatility, and Black-Scholes model risk. The results confirm that the optimal hedging frequency is interior — daily is not strictly better than weekly once transaction costs compound over ~20 round trips.

---

## Key Conclusions

1. **Options look forward:** unlike spot prices, option prices encode the market's risk-neutral distribution over future states — a forward-looking object that historical data cannot replicate
2. **Models are languages, not truths:** Black-Scholes is empirically rejected daily by volatility smiles, yet the industry quotes in BS units because it provides a common scale on which heterogeneous prices can be compared and traded
3. **No-arbitrage outlives the model:** Breeden-Litzenberger recovers the RND from market prices alone, showing that the no-arbitrage principle survives the failure of the parametric assumptions on which Black-Scholes itself depends
4. **The gap is information, not error:** the smile, the skew, and the hedging residuals are not Black-Scholes "failing" — they are the market revealing structure (jumps, stochastic volatility, risk premia) that the model deliberately abstracts away

---

## Files

| File | Description |
|---|---|
| `msft-options-analysis.ipynb` | Full implementation: IV surface construction, volatility smirk visualisation, IV level and skew time series, Breeden-Litzenberger RND estimation, delta-hedging simulation (daily and weekly) |
| `msft-options-analysis-slides.pdf` | Presentation slides with charts and findings |

---

## Data

The analysis uses an OptionMetrics dataset of MSFT option prices (clean prices, strikes, maturities, bid-ask) covering November 29, 2024 through February 27, 2025.

> **Note:** The OptionMetrics dataset is excluded from this repository as it is sourced under an institutional data licence. OptionMetrics access is available through university subscriptions (Nova SBE, WRDS). The notebook expects a CSV file with columns: `date`, `exdate`, `strike_price`, `best_bid`, `best_offer`, `cp_flag`, `impl_volatility`.

---
