function solpts = RtoODE(r,tspan,y0)
L = length(tspan);
sol = ode45(@(t,y)diffun(t,y,r),tspan,y0);
solpts = deval(sol,tspan);
solpts = solpts(7,L-50:L); %just consider y(7)with last 50 points
end

