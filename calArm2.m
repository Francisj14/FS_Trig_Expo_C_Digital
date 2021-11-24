function arm = calArm2(coef,T,div,NumArm);
%Función que calcula numericamente los armónicos para la función
%se usa para la segunda parte del programa por FFT
%Encabezado de Variables
dx=T/div;
x1 = 0:dx:T; %Vectores numéricos para el dominio
x0 = -T:dx:0;
x2 = T:dx:2*T; 
x = [x0 x1 x2];
[Xfm Xfn] = size(x);

arm(1,:)=x;
for i=2:NumArm+1
    
    arm(i,:) =  coef(i-1)*cos(((i-1)*2*pi/(T)*x)); %Grafica de Armonicos sin angulo de desfase
    %arm(i,:) = Amp(i-1)*cos(((i-1)*2*pi/(v(Vn)-v(1))*x)-(atan(b(i-1)/a(i-1)))); %Función de Definición de Serie de Fourier
    %u=ones(1,Xfn);
    %funArm2 = funArm1+funArm2;
    %plot3(u*i,x,funArm1)
end    