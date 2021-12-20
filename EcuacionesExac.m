function varargout = EcuacionesExac(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EcuacionesExac_OpeningFcn, ...
                   'gui_OutputFcn',  @EcuacionesExac_OutputFcn, ...
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

function EcuacionesExac_OpeningFcn(hObject, eventdata, handles, varargin)
axes(handles.axes1);
[x,map]=imread('B.jpg');
image(x);
colormap(map);
axis off;
hold on;
handles.output = hObject;
guidata(hObject, handles);

function varargout = EcuacionesExac_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function edit1_Callback(hObject, eventdata, handles)

function edit1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit2_Callback(hObject, eventdata, handles)

function edit2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function bttnR_Callback(hObject, eventdata, handles)
M=str2sym(get(handles.edit1,'String'));
N=str2sym(get(handles.edit2,'String'));
x0=char(get(handles.edit4,'String'));
y0=char(get(handles.edit3,'String'));
syms x y g dg c;%Definir x y como variables symbolicas
dM=diff(M,y);%Derivada: dM/dy
dN=diff(N,x);%Derivada: dN/dx
disp('dM/dy:')
disp(dM);
disp('dN/dx:')
disp(dN);
if(dN==dM)%Verificar que sea una ecuacion exacta
    disp('ES EXACTA');
    F=int(M,x);%Integrar M con respecto a x
    Fe=expand(F)+g;%Expandir la ecuacion F
    disp('Ecuacion F:')
    disp('F'==Fe);
    dF=diff(Fe,y)+dg;%Derivada de F con respecto a y
    disp('Ecuacion F derivada:')
    disp('dF'==dF);
    Fvalg= solve(dF==N,dg);%Igualar dF con N y resolverlo para dg
    valg=int(Fvalg);%Calcular el valor de g
    disp('Valor de g:');
    disp(valg);
    solGen=(subs(Fe,g,valg))== c;%remplazar el valor de g en F
    disp('Solucion General:');
    disp(solGen);
    set(handles.text7,'String',char(solGen));

    sol=solGen;
    sol=subs(sol,y,y0);%remplazar el valor de y con y0
    sol=subs(sol,x,x0);%remplazar el valor de x con x0

    valorC=solve(sol,c);%resolver para c 
    soluPar=subs(solGen,c,valorC);%Solucion Particular
    soluPar=solve(soluPar,y);
    disp("Solucion Particular:");
    disp(y==soluPar);
    soPar=y==soluPar;
    set(handles.text8,'String',char(soPar));
else
    disp('NO ES EXACTA');
    syms x y g dg c;%Definir x y como variables symbolicas
dM = diff(M,y);%Derivada de M con respecto a y
dN = diff(N,x);%Derivada de N con respecto a x

op1=simplify((dM-dN)/N);
op2=simplify((dN-dM)/M);

ux=exp(int(op1));
uy=exp(int(op2));
disp('Valor de μ(x): ');
disp(ux);
disp('Valor de μ(y):');
disp(uy);

M1=expand(M*ux);
N1=expand(N*ux);
M2=expand(M*uy);
N2=expand(N*uy);

dM1 = diff(M1,y);
dN1 = diff(N1,x);
dM2 = diff(M2,y);
dN2 = diff(N2,x);
    if (dM1==dN1)
        disp('Solucion con μ(x):')
        disp('Valor de M multiplicado por μ(x)')
        disp(M1);
        disp('Valor de N multiplicado por μ(x)')
        disp(N1);
        disp('ES EXACTA');
        F=int(M1,x);%Integrar M con respecto a x
        Fe=expand(F)+g;%Expandir la ecuacion F
        disp('Ecuacion F:')
        disp('F'==Fe);
        dF=diff(Fe,y)+dg;%Derivada de F con respecto a y
        disp('Ecuacion F derivada:')
        disp('dF'==dF);
        Fvalg= solve(dF==N1,dg);%Igualar dF con N y resolverlo para dg
        valg=int(Fvalg);%Calcular el valor de g
        disp('Valor de g:');
        disp(valg);
        solGen=(subs(Fe,g,valg))== c;%remplazar el valor de g en F
        disp('Solucion General:');
        disp(solGen);
        set(handles.text7,'String',char(solGen));
        sol=solGen;
        sol=subs(sol,y,y0);%remplazar el valor de y con y0
        sol=subs(sol,x,x0);%remplazar el valor de x con x0

        valorC=solve(sol,c);%resolver para c 
        soluPar=subs(solGen,c,valorC);%Solucion Particular
        soluPar=solve(soluPar,y);
        disp("Solucion Particular:");
        disp(y==soluPar);
        soPar=y==soluPar;
        set(handles.text8,'String',char(soPar));
    elseif(dM2==dN2)
        disp('Solucion con μ(y):')
        disp('Valor de M multiplicado por μ(y)')
        disp(M2);
        disp('Valor de N multiplicado por μ(y)')
        disp(N2);
        disp('ES EXACTA');
        F=int(M2,x);%Integrar M con respecto a x
        Fe=expand(F)+g;%Expandir la ecuacion F
        disp('Ecuacion F:')
        disp('F'==Fe);
        dF=diff(Fe,y)+dg;%Derivada de F con respecto a y
        disp('Ecuacion F derivada:')
        disp('dF'==dF);
        Fvalg= solve(dF==N2,dg);%Igualar dF con N y resolverlo para dg
        valg=int(Fvalg);%Calcular el valor de g
        disp('Valor de g:');
        disp(valg);
        solGen=(subs(Fe,g,valg))== c;%remplazar el valor de g en F
        disp('Solucion General:');
        disp(solGen);
        set(handles.text7,'String',char(solGen));

        sol=solGen;
        sol=subs(sol,y,y0);%remplazar el valor de y con y0
        sol=subs(sol,x,x0);%remplazar el valor de x con x0

        valorC=solve(sol,c);%resolver para c 
        soluPar=subs(solGen,c,valorC);%Solucion Particular
        soluPar=solve(soluPar,y);
        disp("Solucion Particular:");
        sPa=y==soluPar;
        set(handles.text8,'String',char(sPa));
    end 
end


function text7_CreateFnc(hObject, eventdata, handles) 



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
