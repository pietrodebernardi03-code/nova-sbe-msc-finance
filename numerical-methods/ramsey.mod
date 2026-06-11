// ramsey.mod  --  Question 1, Project
// Stochastic consumption-investment model (no depreciation)
// Numerical Methods for Economics and Finance, Nova SBE, A.A. 2025/2026
// Pietro De Bernardi (69791) -- Marco Aldrighetti (72475)

var       k, A, c;
varexo    epst;
parameters beta, alpha, rho, sd_e;

beta  = 0.8;
alpha = 0.5;
rho   = 0.95;
sd_e  = 0.005;

model;
    // Resource constraint:  c_t = A_t k_{t-1}^alpha - k_t
    c = A * k(-1)^alpha - k;
    // Euler equation:  1/c_t = beta * E_t [ alpha A_{t+1} k_t^(alpha-1) / c_{t+1} ]
    1/c = beta * ( alpha * A(+1) * k^(alpha-1) / c(+1) );
    // AR(1) productivity
    A = (1 - rho) + rho*A(-1) + epst;
end;

initval;
    k = 0.16;
    A = 1;
    c = 0.24;
end;

steady;
check;

shocks;
    var epst;  stderr sd_e;
end;

stoch_simul(irf=40, order=1);
