function [result] = stationary_plot(TrajectoryNoAirResistance,TrajectoryAirResistance, TrajectoryAirResistanceVarP, type)
%AUTHOR: Katie Scales,  Date: 14/12/2022
%SUMMARY: Creates a plot for the 3 trajectories we have found 
%Units used are SI - m, m/s, rad etc.
%INPUT Variables:
    %TrajectoryNoAirResistance - a matrix of all the time, x position, y position
    %                           for no air resistance
    %TrajectoryAirResistance - a matrix of all the time, x position, y position
    %                           for air resistance but constant air density
    %TrajectoryAirResistanceVarP - a matrix of all the time, x position, y position
    %                           for air resistance and variable air density
    %type                   - an integer 1 or 2, 1 if we are looking at
    %                         animation for velocity verlet and 2 if it was
    %                         solved with ODE
%OUTPUT Variables:
    %result - a string that reads success if the code below is completed

    %set corresponding conditions depending on the method of solving
    if type == 1 %verlet
        red = [0, 0, 1];
        blue = [1, 0, 0];
        green = [0 1 0];
        file="Verlet";
        name= " Velocity Verlet Solver";
        maximum = 2000;
    elseif type == 2 %ODE
        red = [0, 0.4470, 0.7410];
        blue = [0.6350, 0.0780, 0.1840];
        green = [0.4660, 0.6740, 0.1880];
        file = "ODE";
        name= " ODE Solver";
        maximum = 3000;
    end

    fh = figure();
    fh.WindowState="maximized";
    hold on
    %Plot the separate trajectories
    plot(TrajectoryNoAirResistance(:,2), TrajectoryNoAirResistance(:,3), "Color", blue); %shows the trajectory w/o air resistance
    plot(TrajectoryAirResistance(:,2), TrajectoryAirResistance(:,3), "Color", red); %shows the trajectory w/ air resistance
    %plot(TrajectoryAirResistanceVarP(:,2), TrajectoryAirResistanceVarP(:,3), "Color", green); %shows the trajectory w/ air resistance and variable P
    %Set limit so ground is ground
    ylim([0, maximum]);    
    
    %Tidy
    xlabel("Horizontal Distance/m");
    ylabel("Vertical Distance/m");
    title("Trajectory Using "+name)
    box on;
    grid on;
    grid minor;
    yline(0, "k")
    legend("Trajectory w/o air resistance","Trajectory w/ air resistance but no variable air density","Trajectory w/ air resistance and variable density")
    saveas(gcf, "PlotTrajectories"+file+".png")
    hold off
    result="success";
end 