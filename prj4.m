
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

h=figure; hold on
plot(SOC,V, 'linewidth', 2)
plot(SOC,OCV, 'linewidth', 2)
legend({'Measured Voltage', 'Modeled OCV'}, 'location', 'best')
set(gca, 'fontsize', 14)
grid on; box on
xlabel('SOC');
ylabel('Voltage (V)');
ylim([3.2 4.2]); xlim([0 1])
title(['Estimated R_0 = ' num2str(R0est) '\Omega'])
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

