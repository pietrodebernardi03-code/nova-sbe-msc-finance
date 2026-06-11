# Statistical Arbitrage: Pairs Trading Portfolio
**Hedge Funds · Nova SBE · Prof. Carlos Duarte D'Almeida**

---

## Overview

This project develops and backtests a systematic, market-neutral statistical arbitrage strategy based on pairs trading. The backtest spans January 2012 to March 2026, using a 65/35 in-sample/out-of-sample split. Six pairs from economically related industries are selected through a rigorous four-stage cointegration screening process and combined into an All-Star portfolio.

**All-Star Portfolio Results (OOS: March 2021 – March 2026)**

| Metric | Value |
|---|---|
| Net PnL | $7,562 |
| Annualised Return | 1.22% (unleveraged) |
| Annualised Volatility | 1.07% |
| Sharpe Ratio | **1.14** |
| Calmar Ratio | 4.69 |
| Maximum Drawdown | $1,611 (−1.34% of capital) |
| Total Trades | 132 |

---

## Methodology

### Pair Selection — Four-Stage Cointegration Screening

1. **Augmented Dickey-Fuller test** — confirms each price series is I(1) and each return series is I(0)
2. **Engle-Granger procedure** — tests for a stationary linear combination via OLS residual ADF; verified symmetrically by swapping the dependent variable
3. **Johansen trace test** — VECM-based test for at least one cointegrating vector (override rule: Johansen pass with non-trivial hedge ratio overrides a marginal Engle-Granger failure)
4. **Half-life filter** — AR(1) regression on the spread; pairs with half-life > 120 days are rejected as economically untradable

### Signal Generation

- Spread modelled as a Z-score using an **Exponentially Weighted Moving Average** (EWMA) to adapt to structural drifts
- Entry: |Z| > 1.5; Exit: Z = 0.0 (full mean reversion)
- Signals computed at close of day *t*, executed at open of day *t+1* (no look-ahead bias)

### Market Neutrality

Position sizes are adjusted beyond the cointegration hedge ratio using a **CAPM market-beta neutralisation**:

```
β_neutral = |β_long / β_short|    (clipped to [0.5, 2.0])
```

Rolling 252-day betas estimated against SPY.

### Risk Management

| Control | Specification |
|---|---|
| Volatility scaling | Target 10% annualised volatility per pair |
| Hard stop loss | Z-score reaches ±4.0 |
| Time stop | Position open > 1.5 × half-life |
| Circuit breaker | Per-pair drawdown > 25% of allocated capital |
| VIX filter | No new entries when VIX > 35 |
| Liquidity filter | Both legs must have 20-day avg volume > $500,000 |
| Gap filter | No entry if either leg opens with price jump > 3% |

### Transaction Costs

- Bid-ask spread + slippage: 8 bps total per leg
- Fixed commission: $1 per trade
- Borrow cost: 0.5% per year (short leg)
- Margin cost: 5% per year on deployed capital

---

## Selected Pairs

| Pair | Sector | OOS Sharpe | Win Rate | N Trades |
|---|---|---|---|---|
| KMB / CLX | Consumer Staples | 0.96 | 88% | 8 |
| MCD / YUM | Restaurants | 0.61 | 70% | 10 |
| HUM / CNC | Healthcare | 0.28 | 64% | 11 |
| HAL / SLB | Oil Services | 0.47 | 60% | 5 |
| XEL / WEC | Utilities | 0.47 | 67% | 15 |
| SLV / PSLV | Precious Metals ETFs | 0.29 | 62% | 16 |

---

## Files

| File | Description |
|---|---|
| `statistical-arbitrage.ipynb` | Full pipeline: cointegration screening, backtest engine, CAPM neutralisation, All-Star portfolio construction, sensitivity analysis, tear-sheet visualisations |
| `statistical-arbitrage-report.pdf` | Written report with strategy rationale, methodology, results, sensitivity analysis, and limitations |

---

## Data

All price data is downloaded programmatically via **Yahoo Finance** (`yfinance`). No proprietary data is required.

```python
pip install yfinance pandas numpy scipy statsmodels matplotlib
```

---

## Limitations

- **Survivorship bias**: the candidate universe consists of stocks with continuous histories from 2012 to 2026; delistings and bankruptcies are excluded
- **Fixed cost estimates**: bid-ask and slippage are modelled as constants and may understate true frictions during stress periods
- **VIX filter**: blocks new entries but does not force-close existing positions opened prior to a volatility spike
- **Structural break risk**: rolling Sharpe instability is structurally expected in mean-reversion strategies and is indistinguishable in real time from permanent cointegration breakdown

---

*Group: Pietro De Bernardi (69791), Diogo Rito Mota Pinto (75080), Lou Bervard (72649), Guilherme Natario Rio Tinto (73277)*
