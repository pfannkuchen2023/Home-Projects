%NOTE: x axis is taken as the ground and y axis points what the
%observer views as up

%Important constants
%degrees to radians convertor
E = pi/180;
%gravitational field strength in m/s^2
g = 9.81;
%Gravitational field strength as a vector
gVector = [0, -g];
%Drag coefficient
Cd = 0.5;

%Initial conditions
%Initial position in the (x,y) plane in m
r0 = [0, 0];
%initial speed in m/s
s0 = 240; %240m/s for a mortar
%Angle of initial projection in rad - anticlockwise from positive x axis
pheta = 45 * E; %set at 45 degrees
%initial velocity as 2 element vector [vx,vy] in m/s
v0 = [s0 * cos(pheta), s0 * sin(pheta)];
%Delta time in s
dt = 1;
%Density of air in kg/m^3
density = 1.22;
%Mass of the projectile in kg
mass = 4.2; %4.2 kg for a mortar
%Diameter of the projectile in meters
diameter = 0.081; %0.081 for a mortar

%Finding the 0.5*Cd*density*Area part of the force of the constant
DragForceConstant = 0.5*Cd*density*pi*(diameter/2)^2;
%% Fetch our different trajectories
%Fetch our trajectory matrix in form (t, x, y)
TrajectoryEquation1 = simulate_trajectory(g, r0, v0, dt);
%Fetch our trajectory matrix in form (t, x, y)
TrajectoryVerlet = simulate_trajectory_verlet(g, r0, v0, dt);
TrajectoryODE = ode_solver(r0, v0, DragForceConstant, mass, g, 1);

%Fetch trajectory matrix for air resistance included
TrajectoryAirResistance = simulate_trajectory_airresistance(gVector, r0, v0, dt, DragForceConstant, mass, false);
TrajectoryAirResistanceODE = ode_solver(r0, v0, DragForceConstant, mass, g,2);

TrajectoryAirResistanceVarP = simulate_trajectory_airresistance(gVector, r0, v0, dt, DragForceConstant, mass, true);
TrajectoryAirResistanceVarPODE = ode_solver(r0, v0, DragForceConstant, mass, g,3);
%% Plot the data
result_plot = stationary_plot(TrajectoryVerlet, TrajectoryAirResistance, TrajectoryAirResistanceVarP, 1);
result_plot_ODE = stationary_plot(TrajectoryODE, TrajectoryAirResistanceODE,TrajectoryAirResistanceVarPODE, 2);

%% ANIMATTING THE PLOT
%Credit to https://towardsdatascience.com/how-to-animate-plots-in-matlab-fa42cf994f3e
result_animation = animated_plot(TrajectoryVerlet, TrajectoryAirResistance, TrajectoryAirResistanceVarP, 1);
result_animation_ODE = animated_plot(TrajectoryODE, TrajectoryAirResistanceODE, TrajectoryAirResistanceVarPODE, 2);
