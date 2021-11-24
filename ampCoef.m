function Amp = ampCoef(coef,NumArm);
%Función para calcular la amplitud de los coeficientes de Fourier para los
%armónicos dados
%Encabezado de Variables
syms n;
an=coef(2);
bn=coef(3);



for i=1:NumArm
    n = i;
    Amp1(i) = eval(sqrt(an^2+bn^2));
    b(i)=eval(bn);
    a(i)=eval(an);
    AmpCE(1,i)=(a(i)-j*b(i))/(2*i);
   
    syms n ;
end

Amp = [Amp1; a; b];


