function [Force] = total_force(r, v, g, DragForceConstant, VarP, mass)
%AUTHOR: Katie Scales,  Date: 14/12/2022
%SUMMARY: Find the total force acting on the projectile
%Units used are SI - m, m/s, rad etc.
%INPUT Variables:
    %g                - gravitational field strength set to be 9.81m/s^2
    %r                - a 2 element vector that indicates the current
    %                   position in a [x,y] plane
    %v                - a 2 element vector that indicates the current
    %                   velocity in [x,y] components
    %DragForceConstant- It is the result of 
    %                   0.5*drag coefficient * density* Area
    %VarP             - Boolean condition if density of air should vary or
    %                   not
    %mass             - scalar integer variable that is the mass of the
    %                   projectile
%OUTPUT Variables:
    %Force    - a 2 element matrix with force in (x,y) directions
    if VarP == true
        Force = g*mass - DragForceConstant*norm(v)*v*air_density_calculator(r(2));
    else if VarP == false
            Force = g*mass - DragForceConstant*norm(v)*v;
    end 
    
end