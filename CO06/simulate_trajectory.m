function [TrajectoryOut] = simulate_trajectory(g, InitialPosition, InitialVelocity, dt)
%AUTHOR: Katie Scales,  Date: 14/12/2022
%SUMMARY: Simulate the trajectory of projectile from the coordinate (0,0)
%until it touches the ground again under the influence of gravity using
%equation 1
%Units used are SI - m, m/s, rad etc.
%INPUT Variables:
    %g                - gravitational field strength set to be 9.81m/s^2
    %InitialPosition  - a 2 element vector that indicates the intial
    %                   position in a [x,y] plane
    %InitialVelocity  - a 2 element vector that indicates the initial
    %                   velocity in [x,y] components
    %dt               - indicates the steps in time we shall use for each
    %                   calculation
%OUTPUT Variables:
    %TrajectoryOut    - a Mx3 matrix with (current time, current x position, current y position) 

%------------------------------------------------------------------------
%ORIGINAL TEST OF FUNCTION
    %    %Find the x position for time dt
    %    for t = 0:dt:100 % t is the current time
    %        TrajectoryOut(t+1, 1) = t;
    %        TrajectoryOut(t+1,2) = InitialVelocity(1) * t + InitialPosition(1); %gives the x position at time t
    %        TrajectoryOut(t+1,3) = InitialVelocity(2)*t - (g*(t^2))/2 + InitialPosition(2); % gives the y position at time t
    %    end
%-----------------------------------------------------------------------

    %initial time is 0s
    t=0; %this variable keeps track of current time in s
    condition = false; %the condition is that y < 0 
    while condition == false 
        x = InitialVelocity(1) * t + InitialPosition(1); %gives the x position at time t
        y = InitialVelocity(2)*t - (g*(t^2))/2 + InitialPosition(2); % gives the y position at time t
        %check our condition i.e. does this value of t give us a y below
        %ground level?
        if y < 0 %yes
            condition = true; %exit while loop and add calculated t, x, y, 
                              %values into TrajectoryOut matrix
                              %This is to see where it crosses the x axis
                              %again
        end
        %update TrajectoryOut matrix and repeat
        TrajectoryOut(t+1, 1) = t;
        TrajectoryOut(t+1, 2) = x;
        TrajectoryOut(t+1, 3) = y;
        %update the t value
        t=t+dt;       
    end 
end