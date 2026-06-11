* ===================================================================
* Name: Robinhood Case
* Author: Stefan Hauer (70427) Jan Kohring (65392)
* Date: September X, 2025
* ===================================================================

clear
clear matrix
cd "/Users/admin/Library/Mobile Documents/com~apple~CloudDocs/Nova SBE/Empirical Method for Finance/Assignment"

* Importing Data
use rh_daily, clear

* Task 1:
* We drop observations with negative or missing prices, then dates, and then create a distinct variable to summarize the output
drop if PRC <= 0 | PRC == .
drop if date == mdy(3, 2, 2020) | date == mdy(3, 3, 2020) | date == mdy(6, 18, 2020)
egen distinct_tickers = group(tic)
egen distinct_dates = group(date)
summarize

*Result: 3817 distinct_tickers and 545 distinct_dates

* Task 2:
* We generate the "year" variable and calculate summary statistics by year for the number of RH investors holding a stock. Afterwards we display the summary statistics table
gen year = year(date)

preserve
collapse (count) Obs = rh (mean) Mean = rh (sd) StdDev = rh (median) Median = rh, by(year)
list year Obs Mean StdDev Median
restore

* Task 3:
* Create number of observations per ticker
gen N = _N
bys tic: replace N = _N

* Check duplicates and unique dates
duplicates report tic date

* Compute average, median, minimum, and maximum number of observations
preserve
collapse (mean) Avg=N (median) Med=N (min) Min=N (max) Max=N
list
restore

* Why aren't all tickers observed? IPOs/Delsting, Merger, Missing Data, etc.

* Sprint (S) merged with T-Mobile in April 2020. After the merger, Sprint is no longer separately listed, so data ends before the dataset ends

* Task 4:
* We create a Market Cap variable and divide by 1,000 to get to millions of dollars
gen mktcapt = (PRC * SHROUT) / 1000

* Make sure  dataset is sorted and compute daily returns
sort tic date
bys tic: gen ret = (mktcapt- mktcapt[_n-1]) / mktcapt[_n-1]

* Compute dailys change in users and ratio of users compared to prior day
bys tic: gen userchg = (rh - rh[_n-1])
bys tic: gen userratio = rh / rh[_n-1]

* Drop missing returns
drop if missing(ret)

* Task 5:
* ....
gen abs_ret = abs(ret)
egen rank_ret = rank(-abs_ret), by(date)
gen topmover = (rank_ret <= 20) if !missing(abs_ret)

* Get old ordering (based on tic and date)
// sort tic date

* Fraction of postivie + negative returns
gen posret = (ret > 0)
tab posret if topmover==1

* Summary statistics
tabstat mktcap ret abs_ret userchg userratio, by(topmover) statistics(n mean sd median)

* Lag Topmover
bysort tic (date): gen lag_topmover = topmover[_n-1]
list if lag_topmover==1

* Regression #1
reg userchg lag_topmover

* Interpret coefficients
 // On average, if a stock was a top mover yesterday, it gains about 86 more investors today than if it wasn't a top mover.
 // On average, even without being a lagged top mover, a stock gains about 15 new RH users per day.
 
* Interpret statitical significance
// The p-value is 0.242, which is well above conventional thresholds (0.10, 0.05, 0.01). We fail to reject the null hypothesis. Thus, the effect is not statistically significant.

// The t-statistic is 1.17. For significance at the 5% level, we'd expect |t| ≥ 1.96. Since 1.17 < 1.96, the coefficient is not significantly different from zero.

// The 95% CI is [-58.1 ; 229.8]. Because the interval includes 0, we cannot rule out either a negative effect or a positive effect. Again, the coefficient is not statistically significant.

* Regression #2
reg userratio lag_topmover
 // If a stock was a top mover yesterday, its user ratio today is higher by 0.1855. So instead of ~1.0067, the average ratio is ~1.192. This corresponds to about a 19.2% increase in users compared to the prior day.
 // For stocks that were not top movers yesterday, the average user ratio is 1.0067. That means such stocks gain about 0.67% more users compared to the prior day.
 
* Regression #3
reg userchg lag_topmover mktcap

* Task 6
gen list = (date >= mdy(8,1,2019))
gen interaction = lag_topmover * list
reg userchg lag_topmover list interaction mktcap

/////////////////////////////////////////////////////
// !!!!!!!!!!! needs to be adjusted !!!!!!!!!!!!!!
////////////////////////////////////////////////////


* Task 7
// β̂₁ (lag_topmover): Effect of being a lagged top mover before the Top Movers list existed. Positive but not significant in your earlier runs (~104, p=0.155). Suggests that before the feature, being a top mover did not reliably increase user inflows.
// β̂₃ (interaction: lag_topmover × list): The incremental effect after Aug 1, 2019. [.....]
// Before the list (β̂₁), there was no significant effect of being a top mover. After the list introduction, the incremental effect (β̂₃) captures whether Robinhood's Top Movers feature drove additional inflows. If β̂₃ > 0 and significant, it supports the hypothesis that attention through the app caused higher trading activity.

* Task 8
// lag_topmover coefficient = 17.31, highly significant (t = 19.98, p < 0.001). On average, if a stock was a top mover yesterday, it gains ~17 more retail investors today. mktcap also strongly positive and significant: larger companies gain more investors

// For Robinhood investors, the effect of lag_topmover was much larger (~86–104 users) but statistically insignificant before the Top Movers list introduction.

// Traditional retail investors (non-Robinhood) show only a modest but significant reaction to top movers (~17 extra users). Robinhood users show a much stronger response once the Top Movers list feature was introduced in the app. This contrast suggests that the Top Movers list itself amplified investor attention and behavior on Robinhood, beyond what is observed among other retail investors using traditional brokers.








