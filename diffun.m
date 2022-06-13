%%% Here we solve the system of differential equations
function f = diffun(~,y,r)
%parameters values
KAGT=6.3*10^(-7);   % mol/L/s
hAGT=10*3600;            % s
Renin0=2.06*10^(-13);  % mol/L
hRenin=900 ;         % s
sRenin=(log(2)/hRenin)*Renin0;
kRenin=(6.44*10^(4)/3600);  % s-1
cRenin=1.7*10^(-14);        %s-1;
CAItoll= 6.7*10^(-3) ; %s-1;
Kf=(4.91*10^(-5))/(3600);  % s^-1
fa=5.04*10^(-7);   % mol/L
hANGI=0.62;    % s
hANGII= 18 ;    %s
hAT1R_ANGII=1.5; % s
hAT2R_ANGII=1.5 ; % s
ANGII0=21*10^(-9);  % mol/L
kMAP=(3*10^(10))/60;  %mmHG M-1 s-1
CAT1=1.4*10^(-2); %s-1;
CAT2= 1.2*10^(-2) ; %s-1;
% d[AGT]/DT
  f(1,1)=KAGT-cRenin*y(1)-(log(2)/hAGT)*y(1);   %y(1)=AGT
  % d[Renin]/dt
  
   f(2,1)=sRenin+Kf*(ANGII0-y(4))*(1-(ANGII0-y(4))/fa)-(log(2)/hRenin)*y(2)-r(2)*[y(5)*y(6)];  % y(2)=Renin
 % d[ANGI]/dt
  f(3,1)= cRenin*y(1)+kRenin*(y(2)-Renin0)-[CAItoll+log(2)/hANGI]*y(3);    %y(3)= ANGI
  
  %[dANGII]/dT
   f(4,1)=[CAItoll]*y(3)-[CAT1+CAT2+log(2)/hANGII]*y(4);    % y(4)=ANGII
  
   % d[AT1R-ANGII]/dt
   
   f(5,1)=CAT1*y(4)-(log(2)/hAT1R_ANGII)*y(5)-r(1)*y(6);    % y(5)= AT1R-ANGII
   
   % d[AT2R-ANGII]/dt
    f(6,1)=CAT2*y(4)-(log(2)/hAT2R_ANGII)*y(6);     % y(6)=AT2R-ANGII
  % dMAP/dt
  f(7,1)=kMAP*y(4)-r(3)*y(7);   %y(7)=MAP



end