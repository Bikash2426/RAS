% Transient Analysis of RAS system
% We considered all the estimated paramerts k,k2 and gamma as inputs to
% this program that take the system to a non-zero steady state.
% We calculated numerical solutions for each parameter input
% Then calulated stadard devation among renin and angII solution at each time point
% All the remaining parameters and intial condition remain same that set in
% all previous code.
clc
close all
clear 
CAT1=1.4*10^(-2); %s-1;
CAT2= 1.2*10^(-2) ; %s-1;
kMAP=(3*10^(10))/60;  %mmHG M-1 s-1
%input excel sheet of parameters
[NUM,TXT,RAW]=xlsread('parestimate_hypertension1_MAPrange.xls'); %change the file name as per requirement
par=NUM;
%................................
exp_no=length(par);
tspan=0:0.01:10000;
L=length(tspan);
y0=[1.7*10^(-2),2.06*10^(-13),2.7*10^(-7),2.1*10^(-8),4.1*10^(-8),2.1*10^(-6),100];% Initial conditions
%ensuring solution in the positive quadrant
for n=1:exp_no
    k=par(n,3);%reading from the estimated values of k's from the input file
    k2=par(n,4);%reading from the estimated values of k's from the input file
    gamma=par(n,5);%reading from the estimated values of k's from the input file
    %%%%%%%%
    [t,y]=ode45(@(t,y) simul_diffRAS(t,y,CAT1,CAT2,k,k2,kMAP,gamma),tspan, y0);
    sol{n}=y;
    %xlswrite([strcat('normal_transol',num2str(n)),'.xlsx'],y);
end
renin=zeros(L,exp_no);angII=zeros(L,exp_no);
for n=1:exp_no
    renin(:,n)=sol{n}(:,2);
    angII(:,n)=sol{n}(:,4);
end
std_renin=zeros(L,1);std_angII=zeros(L,1);
for i=1:L
std_renin(i)= std(renin(i,:)); 
std_angII(i)=std(angII(i,:));
end
xlswrite('std_renin_hypertension.xlsx',std_renin);
xlswrite('std_angII_hypertension.xlsx',std_angII);
mean_renin=zeros(L,1);mean_angII=zeros(L,1);
for i=1:L
mean_renin(i)= mean(renin(i,:)); 
mean_angII(i)=mean(angII(i,:));
end
xlswrite('mean_renin_hypertension.xlsx',mean_renin);
xlswrite('mean_angII_hypertension.xlsx',mean_angII);
    

