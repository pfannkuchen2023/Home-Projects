function [DensityDivP0] = air_density_calculator(y)
%AUTHOR: Katie Scales,  Date: 14/12/2022
%SUMMARY: Find the air density at a given height y for a given isothermal
%         scale length
%Units used are SI - m, m/s, rad etc.
%INPUT Variables:
    %y      - the current position above ground
%OUTPUT Variables:
    %exp(-y/y0) - the current density at y in kg/m^3 divided by p0 where:
    %p0 is the density of air at y = 0, temperature 15C and standard atmospheric pressure
    %Define the isothermal scale length of atmosphere
    y0 = 8.42*10^3; 
    DensityDivP0 = exp(-y/y0);
end