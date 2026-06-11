// ramsey_dep.mod  --  Question 2, Project
// Consumption-investment model with depreciation delta
// Numerical Methods for Economics and Finance, Nova SBE, A.A. 2025/2026
// Pietro De Bernardi (69791) -- Marco Aldrighetti (72475)

var       k, A, c, x, y;
varexo    epst;
parameters beta, alpha, rho, sd_e, delta;

beta  = 0.8;
alpha = 0.5;
rho   = 0.95;
sd_e  = 0.005;
delta = 0.10;

model;
    // Production:  y_t = A_t k_{t-1}^alpha
    y = A * k(-1)^alpha;
    // Capital accumulation:  k_t = x_t + (1-delta) k_{t-1}
    k = x + (1 - delta) * k(-1);
    // Resource constraint:  c_t + x_t = y_t
    c + x = y;
    // Modified Euler equation:
    //   1/c_t = beta * E_t [ (alpha A_{t+1} k_t^(alpha-1) + (1-delta)) / c_{t+1} ]
    1/c = beta * ( ( alpha * A(+1) * k^(alpha-1) + (1 - delta) ) / c(+1) );
    // AR(1) productivity
    A = (1 - rho) + rho * A(-1) + epst;
end;

initval;
    k = 2.040816;
    A = 1;
    y = 1.428571;
    x = 0.204082;
    c = 1.224490;
end;

steady;
check;

shocks;
    var epst;  stderr sd_e;
end;

stoch_simul(irf=40, order=1);


//==========================================================================
// For Question 2(c): change the stoch_simul line above to:
//    stoch_simul(periods=500, irf=40, order=1);
// and append the plotting block below.
//==========================================================================

// figure;
// subplot(3,1,1);
// plot(oo_.endo_simul(3,:), 'b-', 'LineWidth', 0.9);  hold on;
// yline(1.224490, 'k--', 'LineWidth', 0.9);
// xlabel('Period t');  ylabel('c_t');  title('Consumption');  grid on;
//
// subplot(3,1,2);
// plot(oo_.endo_simul(4,:), 'r-', 'LineWidth', 0.9);  hold on;
// yline(0.204082, 'k--', 'LineWidth', 0.9);
// xlabel('Period t');  ylabel('x_t');  title('Investment');  grid on;
//
// subplot(3,1,3);
// plot(oo_.endo_simul(5,:), 'm-', 'LineWidth', 0.9);  hold on;
// yline(1.428571, 'k--', 'LineWidth', 0.9);
// xlabel('Period t');  ylabel('y_t');  title('Output');  grid on;
//
// sgtitle('Simulation of the Extended Model over T = 500 Periods');
