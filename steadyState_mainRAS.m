% RAS program for estimating unknown 3-parameters
% three unknown parameters: k, k2 and gamma
% setting these three parameters such that the RAS is always
% remain positive, reach to a stady-state
clc
close all
clear 
CAT1=1.4*10^(-2); %s-1;
CAT2= 1.2*10^(-2) ; %s-1;
kMAP=(3*10^(10))/60;  %mmHG M-1 s-1
%reading the PARAMETERS file generated using optimization and model fit
%teachniques
[NUM,TXT,RAW]=xlsread('parestimate_hypertension1_MAPrange.xls'); %change the file name as per requirement
par=NUM;
steady_state=zeros(20,7);%output files of steady states corresponding to k, k2 and gamma.
%................................
exp_no=20;
tspan=0:0.01:10000;
L=length(tspan);
y0=[1.7*10^(-2),2.06*10^(-4),2.7*10^(-7),2.1*10^(-8),4.1*10^(-8),2.1*10^(-6),100];% initial conditions of differential equations
%ensuring solution in the positive quadrant
for n=1:exp_no
    k=par(n,3);%reading from the estimated values of k's from the input file
    k2=par(n,4);%reading from the estimated values of k's from the input file
    pos=0;%positivity index in the program
    gamma=par(n,5);%reading from the estimated values of k's from the input file
    [t,y]=ode45(@(t,y) simul_diffRAS(t,y,CAT1,CAT2,k,k2,kMAP,gamma),tspan, y0);
    for i=1:L
        for j=1:7
            if (y(i,j)>0)
                pos=pos+1;
            else 
                pos=0;
            end
        end
    end
    if pos==L*7
        disp('system is in +ve quad')
    else  
        disp('continue experiment to ensure the system in +ve quad:')
        n
    end

%%..................................................................
%taking the system to a steady state
if pos==L*7
        esp=0.5;%staedy errors
        state_ind=0;
        for i=1:7
            for m=1:10 % it is for testing 10 consequitive numbers of each col
            if abs(y(L-11+m,i)-y(L-11+m+1,i))< esp
                %if y(k,7)>69 && y(k,7)<101
                state_ind=(state_ind+1);
                else
                state_ind=0;
                %end
            end
            end
        end
        if state_ind==70
            disp('system is in steady state')
            %disp('MAP is in the reqired range 70-100\n')
            steady_state(n,1)=y(L,1);steady_state(n,2)=y(L,2);
            steady_state(n,3)=y(L,3);steady_state(n,4)=y(L,4);
            steady_state(n,5)=y(L,5);steady_state(n,6)=y(L,6);
            steady_state(n,7)=y(L,7);
            
        else
            disp('system in NOT in steady state:')
            n
            break
        end
        
 end
end
xlswrite('SteadyState_hypertension1.xls',steady_state);
                
    

