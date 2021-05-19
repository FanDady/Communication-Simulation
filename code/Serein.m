%=============Author:С��ͬѧ================%
%=======���ݴ�ѧ��������Ϣ����ѧԺ===========%
%==============2020.06.06==================%
%=============ͨ��ԭ��γ����==============%



function varargout = Serein(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Serein_OpeningFcn, ...
                   'gui_OutputFcn',  @Serein_OutputFcn, ...
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

function Serein_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;
guidata(hObject, handles);
global snr;
global period;
global method1;
global method2;
method1 =1;
method2=1;
snr=1;
period='0';


function varargout = Serein_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


function figure1_CreateFcn(hObject, eventdata, handles)
Background=axes('units','normalized','pos',[0 0 1 1]);
uistack(Background,'down');
img=imread('Background.png');
image(img);
colormap gray
set(Background,'handlevisibility','off','visible','off');


%2ASK���ƽ����ť
function ASKbutton_Callback(hObject, eventdata, handles)
global snr;
global period;
SNR_List=-10:1:10;
if snr==1 && (str2num(period)==0)
    errordlg('��ѡ�����','��ʾ','modal')
end

if snr==1 && (str2num(period)>1)
    set(handles.text1,'String','��ѡ�������')
    errordlg('��ѡ�������ֵ','��ʾ','modal')
end
if (str2num(period)==0 || str2num(period)<1) && snr~=1
    set(handles.text1,'String','������������')
    errordlg('��������ȷ��������','��ʾ','modal')
end

if snr~=1 && (str2num(period)>0)
    Error=ASK_Chart(SNR_List(snr-1),str2num(period));
    set(handles.text1,'String',['���������',num2str(Error),'��']);
end

%ѡ������ȵ���ʽ�˵�
function SNR_Callback(hObject, eventdata, handles)
global snr;
snr=get(hObject,'Value');

function SNR_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit1_Callback(hObject, eventdata, handles)

function edit1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%2FSK���ƽ����ť
function FSKbutton_Callback(hObject, eventdata, handles)
global snr;
global period;

SNR_List=-10:1:10;
if snr==1 && (str2num(period)==0)
    errordlg('��ѡ�����','��ʾ','modal')
end

if snr==1 && (str2num(period)>1)
    set(handles.text1,'String','��ѡ�������')
    errordlg('��ѡ�������ֵ','��ʾ','modal')
end
if (str2num(period)==0 || str2num(period)<1) && snr~=1
    set(handles.text1,'String','������������')
    errordlg('��������ȷ��������','��ʾ','modal')
end

if snr~=1 && (str2num(period)>0)
    Error=FSK_Chart(SNR_List(snr-1),str2num(period));
    set(handles.text1,'String',['���������',num2str(Error),'��']);
end

%2PSK���ƽ����ť
function PSKbutton_Callback(hObject, eventdata, handles)
global snr;
global period;

SNR_List=-10:1:10;
if snr==1 && (str2num(period)==0)
    errordlg('��ѡ�����','��ʾ','modal')
end

if snr==1 && (str2num(period)>1)
    set(handles.text1,'String','��ѡ�������')
    errordlg('��ѡ�������ֵ','��ʾ','modal')
end
if (str2num(period)==0 || str2num(period)<1) && snr~=1
    set(handles.text1,'String','������������')
    errordlg('��������ȷ��������','��ʾ','modal')
end

if snr~=1 && (str2num(period)>0)
    Error=PSK_Chart(SNR_List(snr-1),str2num(period));
    set(handles.text1,'String',['���������',num2str(Error),'��']);
end

%4PSK���ƽ����ť
function QPSKbutton_Callback(hObject, eventdata, handles)
global snr;
global period;

SNR_List=-10:1:10;
if snr==1 && (str2num(period)==0)
    errordlg('��ѡ�����','��ʾ','modal')
end

if snr==1 && (str2num(period)>1)
    set(handles.text1,'String','��ѡ�������')
    errordlg('��ѡ�������ֵ','��ʾ','modal')
end
if (str2num(period)==0 || str2num(period)<1) && snr~=1
    set(handles.text1,'String','������������')
    errordlg('��������ȷ��������','��ʾ','modal')
end

if snr~=1 && (str2num(period)>0)
    Error=PSK4_Chart(SNR_List(snr-1),str2num(period));
    set(handles.text1,'String',['���������',num2str(Error),'��']);
end

%ѡ�����ڵ�����ʽ��̬��
function Echo_Edit_Callback(hObject, eventdata, handles)
global period;
period=get(hObject,'String');

function Echo_Edit_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%2ASK�����ʻ��ư�ť
function Error_2ASK_Callback(hObject, eventdata, handles)
errordlg('�������п�����ҪһЩʱ�����Ե�','��ʾ','modal');
ERROR_ASK=zeros(1,11);
SNR=-10;
snr_db=-10:2:10;
Snr=10.^(snr_db/10);
set(handles.text2,'String','2ASK');
for loop=1:1:11
   ERROR_ASK(loop)=ASK_Function(SNR);
   SNR=SNR+2;
   errordlg(['��ǰ����Ϊ',num2str(100/11*loop),'%'],'��ʾ','modal');
   if loop==11
      set(handles.text3,'String','�����100%');
   end
end
axes(handles.axes4);
cla;
Pe_2ASK_theory=0.5*erfc(sqrt(0.45*Snr));      
semilogy(snr_db,Pe_2ASK_theory,'r-');hold on; 
semilogy(snr_db,ERROR_ASK,'r--');    
grid on;
legend('TheoryError','ActualError');
xlabel('�����/dB');
ylabel('������');

%2FSK�����ʻ��ư�ť
function Error_2FSK_Callback(hObject, eventdata, handles)
errordlg('�������п�����ҪһЩʱ�����Ե�','��ʾ','modal');
ERROR_FSK=zeros(1,11);
SNR=-10;
snr_db=-10:2:10;
Snr=10.^(snr_db/10);
set(handles.text2,'String','2FSK');
for loop=1:1:11
   ERROR_FSK(loop)=FSK_Function(SNR);
   SNR=SNR+2;
   errordlg(['��ǰ����Ϊ',num2str(100/11*loop),'%'],'��ʾ','modal');
   if loop==11
      set(handles.text3,'String','�����100%');
   end
end
axes(handles.axes4);
cla;
Pe_2FSK_theory=0.5*erfc(sqrt(0.6*Snr));      
semilogy(snr_db,Pe_2FSK_theory,'g-');hold on; 
semilogy(snr_db,ERROR_FSK,'g--');      
grid on;
legend('TheoryError','ActualError');
xlabel('�����/dB');
ylabel('������');

%2PSK�����ʻ��ư�ť
function Error_2PSK_Callback(hObject, eventdata, handles)
errordlg('�������п�����ҪһЩʱ�����Ե�','��ʾ','modal');
ERROR_PSK=zeros(1,11);
SNR=-10;
snr_db=-10:2:10;
Snr=10.^(snr_db/10);
set(handles.text2,'String','2PSK');
for loop=1:1:11
   ERROR_PSK(loop)=PSK_Function(SNR);
   SNR=SNR+2;
   errordlg(['��ǰ����Ϊ',num2str(100/11*loop),'%'],'��ʾ','modal');
   if loop==11
      set(handles.text3,'String','�����100%');
   end
end
axes(handles.axes4);
cla;
Pe_2PSK_theory=0.5*erfc(sqrt(Snr));
semilogy(snr_db,Pe_2PSK_theory,'b-');hold on; 
semilogy(snr_db,ERROR_PSK,'b--');      
grid on;
legend('TheoryError','ActualError');
xlabel('�����/dB');
ylabel('������');

%4PSK�����ʻ��ư�ť
function Error_4PSK_Callback(hObject, eventdata, handles)
errordlg('�������п�����ҪһЩʱ�����Ե�','��ʾ','modal');
ERROR_4PSK=zeros(1,11);
SNR=-10;
snr_db=-10:2:10;
Snr=10.^(snr_db/10);
set(handles.text2,'String','2PSK');
for loop=1:1:11
   ERROR_4PSK(loop)=PSK4_Function(SNR);
   SNR=SNR+2;
   errordlg(['��ǰ����Ϊ',num2str(100/11*loop),'%'],'��ʾ','modal');
   if loop==11
      set(handles.text3,'String','�����100%');
   end
end
axes(handles.axes4);
cla;
Pe_4PSK_theory=0.5*erfc(sqrt(Snr));
semilogy(snr_db,Pe_4PSK_theory,'k-');hold on;
semilogy(snr_db,ERROR_4PSK,'k--');   
axis([-10 10 10^(-5) 1e0]);
grid on;
legend('TheoryError','ActualError');
xlabel('�����/dB');
ylabel('������');

%��������ʾ
function axes4_CreateFcn(hObject, eventdata, handles)

function clear_Callback(hObject, eventdata, handles)
cla(handles.axes4);

%��˹��˹���ز���ȡ��ť
function Costasbutton_Callback(hObject, eventdata, handles)
cla
global method1;
if method1==2
[OUT1,OUT2]=Costas_2PSK();
%{
axes(handles.axes4);

plot(OUT1,'r');
axis([0 500 -2 2]);
grid on     
hold on;


plot(OUT2,'g');
axis([0 500 -2 2]);
grid on;                                %�����ز�

hold on;
legend('��ȡ���ز�','ԭ��������ز�');
%}
else
    errordlg('��ѡ���ز���ȡ����','��ʾ','modal');
end


%�ز���ȡ����ѡ��
function Method_Callback(hObject, eventdata, handles)

global method1;
method1=get(hObject,'Value');

function Method_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%�˳�ϵͳ��ť
function EXIT_Callback(hObject, eventdata, handles)
close(Serein);

%λͬ����ť
function Synchronizationbutton_Callback(hObject, eventdata, handles)
global method2;
if method2==2
run('Symbol_Synchronization.m')
else
    errordlg('��ѡ��λͬ������','��ʾ','modal');
end

%λͬ������ѡ��
function methodMenu_Callback(hObject, eventdata, handles)
global method2;
method2=get(hObject,'Value');


function methodMenu_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
