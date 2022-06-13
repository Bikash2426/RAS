clc
close all
clear 
% Model will be fitted against y(7)(MAP-variable in the ODE) only
%we need to estimate r= k, k2, and gamma
y0=[1.7*10^(-2),2.06*10^(-4),2.7*10^(-7),2.1*10^(-8),4.1*10^(-8),2.1*10^(-6),100];% initial conditions
tspan = 0:0.01:10000;% discritze time
L = length(tspan);
out=zeros(20,5);
%...............................................
% generating MAP values: normal 20 pts: 70-100; hypertension: 100-170;
% low-pressure: 40-70;
for i=1:20
    %map = linspace(70,100,20);%normal
    map=  linspace(101,190,20);%hyper-tension
    %map = linspace(40,69,20);%low blood pressure
xx= 0.01*rand(1,51)+map(i);%generating only 50 pts for model fitting mentioned in "RtoODE"
yvals2=xx;
%.................................................
r = optimvar('r',3,'LowerBound',0.0001,'UpperBound',25);% general range of all r's
myfcn2 = fcn2optimexpr(@RtoODE,r,tspan,y0);
obj2 = sum(sum((myfcn2 - yvals2).^2)); 
prob2 = optimproblem('Objective',obj2);
r0.r = [0.0110 0.5519 0.0039]; %initial guess of r0 that takes the system at a +ve steady state
[rsol2,sumsq2] = solve(prob2,r0);
disp('Sr.No. map sumsq2 k k2 gamma')
%printing the optimization outcome in a excel file
dd = [i map(i) sumsq2 rsol2.r(1) rsol2.r(2) rsol2.r(3)]
out(i,1)=map(i);out(i,2)=sumsq2;out(i,3)=rsol2.r(1);
out(i,4)=rsol2.r(2);out(i,5)=rsol2.r(3);
end 
%.....................................................  
xlswrite('parestimate_hypertension1_MAPrange.xls',out); % store estimate values


