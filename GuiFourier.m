function varargout = GuiFourier(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GuiFourier_OpeningFcn, ...
                   'gui_OutputFcn',  @GuiFourier_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before GuiFourier is made visible.
function GuiFourier_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GuiFourier (see VARARGIN)

% Choose default command line output for GuiFourier
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GuiFourier wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GuiFourier_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function vector_Callback(hObject, eventdata, handles)
% hObject    handle to vector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of vector as text
%        str2double(get(hObject,'String')) returns contents of vector as a double


% --- Executes during object creation, after setting all properties.
function vector_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function funcion_Callback(hObject, eventdata, handles)
% hObject    handle to funcion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of funcion as text
%        str2double(get(hObject,'String')) returns contents of funcion as a double


% --- Executes during object creation, after setting all properties.
function funcion_CreateFcn(hObject, eventdata, handles)
% hObject    handle to funcion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in botonGrafica.
function botonGrafica_Callback(hObject, eventdata, handles)
% hObject    handle to botonGrafica (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
syms t;
v=get(handles.vector,'String');
f=get(handles.funcion,'String');
NumArm=get(handles.numArm,'String');
NumArm=str2num(NumArm);
div = 20*NumArm; %Calcula cuanto puntos habrá por periodo
%v=str2num(v)
set(handles.vSalida,'String',v)
set(handles.fSalida,'String',f)
v=str2num(v);
f=str2sym(f)
[VVnv VVmv]=size(v);
[VVnf VVmf]=size(f);



if (VVmv == VVmf+1)
    fn = fnGraf(v,f,div);
    handles.g1=plot(handles.grafTiempo,fn(1,:),fn(2,:))
    set(handles.grafTiempo, 'XGrid','on','YGrid','on') %FUNCION PARA ACTIVAR GRIDS
    xlabel(handles.grafTiempo,'Tiempo') %Etiquetas en X y Y
    ylabel(handles.grafTiempo,'Amplitud')
    title(handles.grafTiempo,'Señal en el Tiempo')
else
    msgbox('El tamaño de los vectores no corresponde para una función periodica','Error!!','Error');
end



% --- Executes on button press in botonCalcula.


function botonCalcula_Callback(hObject, eventdata, handles)
% hObject    handle to botonCalcula (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

toolBos = get(handles.ToolS, 'Value');

if toolBos ==1 %El usuario debe Verificar la condición de uqe tenga el ToolBox simbolico de matlab instalado
    syms t;
    %NumArm = 6;
    v=get(handles.vector,'String');
    f=get(handles.funcion,'String');
    NumArm=get(handles.numArm,'String');
    NumArm=str2num(NumArm);
    colores = ['y' 'm' 'c' 'r' 'g' 'b' 'c' 'k'] %Colores Primarios
    v=str2num(v);
    f=str2sym(f);
    div=20*NumArm; %Calcula cuanto puntos habrá por periodo
    coefFou = calCoef2(v,f); %Función para calcular las ecuaciones simbólicas de los coeficientes de Fourier
    AmpCoef = ampCoef(coefFou,NumArm); %Función para calcular la amplitud de los coeficientes de Fourier para los armónicos dados
    
    cn=(coefFou(2)-j*coefFou(3))/2;
    D0=abs(coefFou(1,1))*2;
    %title(handles.grafArmonicos,['$' 'a_0=',latex(coefFou(1)),'/','a_n=',latex(coefFou(2)),'/','b_n=',latex(coefFou(3)) '$'],'interpreter','latex','Color','b','FontSize',14); % CAMBIAR COLOR FUNCION Instrucción para mostrar ecuaciones coeficientes de Fourier
    %my_text = '$$f_n={x \over \sqrt{2}}$$';
    title(handles.coefAo,['$' 'a_0=',latex(2*coefFou(1)) '$'],'interpreter','latex','FontSize',16); %CALCULO DE COEFICIENTES Y PRESENTACIÓN
    title(handles.coefAn,['$' 'a_n=',latex(coefFou(2)) '$'],'interpreter','latex','FontSize',16);
    title(handles.coefBn,['$' 'b_n=',latex(coefFou(3)) '$'],'interpreter','latex','FontSize',16);
   
    %title(handles.EcuacionExp,['$' 'f(t)= \sum_{n=-\infty}^{\infty}',latex(coefFou(3)),'*\e^(-j2pint/T)', '$'],'interpreter','latex','FontSize',16);
    title(handles.EcuacionExp,['$' 'f(t)= ',latex(D0),' + \sum_{n=\infty}^{\infty}',latex(cn),'e^{j2pint/T}', '$'],'interpreter','latex','FontSize',16);
    
       
    
        if coefFou(1)==0
            if coefFou(2)==0
                 title(handles.Ecuacion,['$' 'f(t)= \sum_{n=1}^{\infty}',latex(coefFou(3)),'*\sin(tn)', '$'],'interpreter','latex','FontSize',16);
            elseif coefFou(3)==0
                 title(handles.Ecuacion,['$' 'f(t)= \sum_{n=1}^{\infty}',latex(coefFou(2)) ,'*\cos(tn) ','$'],'interpreter','latex','FontSize',16);
            else
                 title(handles.Ecuacion,['$' 'f(t)= \sum_{n=1}^{\infty}',latex(coefFou(2)) ,'*\cos(tn) +',latex(coefFou(3)),'*\sin(tn)', '$'],'interpreter','latex','FontSize',16);
            end
        else
            if coefFou(2)==0
                 title(handles.Ecuacion,['$' 'f(t)=',latex(coefFou(1)),' + \sum_{n=1}^{\infty}',latex(coefFou(3)),'*\sin(tn)', '$'],'interpreter','latex','FontSize',16);
            elseif coefFou(3)==0
                 title(handles.Ecuacion,['$' 'f(t)=',latex(coefFou(1)),'+ \sum_{n=1}^{\infty}',latex(coefFou(2)) ,'*\cos(tn) ','$'],'interpreter','latex','FontSize',16);
            else
                 title(handles.Ecuacion,['$' 'f(t)=',latex(coefFou(1)),'+ \sum_{n=1}^{\infty}',latex(coefFou(2)) ,'*\cos(tn) +',latex(coefFou(3)),'*\sin(tn)', '$'],'interpreter','latex','FontSize',16);
            end
           
        end
      
    
    armonicosN = calArm(AmpCoef,f,v,div,NumArm);%armonicosN es una matriz cuya primera fila es el dominio en el tiempo, y las siguientes filas son los armónicos
    sumArm = 0;
    [Xfm Xfn] = size(armonicosN);
    u=ones(1,Xfn); %Matriz de unos del tamaño del dominio del tiempo}
    
    
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%INICIO GRAFICAS 3D DIBUJADAS PASO A PASO%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i=2:NumArm+1 %Sumatoria de la Serie de Fourier
        sumArm = armonicosN(i,:)+sumArm; 
        handles.g3=plot3(handles.grafAmplitud,u*(i-1),armonicosN(1,:),sumArm); %Se gráfica la serie de fourier numérica
        handles.g2=stem(handles.grafArmonicos,i-1,AmpCoef(1,i-1)); %Gráfica la amplitud para cada armónico
        hold(handles.grafAmplitud,'on');   %Mantener la gráfica mientras se grafica la siguiente
        hold(handles.grafArmonicos,'on');
        if (i==2) %Se hace una sola vez el set de titulos y propiedades. 
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%INCIO TITULOS Y PROPIEDADES DE LOS PLOTS%%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            set(handles.grafArmonicos, 'XGrid','on','YGrid','on') %FUNCION PARA ACTIVAR GRIDS 
            title(handles.grafArmonicos,'Amplitud de Coeficientes')
            ylabel(handles.grafArmonicos,'Amplitud') %Etiquetas en X y Y
            xlabel(handles.grafArmonicos,'Número de Armónico') %Etiqueta en N discreto
            xlabel(handles.grafAmplitud,'Sumatoria en Armonico') %Etiquetas en X y Y Z para tercer plot
            ylabel(handles.grafAmplitud,'Tiempo')
            zlabel(handles.grafAmplitud,'Amplitud')
            title(handles.grafAmplitud,'Sumatoria de Fourier en el Tiempo')
            set(handles.grafAmplitud, 'XGrid','on','YGrid','on','ZGrid','on') %FUNCION PARA ACTIVAR GRIDS 
      
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%FIN TITULOS Y PROPIEDADES DE LOS PLOTS%%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        end
        pause(0.3);
    end
    
%     for l=1:NumArm
%         AmpCoefMirror=flip(AmpCoefMirror);
%         disp
%     end


     
     for i=1:NumArm
        NArm(1,i)=i;
     end
     

     AmpCoefMirror=flip(AmpCoef(1,:));
     AmpCoefExp=[AmpCoefMirror,D0,AmpCoef(1,:)];
     
     NArmMirror=-flip(NArm);
     NArmExp=[NArmMirror,0,NArm]
     disp(coefFou(1,1));
     
     handles.g4=stem(handles.grafExp,NArmExp,AmpCoefExp); %Gráfica la amplitud para cada armónico
    
            set(handles.grafExp, 'XGrid','on','YGrid','on') %FUNCION PARA ACTIVAR GRIDS 
            title(handles.grafExp,'Amplitud de Coeficientes forma exponencial')
            ylabel(handles.grafExp,'Amplitud') %Etiquetas en X y Y
            xlabel(handles.grafExp,'Número de Armónico') %Etiqueta en N discreto 

    a0 = 0.5*coefFou(1)*u; %Coeficienta a0 dividido entre dos, para el cálculo numérico
    sumArm = sumArm+a0; %Se le suma el coeficiente a0 a la serie de fourier
    handles.g3=plot3(handles.grafAmplitud,u*NumArm,armonicosN(1,:),sumArm,'color','g'); %Se gráfica la serie de fourier numérica    
    hold(handles.grafAmplitud,'off');
    hold(handles.grafArmonicos,'off');
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%FIN GRAFICAS 3D DIBUJADAS PASO A PASO%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     
    
else %Si el usuario no tiene el toolbox simbolico no se pueden realizar los calculos algebraicos requeridos
    msgbox('Debe confirmar que tiene el Paquete Toolbox simbolico para realizar estos calculos, seleccionando la casilla','Toolbox Simbolico??','error')
end

    
%handles.g1=plot(handles.grafTiempo,fn(1,:),fn(2,:))

% --------------------------------------------------------------------
function sobre_1_Callback(hObject, eventdata, handles)
% hObject    handle to sobre_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function numArm_Callback(hObject, eventdata, handles)
% hObject    handle to numArm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numArm as text
%        str2double(get(hObject,'String')) returns contents of numArm as a double


% --- Executes during object creation, after setting all properties.
function numArm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numArm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function sliFreq_Callback(hObject, eventdata, handles)
% hObject    handle to sliFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function sliFreq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function freqVal_Callback(hObject, eventdata, handles)
% hObject    handle to freqVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of freqVal as text
%        str2double(get(hObject,'String')) returns contents of freqVal as a double


% --- Executes during object creation, after setting all properties.
function freqVal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to freqVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ampVal_Callback(hObject, eventdata, handles)
% hObject    handle to ampVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ampVal as text
%        str2double(get(hObject,'String')) returns contents of ampVal as a double


% --- Executes during object creation, after setting all properties.
function ampVal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ampVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function velVal_Callback(hObject, eventdata, handles)
% hObject    handle to velVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of velVal as text
%        str2double(get(hObject,'String')) returns contents of velVal as a double


% --- Executes during object creation, after setting all properties.
function velVal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to velVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in ToolS.
function ToolS_Callback(hObject, eventdata, handles)
% hObject    handle to ToolS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ToolS


% --- Executes on button press in convertirBoton.
function convertirBoton_Callback(hObject, eventdata, handles)
% hObject    handle to convertirBoton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cla(handles.grafAmplitud,'reset');
title(handles.coefAo,' ');
title(handles.coefAn,' ');
title(handles.coefBn,' ');
set(handles.grafAmplitud,'Visible','off');
%hold(handles.grafAmplitud,'off'); %Borran la tercera gráfica
varSliF = get(handles.sliFreq,'Value'); %Adquiere el valor de la frecuencia del Slide
varSliA = get(handles.sliAmp,'Value'); %Adquiere el valor de la amplitud del Slide
varSliAr = get(handles.sliArm,'Value'); %Adquiere el valor del numero de armonicos del Slide
a=str2double(get(handles.ampVal,'string')); %Se adquiere el valor de la amplitud desde el GUI
N=str2double(get(handles.dftVal,'String')); %Se adquiere el valor de cantidad de armonicos desde el GUI
T=str2double(get(handles.perVal,'String')); %Se adquiere el valor del periodo desde el GUI
freq=str2double(get(handles.freqVal,'String')); %Se adquiere el valor de la frecuencia desde el GUI
freq=freq*varSliF*10; %Se varia la frecuencia 
a=a*varSliA*10 %Se varía la amplitud con el segundo Slide
N = floor(N*varSliAr*10); %Se varia el numero de armonicos
colores = ['y' 'm' 'c' 'r' 'g' 'b' 'c' 'k'] %Colores Primarios
set(handles.freqSal,'String',num2str(freq)); %Valor de Salida de Frecuencia
set(handles.ampSalT,'String',num2str(a)); %Valor de Salida de amplitud
set(handles.armSalT,'String',num2str(N)); %Valor de Salida de armonicos
k=1:N;  
f=a*sin(2*pi*freq*k*(1/T));
handles.g1=plot(handles.grafTiempo,abs(f))
set(handles.grafTiempo, 'XGrid','on','YGrid','on') %FUNCION PARA ACTIVAR GRIDS
xlabel(handles.grafTiempo,'Tiempo') %Etiquetas en X y Y
ylabel(handles.grafTiempo,'Amplitud')
title(handles.grafTiempo,'Señal en el Tiempo')
size(f);
F=fft(f);
handles.g2 = stem(handles.grafArmonicos,k,F);
set(handles.grafArmonicos, 'XGrid','on','YGrid','on') %FUNCION PARA ACTIVAR GRIDS 
title(handles.grafArmonicos,'Amplitud de Coeficientes')
ylabel(handles.grafArmonicos,'Amplitud') %Etiquetas en X y Y
xlabel(handles.grafArmonicos,'Número de Armónico') %Etiqueta en N discreto
NumArm = N;
div=20*NumArm;
armonicosN = calArm2((F),T,div,NumArm);%armonicosN es una matriz cuya primera fila es el dominio en el tiempo, y las siguientes filas son los armónicos
disp(armonicosN)
[Xfm Xfn] = size(armonicosN);
u=ones(1,Xfn); %Matriz de unos del tamaño del dominio del tiempo
%xlabel('Tiempo')
%ylabel('|Y(Amplitud)|')
% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function pasos_2_Callback(hObject, eventdata, handles)
% hObject    handle to pasos_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('1. Ingrese los intervalos. Si se ingresa una función simbólica el Vector de dominio solo puede tener dos valores. El tamaño del dominio debe ser mayor que el de la función 2. Presiones el boton graficar y espere 5s 3. Presione el boton graficar 4. Si cuenta con el Toolbox Math Symbolic seleccione la casilla para realizar los calculos','Pasos','help')


% --------------------------------------------------------------------
function autor_2_Callback(hObject, eventdata, handles)
% hObject    handle to autor_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('Version 2.0 Hecho por: Ing. Marta Vargas y compas, para el querido profesor de Señales. Unitec 2012. Merry Christmas!!!! ;) ','Sobre el programa')


function dftVal_Callback(hObject, eventdata, handles)
% hObject    handle to dftVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dftVal as text
%        str2double(get(hObject,'String')) returns contents of dftVal as a double


% --- Executes during object creation, after setting all properties.
function dftVal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dftVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function perVal_Callback(hObject, eventdata, handles)
% hObject    handle to perVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of perVal as text
%        str2double(get(hObject,'String')) returns contents of perVal as a double


% --- Executes during object creation, after setting all properties.
function perVal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to perVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function sliAmp_Callback(hObject, eventdata, handles)
% hObject    handle to sliAmp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function sliAmp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliAmp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sliArm_Callback(hObject, eventdata, handles)
% hObject    handle to sliArm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function sliArm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliArm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in ayuda1.
function ayuda1_Callback(hObject, eventdata, handles)
% hObject    handle to ayuda1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('Ingrese un intervalo en la forma [a b c] y una función de t o un intervalo [d, e]','Ayuda','help')


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over botonCalcula.
function botonCalcula_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to botonCalcula (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on botonCalcula and none of its controls.
function botonCalcula_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to botonCalcula (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
