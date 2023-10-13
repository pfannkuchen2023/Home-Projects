%% EXERCISE 1
exercise1()
%% Ex2: PART 1 - CUBIC
exercise2a()
%% Ex2: PART 2 - LINEAR
exercise2b()
%% PART 3 - LINEAR WITH ORIGINAL FUNCTION
exercise2c()
%% Finding the parameters A and B and rms
function[a_func,b_func,rms_func] = findABR(x_func, y_func)
    %Number of elements
    N = length(x_func);
    
    %Round to 0 to overcome rounding errors when MATLAB sums variables from x,
    %here it is rounded to 10dp
    summed_x = round(sum(x_func), 10);
    summed_y = round(sum(y_func), 10);
    
    %Sum the squares of x
    summed_x2 = sum(x_func.^2);
    
    %Sum of xy
    summed_xy = 0;
    for i = 1:N
        summed_xy = summed_xy + (x_func(i)*y_func(i));
    end

    %Create matrix X and Y and use to find A
    X = [N, summed_x; summed_x, summed_x2];
    Y = [summed_y; summed_xy];
    A = X\Y;
    a_func = A(1);
    b_func = A(2);
    
    %find the rms
    r_squared = 0;
    for j = 1:N
        r_squared = (y_func(i) - a_func - b_func*x_func(i)) + r_squared;
    end
    rms_func = sqrt(r_squared / N);

end   
%% Find the matrix with first column containing x values and second yerr
function [M] = polynomial_gen(n_func, m_func, coeff_func, e_func)
    %Generate the x values
    xvalues = linspace(-5,5,n_func);

    %create an array to store the y values from the polynomial equation for
    %each x
    ypoly = 1:n_func;

    %Rotate through each x term and find the corresponding y
    for i = 1:n_func
        y = 0;
        %If the order is m, there there are m+1 coefficients
        for j = 0:m_func
            y = y + coeff_func(j+1)*(xvalues(i).^(j));
        end
        ypoly(i) = y;
    end
    
    %Find the y + error value (yerr)
    yerr = 1:length(ypoly);
    for i = 1:length(ypoly)
        yerr(i) = ypoly(i) + e_func*randn;
    end
    
    %Return matrix of x and yerr values and for debugging purposes -ypoly
    %included (original y values for function)
    M = [xvalues; yerr;ypoly]';
end
%% Fit the polynomial of x and y-err
function [M] = poly_fit(x_func, y_func, m_func, n_func)
    
    %Create an "empty" matrix for x and fill with sums of x to the power of
    %something
    X = zeros(m_func+1, m_func+1);
    for i = 1:(m_func+1)
        for j = 1:(m_func+1)
            X(i,j) = round(sum(x_func.^(i+j-2)), 10);
        end 
    end

    %create a zero matrix for y to fill later
    Y = zeros(m_func+1, 1);
    for i = 1:(m_func+1)
        %Below acts as sum function at given element i
        total = 0;
        for k = 1:n_func
            total = total + (x_func(k).^(i-1))*(y_func(k));
        end
        Y(i) = total;
    end
    
    %Find the coefficient matrix by taking inverse
    M = X\Y;
end 
%% Function to call Exercise 1
function exercise1()
%%Import the data from linear.csv and store in array separe arrays
    data = readmatrix('linear.csv');
    x = data(:,1);
    y = data(:, 2);
    y_fit = data(:, 3);
    
    %Find the parameters a, b, rms
    [a, b, rms] = findABR(x, y);
    
    %Find y fit values from my formula
    y_fit_calc = 1:length(x);
    for i = 1:length(x)
        y_fit_calc(i) = a+b*x(i);
    end 
    y_fit_calc = y_fit_calc';
    
    %% Display results - exercise 1
    disp("EXERCISE 1")
    disp("----------------------------------------------------------------------------")
    disp("Values of X: ");
    disp(x);
    
    disp("Values of Y: ");
    disp(y);
    
    disp("Values of y fit from CSV: ");
    disp(y_fit);
    
    disp("Values of y fit from parameters a, b, rms: ");
    disp(y_fit_calc);
    
    disp("Value of a: " + a);
    disp("Value of b: " + b);
    disp("Value of rms: " + rms);
    disp("----------------------------------------------------------------------------")
    
    %% Plot the results - exercise 1
    figure(1)
    subplot(2,2,1)
    hold on
    title("Exercise 1")
    plot(x, y,'x', color='k')
    plot(x, y_fit, 'b')
    plot(x, y_fit_calc, 'r')
    legend("Data", "Fitted curve from csv", "Calculated fitted curve")
    xlabel("X")
    ylabel("Y")
    hold off

