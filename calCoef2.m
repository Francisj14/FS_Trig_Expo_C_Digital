function Coef = calCoef(v,f);
syms t real; %Declaración de la Variable 't' como simbólica
syms n integer;
f=sym(f);
P=max(v)-min(v);
wo=2*pi/(P);
a0=0;
for i=1:length(f)
    a0=a0+int(f(i),'t',v(i),v(i+1));
end
a0=simplify(a0/P);

an=0;
for i=1:length(f)
    an=an+int(f(i)*cos(n*wo*t),v(i),v(i+1));
end
an=simplify(2*an/P);

bn=0;

for i=1:length(f)
    bn=bn+int(f(i)*sin(n*wo*t),v(i),v(i+1));
end
bn=simplify(2*bn/P);




Coef = [a0 an bn];
size(Coef);