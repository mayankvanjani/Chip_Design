function varargout = pipeout_wirein(varargin)
% PIPEOUT_WIREIN MATLAB code for pipeout_wirein.fig
%      PIPEOUT_WIREIN, by itself, creates a new PIPEOUT_WIREIN or raises the existing
%      singleton*.
%
%      H = PIPEOUT_WIREIN returns the handle to a new PIPEOUT_WIREIN or the handle to
%      the existing singleton*.
%
%      PIPEOUT_WIREIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PIPEOUT_WIREIN.M with the given input arguments.
%
%      PIPEOUT_WIREIN('Property','Value',...) creates a new PIPEOUT_WIREIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before pipeout_wirein_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to pipeout_wirein_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help pipeout_wirein

% Last Modified by GUIDE v2.5 27-Jun-2018 13:58:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @pipeout_wirein_OpeningFcn, ...
                   'gui_OutputFcn',  @pipeout_wirein_OutputFcn, ...
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


% --- Executes just before pipeout_wirein is made visible.
function pipeout_wirein_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to pipeout_wirein (see VARARGIN)

% Choose default command line output for pipeout_wirein
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes pipeout_wirein wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = pipeout_wirein_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% ------------------------- %


% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%disp('hello world reset');

cla(handles.axes1);

% --- Executes on button press in enable.
function enable_Callback(hObject, eventdata, handles)
% hObject    handle to enable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% disp('hello world enable');

<<<<<<< HEAD:Intro/Pipeout Wirein Test/pipeout_wirein.m
t = 0:.001:
disp('testing');
=======
t = eval(get(handles.time,'String'));
y = 0.5+( sawtooth(pi*50*t, 0.5) / 2);
plot(handles.axes1,t,y);
set(handles.axes1,'XMinorTick','on');
grid on;
>>>>>>> 7081e4ac1d2630859bf57d6f3170068c7b735242:DAQ/Pipeout Wirein Test/pipeout_wirein.m

% --- Executes on button press in test_signal.
function test_signal_Callback(hObject, eventdata, handles)
% hObject    handle to test_signal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%disp('hello world test_signal');

freq = str2double(get(handles.frequency,'String'));
t = eval(get(handles.time,'String'));

% Calculate data
x = sin(2*pi*freq*t);
% y = fft(x,512);
% m = y.*conj(y)/512;
% f = 1000*(0:256)/512;

%{
% Create frequency plot in proper axes
plot(handles.frequency_axes,f,m(1:257));
set(handles.frequency_axes,'XMinorTick','on');
grid on
%}

% Create time plot in proper axes
plot(handles.axes1,t,x);
set(handles.axes1,'XMinorTick','on');
% disp('hello world');
grid on



function time_Callback(hObject, eventdata, handles)
% hObject    handle to time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of time as text
%        str2double(get(hObject,'String')) returns contents of time as a double
set(handles.test_signal,'Enable','off');
try
    t = eval(get(handles.time,'String'));
    if ~isnumeric(t)
        % t is not a number
        set(handles.test_signal,'String','t is not numeric')
    elseif length(t) < 2
        % t is not a vector
        set(handles.test_signal,'String','t must be vector')
    elseif length(t) > 1000
        % t is too long a vector to plot clearly
        set(handles.test_signal,'String','t is too long')
    elseif min(diff(t)) < 0
        % t is not monotonically increasing
        set(handles.test_signal,'String','t must increase')
    else
        % Enable the Plot button with its original name
        set(handles.test_signal,'String','Plot')
        set(handles.test_signal,'Enable','on')
        return
    end

 catch ME %#ok<*NASGU>
    % Cannot evaluate expression user typed
    set(handles.test_signal,'String','Cannot plot t');
    uicontrol(hObject);
end

% --- Executes during object creation, after setting all properties.
function time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function frequency_Callback(hObject, eventdata, handles)
% hObject    handle to frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of frequency as text
%        str2double(get(hObject,'String')) returns contents of frequency as a double
freq = str2double(get(hObject,'String'));
if isnan(freq) || ~isreal(freq)  
    set(handles.test_signal,'String','Unable to Plot');
    set(handles.test_signal,'Enable','off');
    uicontrol(hObject);
else 
    set(handles.test_signal,'String','Plot');
    set(handles.test_signal,'Enable','on');
end

% --- Executes during object creation, after setting all properties.
function frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pipeout.
function pipeout_Callback(hObject, eventdata, handles)
% hObject    handle to pipeout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp('hello world pipeout');

str = inputdlg({'P','Q','div1(delta_sigma)'},'Input dialog');
P = str2num(str{1});
Q = str2num(str{2});
div1 = str2num(str{3});

handles.pll = calllib('okFrontPanel', 'okPLL22150_Construct');
calllib('okFrontPanel', 'okPLL22150_SetCrystalLoad', handles.pll, 12.0);
calllib('okFrontPanel', 'okPLL22150_SetReference', handles.pll, 48.0, 1);

calllib('okFrontPanel', 'okPLL22150_SetVCOParameters', handles.pll, P, Q);
handles.VCO_freq = calllib('okFrontPanel', 'okPLL22150_GetVCOFrequency', handles.pll);
calllib('okFrontPanel', 'okPLL22150_SetDiv1', handles.pll, 1, div1);
calllib('okFrontPanel', 'okPLL22150_SetOutputSource', handles.pll, 4, 1);
handles.freq_out1 = calllib('okFrontPanel', 'okPLL22150_GetOutputFrequency', handles.pll, 4);
calllib('okFrontPanel', 'okPLL22150_SetOutputEnable', handles.pll, 4, 1);

success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue',handles.xem,hex2dec('01'),1,hex2dec('01'));
calllib('okFrontPanel', 'okFrontPanel_SetPLL22150Configuration', handles.xem, handles.pll);
handles.success_configure = calllib('okFrontPanel', 'okFrontPanel_ConfigureFPGA', handles.xem,'chip4_adc_selfmain_v2.bit');

buf(psize,1) = uint8(0);
epvalue(bsize,1) = uint8(0);
pv = libpointer('uint8Ptr', buf);

guidata(hObject, handles);
calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
pause(0.01);

calllib('okFrontPanel', 'okFrontPanel_ReadFromBlockPipeOut', handles.xem, hex2dec('A0'), 1024,f0, pv_A0);
epvalue_A0 = get(pv_A0, 'value');
pause(0.1);



