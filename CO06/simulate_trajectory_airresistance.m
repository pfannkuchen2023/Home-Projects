function [TrajectoryOut] = simulate_trajectory_airresistance(g, InitialPosition, InitialVelocity, dt, DragForceConstant, mass, VarP)
%AUTHOR: Katie Scales,  Date: 14/12/2022
%SUMMARY: Simulate the trajectory of projectile from the coordinate (0,0)
%until it touches the ground again under the influence of gravity and drag 
%force using velocity verlets

%Units used are SI - m, m/s, rad etc.
%INPUT Variables:
    %g                - gravitational field strength set to be 9.81m/s^2
    %InitialPosition  - a 2 element vector that indicates the intial
    %                   position in a [x,y] plane
    %InitialVelocity  - a 2 element vector that indicates the initial
    %                   velocity in [x,y] components
    %dt               - indicates the steps in time we shall use for each
    %                   calculation
    %DragForceConstant- It is the result of 
    %                   0.5*drag coefficient * density* Area
    %Mass             - Mass of the projectile in kg
    %VarP             - Boolean condition if density of air should vary or
    %                   not
%OUTPUT Variables:
    %TrajectoryOut    - a Mx3 matrix with (current time, current x position, current y position)

    %Declare initial time, position, velocity, speed, and acceleration
    t = 0;
    r = InitialPosition;
    v = InitialVelocity;
    Force = total_force(InitialPosition, InitialVelocity, g, DragForceConstant, VarP, mass);
    a = Force/mass;

    %Input initial conditions into trajectory matrix
    TrajectoryOut(1,1) = t;
    TrajectoryOut(1,2) = InitialPosition(1);
    TrajectoryOut(1,2) = InitialPosition(2);
    %Set escape condition of while loop to be below ground level
    condition = false;
    while condition == false
        %Save the current time, position, velocity, speed, and acceleration
        t0 = t;
        r0=r;
        v0=v;
        a0=a;
        %Now find the new position
        t=t+dt;
        r = r0+v0*dt+0.5*a0*dt^2;
        %Find the new acceleration - we are using the velocity verlet
        %equation for this which only gives an approximation
        a = total_force(r, v+a0*dt, g, DragForceConstant, VarP, mass) / mass;
        v = v0 + 0.5*(a+a0)*dt;
        %Update the trajectory matrix
        TrajectoryOut(t+1, 1) = t;
        TrajectoryOut(t+1, 2) = r(1);
        TrajectoryOut(t+1, 3) = r(2);
        %Check condition
        if r(2) <0
            condition = true;
        end 
    end
end