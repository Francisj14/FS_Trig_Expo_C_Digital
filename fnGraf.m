function fn = fnGraf(v,f,div);

%Encabezado de Variables
[Fm Fn] = size(f); %Guarda el tamaño del vector de en la variables i y j
[Vm Vn] = size(v); %Guarda el tamaño del vector de en la variables m y n
T = v(Vn) - v(1); %calcula el periodo de la función
dx=T/div;
x1 = v(1):dx:v(Vn);
[Xm Xn] = size(x1);
syms t; %Declaración de la Variable 't' como simbólica

for p1=1:Vn-1 %Genera la función ingresada para un periodo
    for p=1:Xn
        if ((v(p1)<=x1(p)) && (x1(p)<=v(p1+1)))
            syms t;
            yt = f(p1)+t; %Esta variable t se agrega aquí y se elimina mas abajo.    
            t = x1(p);
            y(p) = eval(yt);
            y(p) = y(p)-t; %Operación necesaria para evaluación simbólica de constantes (eval() no recibe Double)
        end
    end
end
x0 = v(1)-T:dx:v(1);
x2 = v(Vn):dx:v(Vn)+T;    

x = [x0 x1 x2]; %Creación de datos para la función en tres periodos
y = [y y y]; 
fn = [x; y];
%fn(2,:) = y;
