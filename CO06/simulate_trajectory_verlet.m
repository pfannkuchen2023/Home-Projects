function [TrajectoryOut] = simulate_trajectory_verlet(g, InitialPosition, InitialVelocity, dt)
%AUTHOR: Katie Scales,  Date: 14/12/2022
%SUMMARY: Simulate the trajectory of projectile from the coordinate (0,0)
%until it touches the ground again under the influence of gravity using
%velocity verlets
%Units used are SI - m, m/s, rad etc.
%INPUT Variables:
    %g                - gravitational field strength set to be 9.81m/s^2
    %InitialPosition - a 2 element vector that indicates the intial
    %                   position in a [x,y] plane
    %InitialVelocity  - a 2 element vector that indicates the initial
    %                   velocity in [x,y] components
    %dt               - indicates the steps in time we shall use for each
    %                   calculation
%OUTPUT Variables:
    %TrajectoryOut    - a Mx3 matrix with (current time, current x position, current y position) 
    
    %Define our initial velocity, acceleration, position, and time
    v = InitialVelocity;
    a = [0, -g];
    r = InitialPosition;
    t = 0;
    %Update the initial conditions into our trajectory matrix
    TrajectoryOut(1, 1) = t;
    TrajectoryOut(1, 2) = r(1);
    TrajectoryOut(1, 3) = r(2);

    %Now loop through each t+dt until we are below ground
    condition = false; %condition is that y < 0 i.e we are below ground
    while condition == false
        %This saves the current velocity, position and acceleration
        v0 = v; 
        r0 = r;
        a0 = a;
        %We then increment the time by dt
        t=dt+t;
        %We find the next velocity and position for t+dt time, here
        %acceleration is constant due to pre-assumed knowledge
        v = v + 0.5*(a+a);
        r = r + v0*dt+0.5*a*dt^2;
        %We update our trajectory out matrix
        TrajectoryOut(t+1, 1) = t;
        TrajectoryOut(t+1, 2) = r(1);
        TrajectoryOut(t+1, 3) = r(2);
        %Check to see if we are now below ground y<0 and if yes we exit
        %the while loop
        if r(2) <0
            condition = true;
        end 
    end

end