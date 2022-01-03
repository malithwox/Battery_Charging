%OCV parameters of a Samsung Galaxy S4 battery, according to the Combined model
k0 = 3.84; 
k1 = 1.06*10^-4; 
k2 = 6.42*10^-3; 
k3 = 0.1056; 
k4 = -69.8*10^-3; 

% Part 1
s = 0.6;%SOC of the battery is 60%
OCV = k0 + (k1/s) + (k2*s) + (k3*log(s)) + (k4*log(1-s));

% Part 2
R0 = 0.2;%battery has internal impedance of R0 = 0.2;
s = 0.01;
Vmin = k0 + (k1/s) + (k2*s) + (k3*log(s)) + (k4*log(1-s));
P_Out = Vmin *( (OCV-Vmin) / R0); %the available peak-power in the battery

% Part 3
Cbatt = 1.2;%battery capacity is 1:2 Ah.
s = 0.6;
s = s - (0.3/1.2);%load which drew 300 mA constant current for 1 hour.
OCV = k0 + (k1/s) + (k2*s) + (k3*log(s)) + (k4*log(1-s));
P_Out = Vmin *( (OCV-Vmin) / R0);%available peak-power in the battery

%Part 4
s = 0.99;% battery is completely full
OCV = k0 + (k1/s) + (k2*s) + (k3*log(s)) + (k4*log(1-s))

%Part 5
s = 0:.0001:1; % create SOC values spanning [0 1]
epsilon = 0.175;
zs = s*(1-2*epsilon) + epsilon; % scaled value of the SOC
zs = zs';

OCV = k0 + (k1/zs) + (k2*zs) + (k3*log(zs)) + (k4*log(1-zs));

plot(s,OCV)
xlabel('SOC')
ylabel('OCV')
