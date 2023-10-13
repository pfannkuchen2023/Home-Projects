%%User input

%N value
n = 100;
%order value
m = input("What is the order of the equation?");
%Coefficient array
coeff = [1:m+1];
for z = 0:m
   coeff(z+1) = input("What is the coefficient for a"+z);
end
%rms value
e = input("What is the rms?");

%call the function to fetch matrix of x, yerr
A = polynomial_gen(n, m, coeff, e);
x = A(:,1);
yerr = A(:,2);

%Plot x-yerr
hold on
plot(x,yerr, "x")
%find the fitted curve of x, yerr
B = poly_fit(x, yerr, m, n)

%find yerr_fit - i.e. find the corresponding fitted yerr for each x
yerr_fit = zeros(length(yerr), 1);
for i = 1:length(yerr)
    yi = 0;
    for j = 0:m
        yi = yi+ B(j+1) * (x(i).^j);
    end
    yerr_fit(i) = yi;
end
%plot this fitted curve
plot(x,yerr_fit, "r")


%% Fit the polynomial of x and y-err
function [M] = poly_fit(x_func, y_func, m_func, n_func)
    %Create an "empty" matrix for x and fill with sums of x to the power of
    %something
    X = zeros(m_func+1, m_func+1);
    for i = 0:m_func
        for j = 0:m_func
            X(i+1,j+1) = round(sum(x_func.^(i+j)), 10);
        end
    end
    %create a zero matrix for y to fill later
    Y = zeros(m_func, 1);
    for k = 0:m_func
        total = 0;
        for p = 1:length(x_func)
            total = total + ((x_func(p)).^k)*y_func(p);
        end
        Y(k+1, 1) = total;
    end
    M = X\Y;
end 


%% Find the matrix with first column containing x values and second yerr
function [M] = polynomial_gen(n_func, m_func, coeff_func, e_func)
    %Generate the x values
    xvalues = linspace(-5,5,n_func);

    %create an array to store the y values from the polynomial equation for
    %each x
    curves = [1:n_func];

    %Rotate through each x term and find the corresponding y
    for i = 1:n_func
        y = 0;
        %If the order is m, there there are m+1 coefficients
        for j = 0:m_func
            y = y + coeff_func(j+1)*(xvalues(i).^(m_func));
        end
        curves(i) = y;
    end
    hold on
    %plot(xvalues, curves, "g")

    %Find the y err
    yerr = [1:length(curves)];
    for i = 1:length(curves)
        yerr(i) = curves(i) + e_func*randn;
    end

    %Return matrix of x and yerr values
    M = [xvalues; yerr]';
end