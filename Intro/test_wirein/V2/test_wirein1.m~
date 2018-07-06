function varargout = test_wirein1(varargin)
% TEST_WIREIN1 MATLAB code for test_wirein1.fig
%      TEST_WIREIN1, by itself, creates a new TEST_WIREIN1 or raises the existing
%      singleton*.
%
%      H = TEST_WIREIN1 returns the handle to a new TEST_WIREIN1 or the handle to
%      the existing singleton*.
%
%      TEST_WIREIN1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TEST_WIREIN1.M with the given input arguments.
%
%      TEST_WIREIN1('Property','Value',...) creates a new TEST_WIREIN1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before test_wirein1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to test_wirein1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help test_wirein1

% Last Modified by GUIDE v2.5 29-Apr-2018 19:04:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @test_wirein1_OpeningFcn, ...
                   'gui_OutputFcn',  @test_wirein1_OutputFcn, ...
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


% --- Executes just before test_wirein1 is made visible.
function test_wirein1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to test_wirein1 (see VARARGIN)

% Choose default command line output for test_wirein1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes test_wirein1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = test_wirein1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in BITfile_LOAD.
function BITfile_LOAD_Callback(hObject, eventdata, handles)
% hObject    handle to BITfile_LOAD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
loadlibrary('okFrontPanel', 'okFrontPanelDLL.h');
handles.xem = calllib('okFrontPanel', 'okFrontPanel_Construct');
handles.numDevices = calllib('okFrontPanel', 'okFrontPanel_GetDeviceCount', handles.xem);
handles.ret = calllib('okFrontPanel', 'okFrontPanel_OpenBySerial', handles.xem, '');
handles.success_checkOPEN = calllib('okFrontPanel', 'okFrontPanel_IsOpen', handles.xem);
handles.success_configure = calllib('okFrontPanel', 'okFrontPanel_ConfigureFPGA', handles.xem,'wirein_test1.bit');
%{
handles.led1=0;
handles.led2=0;
handles.led3=0;
handles.led4=0;
handles.led5=0;
handles.led6=0;
handles.led7=0;
handles.led8=0;
%}
guidata(hObject, handles);

% --- Executes on button press in UNLOAD.
function UNLOAD_Callback(hObject, eventdata, handles)
% hObject    handle to UNLOAD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
calllib('okFrontPanel', 'okFrontPanel_Destruct', handles.xem);
guidata(hObject, handles);
clear handle;
unloadlibrary okFrontPanel

% --- Executes on button press in LED1.
function LED1_Callback(hObject, eventdata, handles)
% hObject    handle to LED1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LED1
if(get(hObject,'Value') == 1)
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('00'),1,1);
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
else
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('00'),0,1);
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end

  guidata(hObject, handles);
  
% --- Executes on button press in LED2.
function LED2_Callback(hObject, eventdata, handles)
% hObject    handle to LED2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LED2
if(get(hObject,'Value') == 1)
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('00'),2,2);
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
else
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('00'),0,2);
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end

  guidata(hObject, handles);
  
% --- Executes on button press in LED3.
function LED3_Callback(hObject, eventdata, handles)
% hObject    handle to LED3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LED3
if(get(hObject,'Value') == 1)
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('00'),4,4);
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
else
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('00'),0,4);
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end

  guidata(hObject, handles);
  
% --- Executes on button press in LED4.
function LED4_Callback(hObject, eventdata, handles)
% hObject    handle to LED4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LED4
if(get(hObject,'Value') == 1)
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('00'),8,8);
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
else
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('00'),0,8);
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end

  guidata(hObject, handles);
  
% --- Executes on button press in LED5.
function LED5_Callback(hObject, eventdata, handles)
% hObject    handle to LED5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LED5
if(get(hObject,'Value') == 1)
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('00'),16,16);
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
else
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('00'),0,16);
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end

  guidata(hObject, handles);
  
% --- Executes on button press in LED6.
function LED6_Callback(hObject, eventdata, handles)
% hObject    handle to LED6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LED6
if(get(hObject,'Value') == 1)
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('00'),32,32);
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
else
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('00'),0,32);
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end

  guidata(hObject, handles);
  
% --- Executes on button press in LED7.
function LED7_Callback(hObject, eventdata, handles)
% hObject    handle to LED7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LED7
if(get(hObject,'Value') == 1)
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('00'),64,64);
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
else
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('00'),0,64);
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end

  guidata(hObject, handles);
  
% --- Executes on button press in LED8.
function LED8_Callback(hObject, eventdata, handles)
% hObject    handle to LED8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LED8
if(get(hObject,'Value') == 1)
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('00'),128,128);
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
else
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('00'),0,128);
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end

  guidata(hObject, handles);
  
