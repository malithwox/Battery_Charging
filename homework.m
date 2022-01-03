clc,clear;

T=0:0.015:60;
I=1.5*ones(length(T),1)';
Cbatt=1.5;



................
k0 = -9.081846;
k1 = -76.603691;
k2 = 103.087009;
k3 = -18.184590;
k4 = 2.062476;
k5 = -0.101779;
k6 =  141.199419;
k7 = -1.116841;

SOC=1;
epsilon = 0.175;
zs = SOC*(1-2*epsilon) + epsilon; % scaled value of the SOC
zs=zs';

OCV_max = k0*ones(length(zs),1) + k1*zs + k2*(1./(zs.^1)) + k3*(1./(zs.^2)) +...
    + k4*(1./(zs.^3)) + k5*(1./(zs.^4)) + k6*(log(zs)) + k7*(log(1-zs));

.....
    
SOC = SOCcc(I, T/60, Cbatt, 0);
%SOC=SOC'%./100;

epsilon = 0.175;
zs = SOC*(1-2*epsilon) + epsilon; % scaled value of the SOC
%zs=zs';

OCV = k0*ones(length(zs),1) + k1*zs + k2*(1./(zs.^1)) + k3*(1./(zs.^2)) +...
+ k4*(1./(zs.^3)) + k5*(1./(zs.^4)) + k6*(log(zs)) + k7*(log(1-zs)); 

V_t= OCV' + 0.2*I;
a=find(V_t<=OCV_max);
V_t=V_t(a);

...............

t=T(a);
i=I(a);
s=SOC(a);

subplot(2,2,1)
plot(t,V_t)
subplot(2,2,2)
plot(t,i)
subplot(2,2,3)
plot(t,s)

function SOC = SOCcc(I, T, Cbatt, SOC0)


% SOC using the Coulomb Counting method
SOC = zeros(length(I),1);  
SOC(1) = SOC0; % initial SOC
for i = 2:length(I)
  
    SOC(i) = SOC(i-1) + (T(i)-T(i-1))*(I(i))/(Cbatt);
end
end