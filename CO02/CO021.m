%Input for the bisections
z1 = 2;
z2 = 4;

%Calls bisection Method and display result
BisecAns = BisectionMeth(z1, z2);
format long;
disp("Root from bisection method is: ")
disp(BisecAns);

%Input for Newton Raphson
x_NewtRaph = 3;

%Call and display Newton Raphson
NewtonRaphsonAns = NewtonRaphsonMeth(x_NewtRaph);
disp("Root from Newton Raphson Method is: ")
disp(NewtonRaphsonAns);

%Find "actual" root via MatLab solver and display
fun = @MainEqu;
ActualAns = fzero(fun, 3);
disp("The actual root is: ")
disp(ActualAns);

%Bisection Method Function
function [root] = BisectionMeth(x1,x2)
    n=true;
    x3=0;
    %Repeat a suitable number of times
    while n == true
        x3_previous=x3;
        %Find x3
        x3 = (x1+x2)/2;
        %Find corresponding y values for x1 and x2 and x3
        y3 = MainEqu(x3);
        y1 = MainEqu(x1);

        %Check if x1 gives a positive or negative solution
        %Then check if x3 gives a positive or negative solution
        %Replace either x2 or x1 with x3 depending on outcome
        if y1<0
            if y3<0
                x1=x3;
            else
                x2=x3;
            end
        elseif y1 > 0
            if y3 <0
                x2=x3;
            else
                x1=x3;
            end
        end
        x3_previous_rounded=sprintf('%.10f', x3_previous);
        x3_rounded = sprintf('%.10f', x3);
        if x3_previous_rounded == x3_rounded
            n = false;
        end
    end
    %Assign root value as last x3 value
    root = x3;
end

%Newton Raphson Method Function
function [root] = NewtonRaphsonMeth(x)
    n=true;
    %Repeat an appropriate number of times 
    while n == true
        %Save Previous x
        x_previous = x;
        %Find the next x value using Newton Raphson formula
        x = x - (MainEqu(x) / DiffernEqu(x));
        %Check if appropriate
        x_previous_rounded = sprintf('%.10f', x_previous);
        x_rounded = sprintf('%.10f', x);
        if x_previous_rounded == x_rounded
            n = false;
        end
    end
    %Declare the root
    root = x;
end

%Main function
function [y] = MainEqu(x)
    y  = 3*exp(-x)-x+3;
end

%Differential of Function
function [y] = DiffernEqu(x)
    y = -3*exp(-x)-1;
end


