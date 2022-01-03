# Battery_Charging
prj1
When a certain current load profile id over time is applied to the battery find the voltage v across the battery terminals under the following model assumptions. ( Ideal battery,R-int model,RC model,2RC model). (Assume that the OCV of the battery is constant)

prj2
Calculate OCV voltage & peak-power of a battery when OCV parameters are given according to the Combined model.

prj3
When a certain current load profile id over time is applied to the battery find the voltage v across the battery terminals under the following model assumptions. ( Ideal battery,R-int model,RC model,2RC model). (OCV of the battery is not remined constant while the battery is being discharged.)


means.mat
Measured voltage and current data. Voltage and current during charge and discharge at 25°C.


prj4(use means.mat)
The true SOC at time k can be recursively computed using the Coulomb counting equation:
A least square approach is used to estimate the simplest ECM parameters of a battery.

pj5(use means.mat)
a systematic approach to decide between the parameters of combined 3+ model and linear model OCV

prj6
open circuity voltage is given by the following model k0 + k1*zs + k2*(1./(zs.^1)) + k3*(1./(zs.^2))  + k4*(1./(zs.^3)) + k5*(1./(zs.^4)) + k6*(log(zs)) + k7*(log(1-zs));
It is required to charge the battery only up to 50% SOC.
Charging current is determined such that the battery can be charged the fastest.
Time it take to charge the battery according to the above specication.
