function Coef = calCoef(v,f);
%Esta función calcula simbolicamente los Coeficientes de la serie de
%fourier con el fin de mostrarlos como fórmulas en el formulario gráfico
%Encabezado de Variables
[Fm Fn] = size(f); %Guarda el tamaño del vector de en la variables i y j
[Vm Vn] = size(v); %Guarda el tamaño del vector de en la variables m y n
syms t; %Declaración de la Variable 't' como simbólica
syms n;
piS=sym(pi)
a0=0;
for p1=1:Vn-1 %Calculo del coeficiente a0 de fourier
    if p1 == 1
        a0=int(f(p1)*t^0,v(p1),v(p1+1)); %Realiza la integral definida para cada unos de los intervalos de la función de entrada
        %t^0 se agrega para poder evaluar la integral en caso que no haya
        %variables en la función. Solución a limitantes del toolbox
        %simbólico de matlab
    elseif p1 >1
        a0=int(f(p1)*t^0,v(p1),v(p1+1))+a0; %Realiza los integrales para todos los intervalos
    end
end 
a0=a0*(2/(v(Vn)-v(1)));

for p1=1:Vn-1 %Calculo del coeficiente an de fourier
    %Realiza la integral definida para cada unos de los intervalos de la
    %función de entrada
    if p1 == 1
        %an = int(f(p1)*(2/(sym(v(Vn))-sym(v(1))))*cos((2*n*piS)*t/(sym(v(Vn))-sym(v(1)))),t,v(p1),v(p1+1))
        an = int(f(p1)*cos((2*n*pi)*t/(v(Vn)-v(1))),t,v(p1),v(p1+1));
    elseif p1 >1
        an = int(f(p1)*cos((2*n*piS*t)/(v(Vn)-v(1))),t,v(p1),v(p1+1))+an; %Realiza los integrales para todos los intervalos
    end
end
an = an*(2/(v(Vn)-v(1))); %Termino externo a la integral, en la definición del coeficiente an

for p1=1:Vn-1 %Calculo del coeficiente bn de fourier
    if p1 == 1
        bn =  int(f(p1)*sin((2*n*pi)*t/(v(Vn)-v(1))),t,v(p1),v(p1+1));%Realiza la integral definida para cada unos de los intervalos de la función de entrada *(2/(sym(v(Vn))-sym(v(1))))*sin((2*n*piS)
    elseif p1 >1
        bn = int(f(p1)*sin((2*n*pi*t)/(v(Vn)-v(1))),t,v(p1),v(p1+1))+ bn; %Realiza los integrales para todos los intervalos
    end
end 

bn = bn*(2/(v(Vn)-v(1)));

Coef = [a0 an bn];
size(Coef)