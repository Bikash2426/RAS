function f = simul_diffRAS(t,y,CAT1,CAT2,k,k2,kMAP,gamma )
%parameters known
KAGT=6.3*10^(-7);   % mol/L/s
hAGT=10*3600;            % s
Renin0=2.06*10^(-13);  % mol/L
hRenin=0.25*3600  ;         % s
sRenin=(log(2)/hRenin)*Renin0;
kRenin=(6.44*10^(4)/3600);  % s-1
cRenin=1.7*10^(-14);        %s-1;
CAItoll= 6.7*10^(-3) ; %s-1;
Kf=(4.91*10^(-5))/(3600);  % s^-1
fa=5.04*10^(2-9);   % mol/L

hANGI=0.62;    % s
hANGII= 18 ;    %s
hAT1R_ANGII=1.5; % s
hAT2R_ANGII=1.5 ; % s

ANGII0=21*10^(-9);  % mol/L


% dAGT/DT

  f(1,1)=KAGT-cRenin*y(1)-(log(2)/hAGT)*y(1);   %y(1)=AGT
  
  % dRenin/dt
  
   f(2,1)=sRenin+Kf*(ANGII0-y(4))*(1-(ANGII0-y(4))/fa)-(log(2)/hRenin)*y(2)-k2*[y(5)*y(6)];  % y(2)=Renin
 % d_ANGI/dt
  f(3,1)= cRenin*y(1)+kRenin*(y(2)-Renin0)-[CAItoll+log(2)/hANGI]*y(3);    %y(3)= ANGI
  
  %dANGII/DT
   f(4,1)=[CAItoll]*y(3)-[CAT1+CAT2+log(2)/hANGII]*y(4);    % y(4)=ANGII
  
   % d(AT1R-ANGII)/dt
   
   f(5,1)=CAT1*y(4)-(log(2)/hAT1R_ANGII)*y(5)-k*y(6);    % y(5)= AT1R-ANGII
   
   % d(AT2R-ANGII)
   
    f(6,1)=CAT2*y(4)-(log(2)/hAT2R_ANGII)*y(6);     % y(6)=AT2R-ANGII
   
   
  % dMAP/Dt
  f(7,1)=kMAP*y(4)-gamma*y(7);   %y(7)=MAP



end