function [TrajectoryMatrix] = ode_solver(InitialPosition, InitialVelocity, DragForceConstant, mass, g, WhichFunction)
%AUTHOR: Katie Scales,  Date: 14/12/2022
%SUMMARY: Sets up the ODE solver
%Units used are SI - m, m/s, rad etc.
%INPUT Variables:
    %InitialPosition  - a 2 element vector that indicates the intial
    %                   position in a [x,y] plane
    %InitialVelocity  - a 2 element vector that indicates the initial
    %                   velocity in [x,y] components
    %DragForceConstant- It is the result of 
    %                   0.5*drag coefficient * density* Area
    %mass             - Mass of the projectile in kg
    %g                - gravitational field strength in m/s^2
    %WhichFunction    - Integer 1,2 or 3 that determines if it is going to
    %                   solve for no air resistance, air resistance or air 
    %                   resistance with a variable air density respectively

%OUTPUT Variables:
    %TrajectoryMatrix - 2 x M matrix t

    %NOTE: w = [y, ydot, x, xdot] - w is simply a 1 by 5 row vector
    tstart = 0;
    tend = 81;
    n = 81;
    tspan = linspace(tstart, tend, n);
    %define initial conditions
    winit = [InitialPosition(2),InitialVelocity(2), InitialPosition(1),InitialVelocity(1)];
    %Get w for the desired conditions
    if WhichFunction == 1
        [t, w]= ode45(@integrating_function_noairresistance, tspan, winit);
    elseif WhichFunction == 2
        [t, w]= ode45(@integrating_function_airresistanceNoVar, tspan, winit);
    elseif WhichFunction ==3
        [t, w]= ode45(@integrating_function_airresistanceVar, tspan, winit);
    end
    %Define output variables
    y = w(:, 1);
    ydot = w(:,2);
    x=w(:,3);
    xdot=w(:,4);
    
    TrajectoryMatrix = [t, x, y];

end