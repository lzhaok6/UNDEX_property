% ref: 
% Geers, T. L., & Hunter, K. S. (2002). An integrated wave-effects model for an underwater explosion bubble. The Journal of the Acoustical Society of America, 111(4), 1584?1601.
% http://50.16.225.63/v6.14/books/stm/default.htm
% This code is used to generate information for Abaqus Hunter-Geers model
% input
% Another reference would be: Wang, H., Zhu, X., Cheng, Y. S., & Liu, J. (2014). Experimental and numerical investigation of ship structure subjected to close-in underwater shock wave and following gas bubble pulse. Marine Structures, 39, 90?117.
 
switch 4
    case 1 %HBX-1
    A=0.15; %HBX-1
    B=0.29; %HBX-1
    rho=1.72*1000; %kg/m^3
    case 2 %TNT
    A=0.13; %A and B are constants
    B=0.23;
    rho=1.60*1000;
    K=52.4e6; %From Klenow thesis and Cole
    vc=1240; %From Hunter-Geers (2002)
    Kc=1045e6; %Kc and gamma are from Hunter-Geers (2002) table 2 
    gamma=1.30;
    case 3 %PETN
    rho=1.77*1000; %kg/m^3
    case 4 %RDX
    rho=1.82*1000; %kg/m^3    
end

mc=60*0.453592; %kg (60lb) mass of the charge material 
mPETN=26e-3; %kg
mRDX=43e-3; %kg
v=mPETN/(1.77*1000)+mRDX/(1.82*1000);
%v=mc/rho; %m^3 volume of the charge material  
ac=(3/4*v/pi)^(1/3);   %charge material radius
Tc=ac/vc; %differentiate from decay rate tau (From Hunter-Geers paper) 
%The shock wave decay to 10% of peak pressure at 3*Tc
%7Tc is used for initial condition of subsequent bubble oscillation
%the time for the shock to propagate to the boundary of the explosive
k=Tc/mc^(1/3)/(ac/mc^(1/3))^B; 
%reference: http://50.16.225.63/v6.14/books/stm/default.htm?startat=ch06s03ath147.html#stm-ldc-undexloads

% %Dr. Brown's equation for TNT 
% W=60; %lb  
% R=sqrt(20^2+(25-3)^2); %20ft standoff, 25ft depth
% P=21600*(W^(1/3)/R)^1.18*6894.76; %psi unit
%If 1.18 in the equation above is changed to 1.13, then the value would be
%almost the same with the equation below. 

% %Klenow's equation to calcualte TNT
% W=60*0.453592; %kg
% R=sqrt(6.096^2+(7.62-(0.9144+0.3048))^2); %m
% P=52.4e6*(R/W^(1/3))^(-1.13);   
% tau=W^(1/3)*0.084*(W^(1/3)/R)^(-0.23); %s




