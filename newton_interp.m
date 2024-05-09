function [coefficients] = newton_interp(x, y)
    n = length(x);
    D = zeros(n, n);
    D(:, 1) = y; % Assign y values to the first column of D
    
    for j = 2:n
        for i = 1:n-j+1
            D(i, j) = (D(i+1, j-1) - D(i, j-1)) / (x(i+j-1) - x(i)); % Calculate Newton's divided differences
        end
    end

    coefficients = D(1, :); % The coefficients of the interpolating polynomial

    % Construct the polynomial
    syms poly;
    poly = sym('1');
    for i = 1:n-1
        poly = poly * (poly - x(i));
        poly = poly + coefficients(i+1) * poly;
    end
    
    % Evaluate the polynomial at x = 0 and add the constant term
    result = subs(poly, x(1));
    result = result + coefficients(n);

    disp(result);
end
