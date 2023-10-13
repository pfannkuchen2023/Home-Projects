function [result] = animated_plot(TrajectoryNoAirResistance,TrajectoryAirResistance, TrajectoryAirResistanceVarP, type)
%AUTHOR: Katie Scales,  Date: 14/12/2022
%SUMMARY: Creates an animated plot for the 3 trajectories we have found 
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
    
    %Define new variables to plot
    t1 = TrajectoryNoAirResistance(:, 1);
    x1 = TrajectoryNoAirResistance(:,2);
    y1 = TrajectoryNoAirResistance(:,3);
    
    t2 = TrajectoryAirResistance(:, 1);
    x2 = TrajectoryAirResistance(:,2);
    y2 = TrajectoryAirResistance(:,3);
    
    t3 = TrajectoryAirResistanceVarP(:, 1);
    x3 = TrajectoryAirResistanceVarP(:,2);
    y3 = TrajectoryAirResistanceVarP(:,3);
    
    %set corresponding conditions depending on the method of solving
    if type == 1 %verlet
        red = [0, 0, 1];
        blue = [1, 0, 0];
        green = [0 1 0];
        file="Verlet";
        name= " velocity verlet solution ";
        maximum = 2000;
    elseif type == 2 %ODE
        red = [0, 0.4470, 0.7410];
        blue = [0.6350, 0.0780, 0.1840];
        green = [0.4660, 0.6740, 0.1880];
        file = "ODE";
        name= " ODE solution ";
        maximum = 3000;
    end 


    %Find which one has longest time
    t = max([length(t1), length(t2), length(t3)]);
    
    fh = figure();
    fh.WindowState="maximized";
    hold on
    box on
    grid minor
    %declare file we are saving to
    filename = "animation"+file+".gif";
    %Plot axis with no color
    plot(x1, y1, "Color", "None");
    %Plotting first iteration
    p1 = plot(x1(1), y1(1), "color", blue);
    m1 = scatter(x1(1), y1(1), "color", blue);
    p2 = plot(x2(1), y2(1), "color", red);
    m2 = scatter(x2(1), y2(1), "color", red);
    p3 = plot(x3(1), y3(1), "color", green);
    m3 = scatter(x3(1), y3(1), "color", green);
    %Set limit so ground is ground
    ylim([0, maximum]);
    title("Trajectory for"+name+"at time: " + "0");
    xlabel("Horizontal Distance/m");
    ylabel("Vertical Distance/m");
    
    legend([p1, p2, p3],"Trajectory w/o air resistance","Trajectory w/ air resistance but no variable air density","Trajectory w/ air resistance and variable density")
    
    %Iterate through length of time array
    for k = 1:t
        if k <= length(t1)
            %Update line
            p1.XData = x1(1:k);
            p1.YData = y1(1:k);
            %Update point
            m1.XData = x1(k);
            m1.YData = y1(k);
        end
        if k <= length(t2)
            p2.XData = x2(1:k);
            p2.YData = y2(1:k);
            %Update point
            m2.XData = x2(k);
            m2.YData = y2(k);
        end
        if k <= length(t3)
            p3.XData = x3(1:k);
            p3.YData = y3(1:k);
            %Update point
            m3.XData = x3(k);
            m3.YData = y3(k);
        end
        title("Trajectory for"+name+"at time: " + k+ "sec");
        %Delay
        pause(0.1);
        %Save the frame
        frame = getframe(gcf);
        im = frame2im(frame);
        [imind, cm] = rgb2ind(im, 256);
        if k == 1
            imwrite(imind, cm, filename, "gif", "Loopcount", inf, "DelayTime", 0.1);
        else
            imwrite(imind, cm, filename, "gif", "WriteMode", "append", "DelayTime", 0.1);
        end
    end 
    result="Success";
end