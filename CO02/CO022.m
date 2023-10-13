%% MAIN
%Exercise 1
ex = 1;
disp("Exercise 1")
main(ex);
%Exercise 2
ex = 2;
disp("Exercise 2")
main(ex);
%% Main function
% Rotates through all X values and n values
function main(ex)
    for X = 0.2:0.2:1.0
        %for n is 1
        erf_rounded_1=sprintf('%.10f', erf_approx(X, 1, ex));
        disp("For X is " + X + " and n is 1: " + erf_rounded_1)
        %For n is 10
        erf_rounded_10=sprintf('%.10f', erf_approx(X, 10, ex));
        disp("For X is " + X + " and n is 10: " + erf_rounded_10)
        %For n is 100   
        erf_rounded_100=sprintf('%.10f', erf_approx(X, 100, ex));
        disp("For X is " + X + " and n is 100: " + erf_rounded_100)
        %The actual result
        if ex == 1
            actual_ans = sprintf('%.10f', erf(X));
        elseif ex == 2
            %syms t
            %actual_ans = int((exp(-1*(t.^2)))*((sin(100*pi*t)).^2), 0, X) * 2/sqrt(pi);
            actual_ans="UNKNOWN";
        end
        disp("For X is " + X + " the actual answer is: " + actual_ans)
        disp(" ")
    end
end

%% FUNCTION TO INTEGRATE
%The function we are integrating
function [result] = f(t, exercise_number)
    if exercise_number == 1
        result = exp(-1*(t.^2));
    elseif exercise_number ==2
        result = (exp(-1*(t.^2)))*((sin(100*pi*t)).^2);
    end
end
%% ERF_APPOX FUNCTION 
%Find the approximate erf using x and n values given
function [y] = erf_approx(x,n, ex)
    %Define the height h using x = nh
    h = x/n;
    %Perform the Simpson's rule equation
    y = (h/6)*(f(x, ex)+f(h*n, ex)+2*sum_function_one(1, n-1, h, ex)+4*sum_function_two(1, n, h, ex));
    y = (y * 2) / sqrt(pi);
end
%% FIRST SUM OF SIMPSON FUNCTION
%This performs the first summation function in the simpson equation
function [answer] = sum_function_one(start, fin, height, ex)
    answer = 0;
    for i = start:fin
        answer = answer + f(i*height, ex);
    end
end
%% SECOND SUM OF SIMPSON FUNCTION
%This performs the second summation function in the simpson equation
function[answer]=sum_function_two(start, fin, height, ex)
    answer = 0;
    for i = start:fin
        answer = answer + f(height*(i-0.5), ex);
    end 
end