end
%% Function to call exercise 2.1
function exercise2a()
    %N value
    n = 100;
    
    %order value
    m = 3;
    %User Input
    %m = input("What is the order of the equation?");
    
    %Coefficient array
    coeff = [1.5,-2.5,0.7,-1.2];
    %User input
    % coeff = [1:m+1];
    % for z = 0:m
    %    coeff(z+1) = input("What is the coefficient for a"+z);
    % end
    
    %rms value
    e = 0.01;
    %User input:
    %e = input("What is the rms?");
    
    %call the function to fetch matrix of x, yerr
    A = polynomial_gen(n, m, coeff, e);
    x = A(:,1);
    yerr = A(:,2);
    
    %Code to check that the data is not same as actual poly y values
    %yact = A(:,3);
    %check = [yerr, yact]
    
    
    %Plot x-yerr
    subplot(2,2,2)
    hold on
    plot(x,yerr, "x")
    
    %find the fitted curve of x, yerr
    B = poly_fit(x, yerr, m, n);
    
    %Print out coefficients
    disp("EXERCISE 2 - CUBIC COEFFICIENTS")
    for i = 0: m
        disp("The coefficient a"+i+" is: "+B(i+1))
    end
    
    %find yerr_fit - i.e. find the corresponding fitted yerr for each x
    yerr_fit = zeros(length(yerr), 1);
    for i = 1:length(yerr)
        %Summation for polynomial
        yi = 0;
        for j = 0:m
            yi = yi+ B(j+1) * (x(i).^j);
        end
        yerr_fit(i) = yi;
    end
    
    %plot this fitted curve
    hold on
    plot(x,yerr_fit, "r")
    title("Exercise 2 - Cubic")
    xlabel("X")
    ylabel("Yerr")
    legend("X-Yerr data points", "Fitted polynomial for data")
    hold off


end
%% Function to call exercise 2.2
function exercise2b()
    %Length
    n=100;
    %Order
    m = 1;
    %Coefficient array
    coeff = [1.0,2.0];
    %rms value
    e = 1.0;
    %call the function to fetch matrix of x, yerr
    A = polynomial_gen(n, m, coeff, e);
    x = A(:,1);
    yerr = A(:,2);
    %Plot x-yerr
    subplot(2,2,3)
    hold on
    plot(x,yerr, "x")
    %find the fitted curve of x, yerr
    B = poly_fit(x, yerr, m, n);
    %Print out coefficients
    disp("-----------------------------------------------------------------------------------------")
    disp("EXERCISE 2 - LINEAR COEFFICIENTS")
    for i = 0: m
        disp("The coefficient a"+i+" is: "+B(i+1))
    end
    %find yerr_fit - i.e. find the corresponding fitted yerr for each x
    yerr_fit = zeros(length(yerr), 1);
    for i = 1:length(yerr)
        total = 0;
        for j = 0:m
            total = total+ B(j+1) * (x(i).^j);
        end
        yerr_fit(i) = total;
    end
    %plot this fitted curve
    plot(x,yerr_fit, "r")
    title("Exercise 2 - linear")
    xlabel("X")
    ylabel("Yerr")
    legend("X-Yerr data points", "Fitted polynomial for data")
    hold off
end
%% Function to call exercise 2.3
function exercise2c()
    %Length
    n=100;
    %Order
    m = 1;
    %Coefficient array
    coeff = [1.0, 2.0];
    %rms value
    e = 1.0;
    %call the function to fetch matrix of x, yerr
    A = polynomial_gen(n, m, coeff, e);
    x = A(:,1);
    yerr = A(:,2);
    %Plot x-yerr
    subplot(2,2,4)
    hold on
    plot(x,yerr, "x")
    %find the fitted curve of x, yerr
    [a,b,rms] = findABR(x, yerr);
    disp("-------------------------------------------------------------------------")
    disp("EXERCISE 2 - BACK TO ORIGINAL LINEAR")
    disp("The coefficient of a is: "+a)
    disp("The coefficient of b is: "+b)
    disp("The rms is: "+rms)
    %find yerr_fit - i.e. find the corresponding fitted yerr for each x
    yerr_fit = 1:length(x);
    for i = 1:length(x)
        yerr_fit(i) = a+b*x(i);
    end 
    yerr_fit = yerr_fit';
    
    %plot this fitted curve
    plot(x,yerr_fit, "r")
    title("Exercise 2 - linear original method")
    xlabel("X")
    ylabel("Yerr")
    legend("X-Yerr data points", "Fitted Linear for data")
    hold off

end