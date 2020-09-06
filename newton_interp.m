function [ D ] = newton_interp( x,y )
format shorteng
n = length(x);
D = zeros(n,n);
% put the y values in the matrix D of nxn dimention
for i=1:n 
    D(i,1) = y(i);
end
% with this i calculate the matrix. With this i can calculate the
% polynomial
for j=1:n
    for i=1:n
       if i+1 <= n & j+1 <= n & (i+j) <= n
           D(i,j+1) = (D(i+1,j) - D(i,j)) / (x(i+j) - x(i)); % D is the Newton's matrix
       end      
    end
end

V=1;
Z=zeros(n,n);
% sort each of the values according the degrees of the variable and then I
% put them in a new matrix Z
for i=1:n-1
        V = conv(V,poly(x(i)));
        ele_D = D(1,i+1);
        C = V*ele_D;
        L = length(C);
        cont = 0;
        for k=n:-1:L-n
            Z(i,k) = C(L-cont);
            cont = cont+1;
            if L-cont <= 0
                break
            end
        end
end
nZ = length(Z);
sum=0;
% I sum each column and store those values in a matrix Z

for j=1:nZ
    for i=1:nZ
        sum = Z(i,j) + sum;
    end
    res(j) = sum;
    sum = 0;
end
format shorteng
res(end) = D(1,1) + res(end);% sum the independent value
disp(res)
end

