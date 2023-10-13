function dwdt = integrating_function_noairresistance(t, w)
    mass =4.2;
    g=9.81;
%AUTHOR: Katie Scales,  Date: 14/12/2022
%SUMMARY: Sets up the ODE solver for a no air resistance situation
%Units used are SI - m, m/s, rad etc.
%INPUT Variables: 
    %t                - is the t span range linspace(0, 81, 81)
    %w                - is a 1x4 row vector of first order differential
    %                   equation variable (y, ydot, x, xdot)
    %mass             - Mass of the projectile in kg
    %g                - gravitational field strength in m/s^2

    %Define new variables
    y = w(1);
    ydot = w(2);
    x = w(3);
    xdot = w(4);

    %Define first order systems of ODE's
    dwdt = zeros(size(w));
    dwdt(1) = ydot; %this is ydot
    dwdt(2) = (-1*g);%This is ydotdot
    dwdt(3) = xdot; %this is xdot
    dwdt(4) = 0; %Gives xdotdot
end