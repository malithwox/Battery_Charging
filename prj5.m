
E  = .175;     % scaling factor

data = importdata('C:\Users\MALITHWOX\Desktop\edu windsor\sem 3\advanced energy storage\week8\code\meas.mat'); 

V = data.V; % voltage in V
I = data.I; % current in A
T = data.T; % time in Hr

idxc = find(I>=0);  % charge current
Ic = I(idxc);
Tc = T(idxc);
idxd = find(I<0);  %  discharge current
Id = I(idxd);
Td = T(idxd);

Cbatt_c = CoulombCount(Ic, Tc); % charge capacity
Cbatt_d = CoulombCount(Id, Td); % discharge capacity
Cbatt   = min(Cbatt_c, Cbatt_d); 

SOC = SOCcc(I, T, Cbatt, 1);

zs = SOC*(1-2*E) + E; % scaled value of the SOC


N       = length(V);
A_opv   = [ones(N,1) zs I];
kest = inv(A_opv'*A_opv)*(A_opv'*V); % LS estimate

R0est = kest(3);
k = kest(1:2);
OCV = k(1)*ones(length(zs),1)+k(2)*zs;

..................obtained from (18)
k0_1 = -9.081846;
k1_1 = 103.087009;
k2_1 = -18.184590;
k3_1 = 2.062476;
k4_1 = -0.101779;
k5_1 = -76.603691;
k6_1 =  141.199419;
k7_1 = -1.116841;

OCV_1 = k0_1*ones(length(zs),1) + k1_1*(1./zs) + k2_1*(1./(zs.^2)) + k3_1*(1./(zs.^3)) +...
    + k4_1*(1./(zs.^4)) + k5_1*(zs) + k6_1*(log(zs)) + k7_1*(log(1-zs)); 
.......................................


h=figure; hold on
plot(SOC,OCV,SOC,OCV_1)
%plot(SOC,V, 'linewidth', 2)
%plot(SOC,OCV, 'linewidth', 2)
legend({'combine3+ modeled Voltage', 'Linear modeled OCV'}, 'location', 'best')
set(gca, 'fontsize', 14)
grid on; box on
xlabel('SOC');
ylabel('Voltage (V)');
ylim([3.2 4.2]); xlim([0 1])

%filename = '../_figures/OCVmodel';
%print('-depsc', filename,h)

function C = CoulombCount(I, T)
% counts the absolute Coulombs
C = 0;
for i = 2:length(I)
    C = C + (T(i)-T(i-1))*abs(I(i));
end
end

function SOC = SOCcc(I, T, Cbatt, SOC0)
% SOC using the Coulomb Counting method
SOC = zeros(length(I),1);
SOC(1) = SOC0; % initial SOC
for i = 2:length(I)
    SOC(i) = SOC(i-1) + (T(i)-T(i-1))*(I(i))/(Cbatt);
end
end


%corelation coefficient wich is r2
%part c
%j=sum((OCV_1-OCV).^2)
%S=sum((OCV-mean(OCV)).^2)
%r=1-j/S
