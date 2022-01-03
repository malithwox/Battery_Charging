
%OCV of the battery is not remined constant while the battery is being discharged. 
%OCV of the battery change when the battery is being discharged. 

%---------------------------------------------------------------------------
%Battery model parameters resistence & capacitance
R_0 = 0.2;
R_1 = 0.1;
C_1 = 2;
R_2 = 0.3;
C_2 = 5;
%---------------------------------------------------------------------------

%the following current load profile id over time is applied to the battery.
step = 0.01;
T = 0.01:step:4;
i = zeros(1,length(T));
for count = 1:length(T)
    r = rem(count,1/step);
    if(r<20 || r>40)
    i(count) = -40;
    else
       i(count) = -120; 
    end
end
%---------------------------------------------------------------------------

sum=0;
for a=1:length(T)
i_n=abs(i);
sum=((i_n(a)*10.^-3).*(0.01/3600))./1.2 + sum;
s(a)=0.6-sum;
end

% OCV parameters of battery according to the Combined+3 model
k0 = 3.757; 
k1 = -2.8*10^-3; 
k2 = 1.41*10^-5; 
k3 = -2.37*10^-8; 
k4 = 1.24*10^-11; 
k5 = 0.169; 
k6 = 59.8*10^-3; 
k7 = -63.7*10^-3;

%Plot OCV of the battery change when the battery is being discharged.
OCV = k0 + (k1./s) + (k2./s.^2) + (k3./s.^3) + (k4./s.^4) + (k5.*s) + (k6.*log(s)) + (k7.*log(1-s));
plot(s,OCV)
xlabel('SOC')
ylabel('OCV')
xlim([0.59995,0.6])


% Part 1 :- voltage v across the battery terminals under ideal battery
% model
V1 = OCV(1) + zeros(1,length(T));
figure; hold on
plot(T,V1,'LineWidth',2)

% Part 2 :- voltage v across the battery terminals under R-int model battery
% model
V2 = OCV + R_0*i*10^-3;
plot(T,V2,'LineWidth',2)


% Part 3 :- voltage v across the battery terminals 
%under RC model (assume R2,C2 are zero) model battery
alpha1 = exp(-step/(R_1*C_1));
i_1 = zeros(1,length(T));
 for k = 2:length(T)
 i_1(k) = alpha1*i_1(k-1) + (1-alpha1)*i(k-1);
 end
 V3 = OCV + R_0*i*10^-3 + i_1*R_1*10^-3;
 
plot(T,V3,'LineWidth',2)


% Part 4 :- voltage v across the battery terminals under 2RC model

alpha2 = exp(-step/(R_2*C_2));
i_2 = zeros(1,length(T));
 for k = 2:length(T)
 i_2(k) = alpha2*i_2(k-1) + (1-alpha2)*i(k-1);
 end
 V4 = OCV + R_0*i*10^-3 + i_1*R_1*10^-3 + i_2*R_2*10^-3;
 
plot(T,V4,'LineWidth',2)
xlabel('Time(s)')
ylabel('Voltage (V)')
box on; grid on
legend({'Ideal Case','Rint','RC','2RC'},'location', 'best')
set(gca, 'fontsize', 14)
