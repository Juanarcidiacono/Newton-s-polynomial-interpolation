clear;
format shorteng
disp('---- Diferencias divididas - Interpolacion de Newton ----');
x = input('Ingrese el vector x \n');
y = input('Ingrese el vector y \n');
n = length(x);
D = zeros(n,n);
%coloco valores de x e y en una matriz de nxn
for i=1:n 
    D(i,1) = y(i);
end
%calculo de dif.divididas
for j=1:n
    for i=1:n
       if i+1 <= n & j+1 <= n & (i+j) <= n
           D(i,j+1) = (D(i+1,j) - D(i,j)) / (x(i+j) - x(i)); %matriz de  difs.divs.
       end      
    end
end
disp('>>')
disp('Matriz de diferencias divididas >>')
disp(D)
V=1;
Z=zeros(n,n);
%ordeno cada uno de los terminos segun el orden y los pongo en una matriz Z
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
nz = length(Z);
sum=0;
%sumo por columna los elementos de la matriz Z y los pongo en una matriz
%sum
for j=1:nz
    for i=1:nz
        sum = Z(i,j) + sum;
    end
    res(j) = sum;
    sum = 0;
end
format shorteng
res(end) = D(1,1) + res(end);%sumo el valor del termino independiente
disp('Polinomio de interpolacion de Newton >>')
disp(res)   
disp('----------------------------------------------------------------------')
disp('NOTA:¡El polinomio ya esta desarrollado! El primer termino (empezando ')
disp('por la derecha) es el independiente, el que le sigue')
disp('es el coeficiente de x y asi sucesivamente.')