function varargout = HallBar_GUI_template4(varargin)
% HALLBAR_GUI_TEMPLATE4 M-file for HallBar_GUI_template4.fig
%      HALLBAR_GUI_TEMPLATE4, by itself, creates a new HALLBAR_GUI_TEMPLATE4 or raises the existing
%      singleton*.
%
%      H = HALLBAR_GUI_TEMPLATE4 returns the handle to a new HALLBAR_GUI_TEMPLATE4 or the handle to
%      the existing singleton*.
%
%      HALLBAR_GUI_TEMPLATE4('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HALLBAR_GUI_TEMPLATE4.M with the given input arguments.
%
%      HALLBAR_GUI_TEMPLATE4('Property','Value',...) creates a new HALLBAR_GUI_TEMPLATE4 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before HallBar_GUI_template4_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to HallBar_GUI_template4_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose 'GUI allows only one
%      instance to run (singleton)'.
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help HallBar_GUI_template4

% Last Modified by GUIDE v2.5 04-Jan-2018 15:21:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @HallBar_GUI_template4_OpeningFcn, ...
                   'gui_OutputFcn',  @HallBar_GUI_template4_OutputFcn, ...
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


% --- Executes just before HallBar_GUI_template4 is made visible.
function HallBar_GUI_template4_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to HallBar_GUI_template4 (see VARARGIN)

% Choose default command line output for HallBar_GUI_template4
handles.output = hObject;

% Update handles structure
guidata(hObject, handles)

% UIWAIT makes HallBar_GUI_template4 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = HallBar_GUI_template4_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in Connect.
function Connect_Callback(hObject, eventdata, handles)
% hObject    handle to Connect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



if( ~isempty( instrfind ) )
    if( ~isempty( instrfind( 'Name' ,horzcat('GPIB0-' ,get( handles.Addr , 'String' ) ) ) ) )
        
         %deletes existing use of the port from other devices
        delete(instrfind('Name',horzcat('GPIB0-',get(handles.Addr,'String')))); 
    else
        %do nothing
    end
else
    %do nothing
end

handles.obj1 = gpib('ni', 0, str2double(get(handles.Addr,'String')));

fopen( handles.obj1 );
fprintf( handles.obj1 ,'OUTX 1\n' );

%change connect button to green
set( hObject, 'BackgroundColor', [0.0 1.0 0] )

%change disconnect button to gray
set( handles.Disconnect,'BackgroundColor' ,[0.5 0.5 0.5] ) 

guidata( hObject, handles )


% --- Executes on button press in Disconnect.
function Disconnect_Callback(hObject, eventdata, handles)
% hObject    handle to Disconnect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fclose( handles.obj1 );
delete( handles.obj1 );
clear   handles.obj1

set( hObject ,'BackgroundColor' ,'red' )
set( handles.Connect, 'BackgroundColor' , [0.5 0.5 0.5] )

guidata(hObject, handles)



function Addr_Callback(hObject, eventdata, handles)
% hObject    handle to Addr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Addr as text
%        str2double(get(hObject,'String')) returns contents of Addr as a double


% --- Executes during object creation, after setting all properties.
function Addr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Addr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Phase_Callback(hObject, eventdata, handles)
% hObject    handle to Phase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Phase as text
%        str2double(get(hObject,'String')) returns contents of Phase as a double
pause(0.1);

if( -360 <= str2double( get( handles.Phase , 'String' ) ) &&...
            str2double( get( handles.Phase , 'String' ) ) <= 730)
        
        %Send phase setting command to Lock-In Amp
        sendLockInCommand( handles , 'PHAS ' , handles.Phase );
        
        %Give visual feedback of completed command
        commandFeedback(hObject);

else
    %Send error message for invalid input value
    msgbox( 'Phase value out range -360.00<PHASE<729.99' ,'Error' ,'error' );
    

end


   

% --- Executes during object creation, after setting all properties.
function Phase_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Phase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Internal_Ref.
function Internal_Ref_Callback(hObject, eventdata, handles)
% hObject    handle to Internal_Ref (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Internal_Ref
pause( 0.1 )

%Send command to Lock-In amp to use internal reference
sendLockInCommand(handles, 'FMOD 1')

%Reset External reference radio button
set( handles.External_Ref ,'Value', 0);



% --- Executes on button press in External_Ref.
function External_Ref_Callback(hObject, eventdata, handles)
% hObject    handle to External_Ref (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of External_Ref
pause( 0.1 )

%Send command to Lock-In amp to use internal reference
sendLockInCommand( handles ,'FMOD 0' )

%Reset internal reference button
set( handles.Internal_Ref ,'Value' ,0 );
    


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Freq_Callback(hObject, eventdata, handles)
% hObject    handle to Freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Freq as text
%        str2double(get(hObject,'String')) returns contents of Freq as a double
pause(0.1);
if( 0.001 <= str2double( ( get( handles.Freq, 'String' ) ) ) &&... 
             str2double( ( get( handles.Freq, 'String' ) ) ) <=10200 )
    
    %Send command to Lock-In Amp to change reference frequency
    sendLockInCommand( handles , 'FREQ ', handles.Freq )
    
    %Give visual feedback of command completion
    commandFeedback( hObject );
    
else
    %Send error message if input value is invalid
    msgbox( 'Frequency value out range -0.001<Frequency<10200','Error' , 'error' );
end


% --- Executes during object creation, after setting all properties.
function Freq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in RefTrig.
function RefTrig_Callback(hObject, eventdata, handles)
% hObject    handle to RefTrig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns RefTrig contents as cell array
%        contents{get(hObject,'Value')} returns selected item from RefTrig
pause(0.1)
%Value used to calculate corrent drop-down menu position
decrementValue = 2;

sendLockInCommand( handles , 'RSLP ' , hObject , decrementValue )
if ( get( hObject , 'Value') > 1 ) 
    %Send command to Lock-In to change Ref Trigger configuration
   sendLockInCommand( handles , 'RSLP ' , hObject , decrementValue )
   
   %Give visual feedback of command completion
   commandFeedback( hObject )
    
else
    %do nothing
end

% if query(handles.obj1, '*STB 4')
%     msgbox('Command not sent','Error','error');
% end

% --- Executes during object creation, after setting all properties.
function RefTrig_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RefTrig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Harmonic_Callback(hObject, eventdata, handles)
% hObject    handle to Harmonic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Harmonic as text
%        str2double(get(hObject,'String')) returns contents of Harmonic as a double

pause(0.1);
if 1 <= str2double( ( get( handles.Harmonic ,'String' ) ) ) &&...
        str2double( ( get( handles.Harmonic ,'String' ) ) ) <= 19999
    %Send command to Lock-In to change harmonic setting of internal
    %reference
    sendLockInCommand( handles ,'HARM ' ,handles.Harmonic )
    
    %Give visual feedback of command execution
    commandFeedback( hObject )
else
    %Give error message if input value is invalid
    msgbox( 'Harmonic value out range 1=<Harmonic=<19999' ,'Error' ,'error' );
    
end


% --- Executes during object creation, after setting all properties.
function Harmonic_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Harmonic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ampl_Output_Callback(hObject, eventdata, handles)
% hObject    handle to Ampl_Output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ampl_Output as text
%        str2double(get(hObject,'String')) returns contents of Ampl_Output as a double

pause(0.1);
if 0.001 <= str2double( ( get( handles.Ampl_Output, 'String' ) ) ) &&...
            str2double( ( get( handles.Ampl_Output ,'String' ) ) )<= 5.000
   
   %Send command to lock-in to change internal reference output voltage
   sendLockInCommand( handles ,'SLVL ', handles.Ampl_Output )
   
   %Send visual feedback of command completion
   commandFeedback( hObject )
    
else
    %Send error message if value is invalid
     msgbox('Sine Voltage output value out range 0.004<Frequency<5.000','Error','error');
   

end

% --- Executes during object creation, after setting all properties.
function Ampl_Output_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ampl_Output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in InputConfig.
function InputConfig_Callback(hObject, eventdata, handles)
% hObject    handle to InputConfig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns InputConfig contents as cell array
%        contents{get(hObject,'Value')} returns selected item from InputConfig
pause(0.1)

%Value used to align drop-down menu selection
decrementValue=2;

if ( get( hObject ,'Value' ) > 1 )
    %Send command to Lock-In to select input configuration
    sendLockInCommand( handles ,'ISRC ', hObject, decrementValue )
    
    %Give visual feedback of command completion
    commandFeedback( hObject )
    
else
    %do nothing
end

% --- Executes during object creation, after setting all properties.
function InputConfig_CreateFcn(hObject, eventdata, handles)
% hObject    handle to InputConfig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String',['Pop-up Menu';'A          ';'A-B        ';'1 M' char(937) '       ';'100 M' char(937) '     ']);
% --- Executes on button press in GND_shielding.
function GND_shielding_Callback(hObject, eventdata, handles)
% hObject    handle to GND_shielding (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of GND_shielding
pause(0.1)
%Create dummy variable
nullVar=0;
%Send command to toggle state of ground shielding setting
sendLockInCommand( handles ,'IGND ', hObject ,nullVar ,nullVar )


% --- Executes on button press in AC_couple.
function AC_couple_Callback(hObject, eventdata, handles)
% hObject    handle to AC_couple (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of AC_couple
pause(0.1)

%Send command to lock-in to set AC coupling
sendLockInCommand( handles ,'ICPL 0' )

%Reset DC radio button
set(handles.DC_couple,'Value',0);



% --- Executes on button press in DC_couple.
function DC_couple_Callback(hObject, eventdata, handles)
% hObject    handle to DC_couple (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of DC_couple
pause(0.1)

%Send command to lock-in to set DC coupling
sendLockInCommand( handles ,'ICPL 1' )

%Reset AC radio button
set( handles.AC_couple ,'Value' ,0 );


% --- Executes on selection change in NotchFilter.
function NotchFilter_Callback(hObject, eventdata, handles)
% hObject    handle to NotchFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns NotchFilter contents as cell array
%        contents{get(hObject,'Value')} returns selected item from NotchFilter
pause(0.1)
%Value of decrement to align drop-down menu selection
decrementValue = 2;

if ( get( hObject ,'Value' ) > 1 )
    %Send command to Lock-in to set notch filter configuration
    sendLockInCommand( handles, 'ILIN ' ,hObject, decrementValue )
    
    %Give visual feedback of command completion
    commandFeedback( hObject )
end

% --- Executes during object creation, after setting all properties.
function NotchFilter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NotchFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Sens.
function Sens_Callback(hObject, eventdata, handles)
% hObject    handle to Sens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Sens contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Sens
pause(0.1)

%Value of decrement to align drop-down menu selection
decrementValue = 2;

if ( get( hObject ,'Value' ) > 1 )
    %Send command to Lock-in to set sensitivity configuration
    sendLockInCommand( handles, 'SENS ' ,hObject, decrementValue )
    
    %Give visual feedback of command completion
    commandFeedback( hObject )
end

% --- Executes during object creation, after setting all properties.
function Sens_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Sens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String',['Pop-up Menu';...
    '2 nV/fA    ';'5 nV/fA    ';'10 nV/fA   ';'20 nV/fA   ';'50 nV/fA   ';'100 nV/fA  ';...
    '200 nV/fA  ';'500 nV/fA  ';'1 ' char(956) 'V/pA    ';'2 ' char(956) 'V/pA    ';...
    '5 ' char(956) 'V/pA    ';'10 ' char(956) 'V/pA   ';'20 ' char(956) 'V/pA   ';...
    '50 ' char(956) 'V/pA   ';'100 ' char(956) 'V/pA  ';'200 ' char(956) 'V/pA  ';...
    '500 ' char(956) 'V/pA  ';'1 mV/nA    ';'2 mV/nA    ';'5 mV/nA    ';'10 mV/nA   ';...
    '20 mV/nA   ';'50 mV/nA   ';'100 mV/nA  ';'200 mV/nA  ';'500 mV/nA  ';...
    '1 V/' char(956) 'A     ']);

% --- Executes on selection change in ReserveMode.
function ReserveMode_Callback(hObject, eventdata, handles)
% hObject    handle to ReserveMode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ReserveMode contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ReserveMode
pause(0.1)

%Value of decrement to align drop-down menu selection
decrementValue = 2;

if ( get( hObject ,'Value' ) > 1 )
    %Send command to Lock-in to set reserve mode configuration
    sendLockInCommand( handles, 'RMOD ' ,hObject, decrementValue )
    
    %Give visual feedback of command completion
    commandFeedback( hObject )
end

% --- Executes during object creation, after setting all properties.
function ReserveMode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ReserveMode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu7.
function popupmenu7_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu7 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu7


% --- Executes during object creation, after setting all properties.
function popupmenu7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in LP_Filter.
function LP_Filter_Callback(hObject, eventdata, handles)
% hObject    handle to LP_Filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns LP_Filter contents as cell array
%        contents{get(hObject,'Value')} returns selected item from LP_Filter
pause(0.1)

%Value of decrement to align drop-down menu selection
decrementValue = 2;

if ( get( hObject ,'Value' ) > 1 )
    %Send command to Lock-in to set low pass filter slope configuration
    sendLockInCommand( handles, 'OFSL ' ,hObject, decrementValue )
    
    %Give visual feedback of command completion
    commandFeedback( hObject )
end

% --- Executes during object creation, after setting all properties.
function LP_Filter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LP_Filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SyncFilter.
function SyncFilter_Callback(hObject, eventdata, handles)
% hObject    handle to SyncFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SyncFilter
pause(0.1)
%Create dummy variable
nullVar=0;

%Send command to toggle sync filter
sendLockInCommand( handles ,'SYNC ' ,hObject ,nullVar, nullVar)


% --- Executes on selection change in SampleRate.
function SampleRate_Callback(hObject, eventdata, handles)
% hObject    handle to SampleRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns SampleRate contents as cell array
%        contents{get(hObject,'Value')} returns selected item from SampleRate
%clrdevice(handles.obj1) %clear the hardware buffer before sending data
pause(0.1)

%Value of decrement to align drop-down menu selection
decrementValue = 2;

if ( get( hObject ,'Value' ) > 1 )
    %Send command to Lock-in to set sample rate configuration
    sendLockInCommand( handles, 'SRAT ' ,hObject, decrementValue )
    
    %Give visual feedback of command completion
    commandFeedback( hObject )
end


% --- Executes during object creation, after setting all properties.
function SampleRate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SampleRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton9.
function radiobutton9_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton9


% --- Executes on button press in radiobutton10.
function radiobutton10_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton10


% --- Executes on button press in ManualTrig.
function ManualTrig_Callback(hObject, eventdata, handles)
% hObject    handle to ManualTrig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ManualTrig
pause(0.1)
%create dummy variable
nullVar=0;

%Send command to toggle manual trigger option
sendLockInCommand( handles ,'TSTR ' ,hObject ,nullVar, nullVar)


% --- Executes on button press in TrigStart.
function TrigStart_Callback(hObject, eventdata, handles)
% hObject    handle to TrigStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%This was added as a way to trigger a specific sample collection manually
%Not being used, maybe deleted

% --- Executes on button press in DataStore.
function DataStore_Callback(hObject, eventdata, handles)
% hObject    handle to DataStore (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.QueryPoints=1;
pause(0.1);
clrdevice(handles.obj1);
if query(handles.obj1,'*STB? 1\n')
    fprintf(handles.obj1,'STRT\n');
    set(hObject,'BackgroundColor', 'green');
    set(handles.DataPause,'BackgroundColor',[0.94, 0.94, 0.94]);
    set(hObject,'String', 'Storing');
end

while query(handles.obj1,'*STB? 1\n') &&  strcmp(get(hObject,'String'),'Storing')
    pause(0.1)
    set(handles.NumPoints,'String',query(handles.obj1,'SPTS?\n')) 
end

% --- Executes on button press in DataPause.
function DataPause_Callback(hObject, eventdata, handles)
% hObject    handle to DataPause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clrdevice(handles.obj1);
pause(0.1);
if query(handles.obj1,'*STB? 1\n')
    fprintf(handles.obj1,'PAUS\n');
    set(hObject,'BackgroundColor', 'red');
    set(handles.DataStore,'BackgroundColor',[0.94, 0.94, 0.94]);
    set(handles.DataStore,'String', 'Resume');
end



% --- Executes on button press in DataReset.
function DataReset_Callback(hObject, eventdata, handles)
% hObject    handle to DataReset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pause(0.1);
if query(handles.obj1,'*STB? 1\n')
    fprintf(handles.obj1,'REST\n');
    set(handles.DataPause,'BackgroundColor',[0.94, 0.94, 0.94]);
    set(handles.DataStore,'BackgroundColor',[0.94, 0.94, 0.94]);
    set(handles.DataStore,'String', 'Store');
end

if query(handles.obj1,'*STB? 1\n')
    pause(0.1)
    set(handles.NumPoints,'String',query(handles.obj1,'SPTS?\n')) 
end

clrdevice(handles.obj1)
% --- Executes on key press with focus on TrigStart and none of its controls.
function TrigStart_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to TrigStart (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
pause(0.1);
if query(handles.obj1,'*STB? 1\n')
    fprintf(handles.obj1,'TRIG\n');
end


% --- Executes on selection change in ChannelOne.
function ChannelOne_Callback(hObject, eventdata, handles)
% hObject    handle to ChannelOne (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ChannelOne contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ChannelOne


% --- Executes during object creation, after setting all properties.
function ChannelOne_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ChannelOne (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in RatioOne.
function RatioOne_Callback(hObject, eventdata, handles)
% hObject    handle to RatioOne (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns RatioOne contents as cell array
%        contents{get(hObject,'Value')} returns selected item from RatioOne


% --- Executes during object creation, after setting all properties.
function RatioOne_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RatioOne (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Display1Set.
function Display1Set_Callback(hObject, eventdata, handles)
% hObject    handle to Display1Set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

resetPlotControl( handles )
resetStopPlot( handles )

pause(0.1);
if query(handles.obj1,'*STB? 1\n')
   fprintf(handles.obj1,horzcat('DDEF 1,',num2str(get(handles.ChannelOne,'Value')-2),',',...
       num2str(get(handles.RatioOne,'Value')-2),'\n'));
end


handles.CH1_Points=[];
guidata(hObject, handles);

%handles.PlotFlags=bitset(handles.PlotFlags,1);

while( ~get( handles.StopPlot, 'Value' )  ) 
pause(0.3)
if(isfield(handles, 'CH1_Points'))
   handles.PlotFlags=bitset( handles.PlotFlags , 1 );
   newValue = str2num( query( handles.obj1, 'OUTR? 1\n' ) );
   handles.CH1_Points = [ handles.CH1_Points  newValue ];
end
if(isfield(handles,'CH2_Points'))
    handles.PlotFlags = bitset( handles.PlotFlags , 2 );
    newValue = str2num(query(handles.obj1,'OUTR? 2\n'));
    handles.CH2_Points = [ handles.CH2_Points  newValue ];
    
end

if(isfield(handles,'magSensor_Points'))
    handles.PlotFlags = bitset( handles.PlotFlags , 3);
    newValue = handles.analogRead_magSensor.read(); %read one sample
    handles.magSensor_Points = [ handles.magSensor_Points  newValue ];
end
guidata(hObject,handles);

if(isfield(handles,'currPlot_Points'))
    handles.PlotFlags=bitset(handles.PlotFlags,4);
    %Acquire new sample
     newValue1=handles.analogRead_currPlot.read(); %read one sample
    
     %Append new sample to data array
     handles.currPlot_Points=[ handles.currPlot_Points   newValue1 ];
end
% 
guidata(hObject, handles);

plotSequence(handles);

end



% --- Executes on selection change in ChannelTwo.
function ChannelTwo_Callback(hObject, eventdata, handles)
% hObject    handle to ChannelTwo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ChannelTwo contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ChannelTwo


% --- Executes during object creation, after setting all properties.
function ChannelTwo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ChannelTwo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

set(hObject,'String',['Pop-up Menu';...
    'Y          ';char(1012) '          ';'Y Noise    ';'Aux In 3   ';'Aux In 3   ']);


% --- Executes on selection change in RatioTwo.
function RatioTwo_Callback(hObject, eventdata, handles)
% hObject    handle to RatioTwo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns RatioTwo contents as cell array
%        contents{get(hObject,'Value')} returns selected item from RatioTwo


% --- Executes during object creation, after setting all properties.
function RatioTwo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RatioTwo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Display2Set.
function Display2Set_Callback(hObject, eventdata, handles)
% hObject    handle to Display2Set (see GCBO)
% eventdata  reserved - to be defined in a future versio vn of MATLAB
% handles    structure with handles and user data (see GUIDATA)
resetPlotControl( handles )
resetStopPlot( handles )

pause(0.1);
if query(handles.obj1,'*STB? 1\n')
   fprintf(handles.obj1,horzcat('DDEF 2,',num2str(get(handles.ChannelTwo,'Value')-2),',',...
       num2str(get(handles.RatioTwo,'Value')-2),'\n'));
end

handles.CH2_Points=[];
guidata(hObject, handles);

while( ~get( handles.StopPlot, 'Value' )  ) 
pause(0.3)
if(isfield(handles, 'CH1_Points'))
   handles.PlotFlags=bitset( handles.PlotFlags , 1 );
   newValue = str2num( query( handles.obj1, 'OUTR? 1\n' ) );
   handles.CH1_Points = [ handles.CH1_Points  newValue ];
end
if(isfield(handles,'CH2_Points'))
    handles.PlotFlags = bitset( handles.PlotFlags , 2 );
    newValue = str2num(query(handles.obj1,'OUTR? 2\n'));
    handles.CH2_Points = [ handles.CH2_Points  newValue ];
    
end

if(isfield(handles,'magSensor_Points'))
    handles.PlotFlags = bitset( handles.PlotFlags , 3);
    newValue = handles.analogRead_magSensor.read(); %read one sample
    handles.magSensor_Points = [ handles.magSensor_Points  newValue ];
end
guidata(hObject,handles);

if(isfield(handles,'currPlot_Points'))
    handles.PlotFlags=bitset(handles.PlotFlags,4);
    %Acquire new sample
     newValue1=handles.analogRead_currPlot.read(); %read one sample
    
     %Append new sample to data array
     handles.currPlot_Points=[ handles.currPlot_Points   newValue1 ];
end

guidata( hObject, handles )
plotSequence( handles );
end

% --- Executes on selection change in popupmenu16.
function popupmenu16_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu16 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu16


% --- Executes during object creation, after setting all properties.
function popupmenu16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%create custom pop-up menu
set(hObject,'String',['Pop-up Menu';...
    'X          ';'R          ';'Y          ';char(1012) '          ';...
    'Aux In 1   ';'Aux In 2   ';'Aux In 3   ';'Aux In 4   ']);




% --- Executes on button press in Shot.
function Shot_Callback(hObject, eventdata, handles)
% hObject    handle to Shot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Shot
pause(0.1)

%Send command to Lock-In amp to use shot sampling configuration
sendLockInCommand(handles, 'SEND 0')

%Reset Loop radio button
set( handles.Loop ,'Value', 0);

% --- Executes on button press in Loop.
function Loop_Callback(hObject, eventdata, handles)
% hObject    handle to Loop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Loop
pause(0.1)

%Send command to Lock-In amp to use looping sample configuration
sendLockInCommand(handles, 'SEND 1')

%Reset Shot radio button
set( handles.Shot ,'Value', 0);


% --- Executes during object deletion, before destroying properties.
function InputConfig_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to InputConfig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in TimeConstant.
function TimeConstant_Callback(hObject, eventdata, handles)
% hObject    handle to TimeConstant (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TimeConstant contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TimeConstant
pause(0.1)

%Value of decrement to align drop-down menu selection
decrementValue = 2;

if ( get( hObject ,'Value' ) > 1 )
    %Send command to Lock-in to set time constant configuration
    sendLockInCommand( handles, 'OFLT ' ,hObject, decrementValue )
    
    %Give visual feedback of command completion
    commandFeedback( hObject )
end

% --- Executes during object creation, after setting all properties.
function TimeConstant_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TimeConstant (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

set(hObject,'String',['Pop-up Menu';...
    '10 ' char(956) 's      ';'30 ' char(956) 's      ';'100 ' char(956) 's     ';...
    '300 ' char(956) 's     ';'1 ms       ';'3 ms       ';'10 ms      ';...
    '30 ms      ';'100 ms     ';'300 ms     ';'1 s        ';'3 s        ';'10 s       ';...
    '30 s       ';'100 s      ';'300 s      ';'1 ks       ';'3 ks       ';'10 ks      ';...
    '30 ks      ']);


% --- Executes on key press with focus on DataStore and none of its controls.
function DataStore_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to DataStore (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
pause(0.1);
if query(handles.obj1,'*STB? 1\n')
    fprintf(handles.obj1,'STRT\n');
    set(hObject,'BackgroundColor', 'green');
    set(handles.DataPause,'BackgroundColor',[0.94, 0.94, 0.94]);
    set(hObject,'String', 'Store');
    set(handles.DataPause,'Value',0);
end


% --- Executes on key press with focus on DataPause and none of its controls.
function DataPause_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to DataPause (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
pause(0.1);
if query(handles.obj1,'*STB? 1\n') && get(hObject,'Value')
    fprintf(handles.obj1,'PAUS\n');
    set(hObject,'BackgroundColor', 'red');
    set(handles.DataStore,'BackgroundColor',[0.94, 0.94, 0.94]);
    set(handles.DataStore,'String', 'Resume');
else
    set(handles.DataPause,'Value',0);
end


% --- Executes on key press with focus on DataReset and none of its controls.
function DataReset_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to DataReset (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
pause(0.1);
if query(handles.obj1,'*STB? 1\n') && get(hObject,'Value')
    fprintf(handles.obj1,'REST\n');
    set(handles.DataPause,'BackgroundColor',[0.94, 0.94, 0.94]);
    set(handles.DataStore,'BackgroundColor',[0.94, 0.94, 0.94]);
    set(handles.DataStore,'String', 'Store');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over DataStore.
function DataStore_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to DataStore (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in CurrentPointName.
function CurrentPointName_Callback(hObject, eventdata, handles)
clrdevice(handles.obj1)
% hObject    handle to CurrentPointName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pause(0.1);
if query(handles.obj1,'*STB? 1\n')
   set(handles.CurrentPoint,'String',num2str(query(handles.obj1,'OUTP? 1\n')));
end


% --- Executes during object creation, after setting all properties.
function CH1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CH1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate CH1

xlabel('Sample Count');
ylabel('Channel 1 Voltage(V)');
% --- Executes on selection change in ChannelOne.
function popupmenu19_Callback(hObject, eventdata, handles)
% hObject    handle to ChannelOne (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ChannelOne contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ChannelOne


% --- Executes during object creation, after setting all properties.
function popupmenu19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ChannelOne (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in PlotBothDisplays.
function PlotBothDisplays_Callback(hObject, eventdata, handles)
% hObject    handle to PlotBothDisplays (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 
% clrdevice(handles.obj1);
% 
% if query(handles.obj1,'*STB? 1\n')
%     Q=str2double(strsplit(query(handles.obj1,'TRCA? 1,0,10\n'),','));
%     Q=Q(1:length(Q)-1);
%     plot([1:length(Q)],Q);
% end

pause(0.1);
if query(handles.obj1,'*STB? 1\n')
   fprintf(handles.obj1,horzcat('DDEF 1,',num2str(get(handles.ChannelOne,'Value')-2),',',...
       num2str(get(handles.RatioOne,'Value')-2),'\n'));
end

handles.CH1_Points=[];
handles.CH2_Points=[];

guidata(hObject, handles);

handles.PlotFlags=bitset(handles.PlotFlags,1);
handles.PlotFlags=bitset(handles.PlotFlags,2);


while query( handles.obj1, '*STB? 1\n' )

pause(0.3)

if(isfield(handles, 'CH1_Points'))
   handles.PlotFlags=bitset(handles.PlotFlags,1);
    handles.CH1_Points = [ handles.CH1_Points  str2num( query( handles.obj1, 'OUTR? 1\n' ) ) ];
end
if(isfield(handles,'CH2_Points'))
    handles.PlotFlags=bitset(handles.PlotFlags,2);
    handles.CH2_Points=[handles.CH2_Points str2num(query(handles.obj1,'OUTR? 2\n'))];
    
end

if(isfield(handles,'magSensor_Points'))
    handles.PlotFlags=bitset(handles.PlotFlags,3);
    newValue=handles.analogRead_magSensor.read(); %read one sample
    handles.magSensor_Points=[handles.magSensor_Points newValue ];
end
guidata(hObject,handles);

if(isfield(handles,'currPlot_Points'))
    handles.PlotFlags=bitset(handles.PlotFlags,4);
    %Acquire new sample
     newValue1=handles.analogRead_currPlot.read(); %read one sample
    
     %Append new sample to data array
     handles.currPlot_Points=[ handles.currPlot_Points   newValue1 ];
end

guidata(hObject, handles);
plotSequence(handles);
end


% --- Executes during object creation, after setting all properties.
function Display1Set_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Display1Set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on mouse press over axes background.
function CH1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to CH1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.CH2)


% --- Executes on mouse press over axes background.
function CH2_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to CH2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.CH1)


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Connect2.
function Connect2_Callback(hObject, eventdata, handles)
% hObject    handle to Connect2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if(~isempty(instrfind))
    handles.obj2 = gpib('ni', 0, str2double(get(handles.Addr2,'String')));   
    fopen(handles.obj2);
    set(hObject,'BackgroundColor',[0.0 1.0 0]) %change connect button to green
    set(handles.Disconnect2,'BackgroundColor',[0.5 0.5 0.5]) %change disconnect button to gray
    guidata(hObject, handles)
    
else
     msgbox('Connect Lock-In Amplifier first','Error','error');
    
end


function Addr2_Callback(hObject, eventdata, handles)
% hObject    handle to Addr2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Addr2 as text
%        str2double(get(hObject,'String')) returns contents of Addr2 as a double


% --- Executes during object creation, after setting all properties.
function Addr2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Addr2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Disconnect2.
function Disconnect2_Callback(hObject, eventdata, handles)
% hObject    handle to Disconnect2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fclose(handles.obj2);
delete(handles.obj2);
clear handles.obj2
set(hObject,'BackgroundColor','red')
set(handles.Connect2,'BackgroundColor',[0.5 0.5 0.5])
guidata(hObject, handles)



function Waveform_Callback(hObject, eventdata, handles)
% hObject    handle to Waveform (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Waveform as text
%        str2double(get(hObject,'String')) returns contents of Waveform as a double
pause(0.1);
if 0.001>str2double((get(handles.Freq,'String'))) || str2double((get(handles.Freq,'String')))>10200
    msgbox('Frequency value out range -0.001<Frequency<10200','Error','error');
    
else
    %fprintf(handles.obj2,'SOUR1:VOLT:LEV:IMM:OFFS 0V'); if needed, sets
    %offset voltage to 0
    set(handles.DC_PlusOffset,'Value',0);
    set(handles.DC_MinusOffset,'BackgroundColor',[0.5 0.5 0.5]);
    set(handles.DC_MinusOffset,'Value',0);
    set(handles.DC_PlusOffset,'BackgroundColor',[0.5 0.5 0.5]);
    
        fprintf(handles.obj2,'SOUR1:FUNC:SHAP SQU');
        set(hObject,'BackgroundColor','green');
        pause(0.1);
        set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Waveform_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Waveform (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Phase2_Callback(hObject, eventdata, handles)
% hObject    handle to Phase2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Phase2 as text
%        str2double(get(hObject,'String')) returns contents of Phase2 as a double
pause(0.1);

if -360>str2double((get(handles.Phase,'String'))) || str2double((get(handles.Phase,'String')))>730
    msgbox('Phase value out range -360.00<PHASE<729.99','Error','error');
    
else
    %if query(handles.obj1,'*STB? 1\n')
        fprintf(handles.obj2,horzcat('SOUR1:PHAS:ADJ ',get(hObject,'String'),'DEG'));
        set(hObject,'BackgroundColor','green');
        pause(0.1);
        set(hObject,'BackgroundColor','white');
    %end

end


% --- Executes during object creation, after setting all properties.
function Phase2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Phase2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ampl_Output2_Callback(hObject, eventdata, handles)
% hObject    handle to Ampl_Output2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ampl_Output2 as text
%        str2double(get(hObject,'String')) returns contents of Ampl_Output2 as a double
pause(0.1);

if -360>str2double((get(handles.Phase,'String'))) || str2double((get(handles.Phase,'String')))>730
    msgbox('Phase value out range -360.00<PHASE<729.99','Error','error');
    
else
    %if query(handles.obj1,'*STB? 1\n')
        fprintf(handles.obj2,horzcat('SOUR1:VOLT:LEV:IMM:AMPL ',get(hObject,'String'),'VPP'));
        set(hObject,'BackgroundColor','green');
        pause(0.1);
        set(hObject,'BackgroundColor','white');
    %end

end

% --- Executes during object creation, after setting all properties.
function Ampl_Output2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ampl_Output2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit17 as text
%        str2double(get(hObject,'String')) returns contents of edit17 as a double
pause(0.1);

if -360>str2double((get(handles.Phase,'String'))) || str2double((get(handles.Phase,'String')))>730
    msgbox('Phase value out range -360.00<PHASE<729.99','Error','error');
    
else
    %if query(handles.obj1,'*STB? 1\n')
    format long
        fprintf(handles.obj2,horzcat('SOUR1:FREQ:FIX ',num2str(1/str2double(get(hObject,'String'))),'Hz'));
        set(hObject,'BackgroundColor','green');
        pause(0.1);
        set(hObject,'BackgroundColor','white');
    %end

end

% --- Executes during object creation, after setting all properties.
function edit17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in OutputState.
function OutputState_Callback(hObject, eventdata, handles)
% hObject    handle to OutputState (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of OutputState

pause(0.1);
if (get(hObject,'Value'))
    fprintf(handles.obj2,'OUTP1:STAT ON');
    set(hObject,'BackgroundColor','green');
else
    fprintf(handles.obj2,'OUTP1:STAT OFF');
    set(hObject,'BackgroundColor',[0.5 0.5 0.5]);
end


% --- Executes on button press in DC_PlusOffset.
function DC_PlusOffset_Callback(hObject, eventdata, handles)
% hObject    handle to DC_PlusOffset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of DC_PlusOffset

pause(0.1);
if (get(hObject,'Value'))
    fprintf(handles.obj2,'SOUR1:FUNC:SHAP DC');
    fprintf(handles.obj2,horzcat('SOUR1:VOLT:LEV:IMM:OFFS ',get(handles.DC_Offset,'String'),'V'));
    set(hObject,'BackgroundColor','green');
    set(handles.DC_MinusOffset,'Value',0);
    set(handles.DC_MinusOffset,'BackgroundColor',[0.5 0.5 0.5]);
else
    fprintf(handles.obj2,'SOUR1:VOLT:LEV:IMM:OFFS 0V');
    set(hObject,'BackgroundColor',[0.5 0.5 0.5]);
end


% --- Executes on button press in DC_MinusOffset.
function DC_MinusOffset_Callback(hObject, eventdata, handles)
% hObject    handle to DC_MinusOffset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of DC_MinusOffset

pause(0.1);
if (get(hObject,'Value'))
    fprintf(handles.obj2,'SOUR1:FUNC:SHAP DC');
    fprintf(handles.obj2,horzcat('SOUR1:VOLT:LEV:IMM:OFFS -',get(handles.DC_Offset,'String'),'V'));
    set(hObject,'BackgroundColor','green');
    set(handles.DC_PlusOffset,'Value',0);
    set(handles.DC_PlusOffset,'BackgroundColor',[0.5 0.5 0.5]);
else
    fprintf(handles.obj2,'SOUR1:VOLT:LEV:IMM:OFFS 0V');
    set(hObject,'BackgroundColor',[0.5 0.5 0.5]);
end



function DC_Offset_Callback(hObject, eventdata, handles)
% hObject    handle to DC_Offset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DC_Offset as text
%        str2double(get(hObject,'String')) returns contents of DC_Offset as a double


% --- Executes during object creation, after setting all properties.
function DC_Offset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DC_Offset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pulseTowardMotor.
function pulseTowardMotor_Callback(hObject, eventdata, handles)
% hObject    handle to pulseTowardMotor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
IMPLICIT  = py.nidaqmx.constants.SampleTimingType(10451);
FINITE    = py.nidaqmx.constants.AcquisitionType(10178);
ON_DEMAND = py.nidaqmx.constants.SampleTimingType(10390);

if( isfield( handles , 'pulseTrain' ) )
    handles.pulseTrain.stop()    
else
    %do nothing
end



%Pulse train generator signal
handles.pulseTrain = py.nidaqmx.Task();
counterChannel=handles.pulseTrain.co_channels.add_co_pulse_chan_freq( 'Dev3/ctr0'...
    , pyargs( 'freq' , 500 ,  'duty_cycle' , 0.5 ) );
handles.pulseTrain.timing.samp_timing_type=IMPLICIT; %10451=IMPLICIT timing
numMotorSteps=int64(str2num(get(handles.motorSteps,'String')));
handles.pulseTrain.timing.cfg_implicit_timing(... 
      pyargs( 'sample_mode' , FINITE , 'samps_per_chan' , numMotorSteps ) ); %10178=finite acquisition

%DIR digital signal
handles.pulseDirection=py.nidaqmx.Task();
digitalChannelone=handles.pulseDirection.do_channels.add_do_chan('Dev3/port0/line1'); %Named P0.1 on the physical DAQ
handles.pulseDirection.timing.samp_timing_type = ON_DEMAND; %10390=ON_DEMAND timing


%EN digital signal
handles.motorEnable=py.nidaqmx.Task();
digitalChanneltwo=handles.motorEnable.do_channels.add_do_chan('Dev3/port0/line0'); %Named P0.0 on the physical DAQ
handles.motorEnable.timing.samp_timing_type = ON_DEMAND;

%Run tasks
handles.motorEnable.write( false );

handles.pulseDirection.write( false ); %false is toward the motor

handles.pulseTrain.start();

%save variables
guidata( hObject , handles );


% --- Executes on button press in pulseAwayMotor.
function pulseAwayMotor_Callback(hObject, eventdata, handles)
% hObject    handle to pulseAwayMotor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
IMPLICIT  = py.nidaqmx.constants.SampleTimingType(10451);
FINITE    = py.nidaqmx.constants.AcquisitionType(10178);
ON_DEMAND = py.nidaqmx.constants.SampleTimingType(10390);

%Check if the task has been executed before
if( isfield( handles , 'pulseTrain' ) )
    handles.pulseTrain.stop()
    %handles.pulseTrain.close()
    
else
    %do nothing
end

%Pulse train generator signal
handles.pulseTrain=py.nidaqmx.Task();
counterChannel=handles.pulseTrain.co_channels.add_co_pulse_chan_freq('Dev3/ctr0'...
    , pyargs('freq',500, 'duty_cycle',0.5)); %#find counter physical names
handles.pulseTrain.timing.samp_timing_type = IMPLICIT; %10451=IMPLICIT timing
numMotorSteps=int64(str2num(get(handles.motorSteps,'String')));
handles.pulseTrain.timing.cfg_implicit_timing(...
    pyargs( 'sample_mode' , FINITE , 'samps_per_chan' , numMotorSteps ) ); %10178=finite acquisition

%DIR digital signal
handles.pulseDirection=py.nidaqmx.Task();
digitalChannelone=handles.pulseDirection.do_channels.add_do_chan('Dev3/port0/line1'); %figure out digital pins #di
handles.pulseDirection.timing.samp_timing_type=ON_DEMAND; %10390=ON_DEMAND timing
%% stage platform direction is away from the motor when pulseDirection is written True

%EN digital signal
handles.motorEnable=py.nidaqmx.Task();
digitalChanneltwo=handles.motorEnable.do_channels.add_do_chan('Dev3/port0/line0'); %figure out digital pins
handles.motorEnable.timing.samp_timing_type=ON_DEMAND;

%Run tasks
handles.motorEnable.write(false);
handles.pulseDirection.write(true); %change back to true
handles.pulseTrain.start();

guidata(hObject,handles);



function motorSteps_Callback(hObject, eventdata, handles)
% hObject    handle to motorSteps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of motorSteps as text
%        str2double(get(hObject,'String')) returns contents of motorSteps as a double


% --- Executes during object creation, after setting all properties.
function motorSteps_CreateFcn(hObject, eventdata, handles)
% hObject    handle to motorSteps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% % --- Executes on button press in plotHallVoltage.
% function plotHallVoltage_Callback(hObject, eventdata, handles)
% % hObject    handle to plotHallVoltage (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% RSE       = py.nidaqmx.constants.TerminalConfiguration(10083);
% ON_DEMAND = py.nidaqmx.constants.SampleTimingType(10390);
% 
% handles.analogRead_HallVoltage = py.nidaqmx.Task();
% handles.analogRead_HallVoltage.ai_channels.add_ai_voltage_chan( 'Dev3/ai1',...
%     pyargs( 'min_val', -3.0, 'max_val', 3.0, 'terminal_config', RSE ) );
% handles.analogRead_HallVoltage.timing.samp_timing_type  = ON_DEMAND; %10390=ON_DEMAND timing
% 
% handles.hallBarVoltage_Points = [];
% guidata( hObject, handles )
% 
% while(true)
%     axes( handles.hallBarVoltage );
%     pause( 0.5 )
%     newValue = handles.analogRead_HallVoltage.read(); %read one sample
%     handles.hallBarVoltage_Points=[ handles.hallBarVoltage_Points   newValue ];
%     plot( handles.hallBarVoltage_Points );
% end


% --- Executes on button press in plotMagSensor.
function plotMagSensor_Callback(hObject, eventdata, handles)
% hObject    handle to plotMagSensor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
RSE       = py.nidaqmx.constants.TerminalConfiguration(10083);
ON_DEMAND = py.nidaqmx.constants.SampleTimingType(10390);

resetPlotControl( handles )
resetStopPlot( handles )

handles.analogRead_magSensor = py.nidaqmx.Task();

handles.analogRead_magSensor.ai_channels.add_ai_voltage_chan( 'Dev3/ai0'...
    , pyargs( 'min_val', -10.0, 'max_val', 10.0, 'terminal_config', RSE ) );
handles.analogRead_magSensor.timing.samp_timing_type = ON_DEMAND; %10390=ON_DEMAND timing

handles.magSensor_Points = [];
guidata( hObject, handles )

while( ~get( handles.StopPlot, 'Value' )  ) 
pause(0.3)
if(isfield(handles, 'CH1_Points'))
   handles.PlotFlags=bitset( handles.PlotFlags , 1 );
   newValue = str2num( query( handles.obj1, 'OUTR? 1\n' ) );
   handles.CH1_Points = [ handles.CH1_Points  newValue ];
end
if(isfield(handles,'CH2_Points'))
    handles.PlotFlags = bitset( handles.PlotFlags , 2 );
    newValue = str2num(query(handles.obj1,'OUTR? 2\n'));
    handles.CH2_Points = [ handles.CH2_Points  newValue ];
    
end

if(isfield(handles,'magSensor_Points'))
    handles.PlotFlags = bitset( handles.PlotFlags , 3);
    newValue = handles.analogRead_magSensor.read(); %read one sample
    handles.magSensor_Points = [ handles.magSensor_Points  newValue ];
end
guidata(hObject,handles);

if(isfield(handles,'currPlot_Points'))
    handles.PlotFlags=bitset(handles.PlotFlags,4);
    %Acquire new sample
     newValue1=handles.analogRead_currPlot.read(); %read one sample
    
     %Append new sample to data array
     handles.currPlot_Points=[ handles.currPlot_Points   newValue1 ];
end
    
    guidata(hObject, handles)
    plotSequence(handles);
end


function voltPreAmpPortNum_Callback(hObject, eventdata, handles)
% hObject    handle to voltPreAmpPortNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of voltPreAmpPortNum as text
%        str2double(get(hObject,'String')) returns contents of voltPreAmpPortNum as a double


% --- Executes during object creation, after setting all properties.
function voltPreAmpPortNum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to voltPreAmpPortNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in voltPreAmpPortDisconnect.
function voltPreAmpPortDisconnect_Callback(hObject, eventdata, handles)
% hObject    handle to voltPreAmpPortDisconnect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fclose(handles.voltPreAmpPort);
delete(handles.voltPreAmpPort);
delete(instrfind('Name',horzcat('Serial-COM',get(handles.voltPreAmpPortNum,'String')))); %deletes existing use of the port from other devices
clear handles.voltPreAmpPort
set(hObject,'BackgroundColor','red')
set(handles.voltPreAmpPortConnect,'BackgroundColor',[0.5 0.5 0.5])
guidata(hObject, handles)

% --- Executes on button press in voltPreAmpPortConnect.
function voltPreAmpPortConnect_Callback(hObject, eventdata, handles)
% hObject    handle to voltPreAmpPortConnect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(~isempty(instrfind))
    if(~isempty(instrfind('Name',horzcat('Serial-COM',get(handles.voltPreAmpPortNum,'String')))))
        delete(instrfind('Name',horzcat('Serial-COM',get(handles.voltPreAmpPortNum,'String')))); %deletes existing use of the port from other devices
    else
        %do nothing
    end
else
    %do nothing
end
handles.voltPreAmpPort=serial(horzcat('COM',get(handles.voltPreAmpPortNum,'String')),'DataBits',8,'BaudRate',9600,'Parity','none','StopBits',2,'Terminator','LF/CR');
fopen(handles.voltPreAmpPort);
fprintf(handles.voltPreAmpPort,'LALL')

set(hObject,'BackgroundColor',[0.0 1.0 0]) %change connect button to green
set(handles.voltPreAmpPortDisconnect,'BackgroundColor',[0.5 0.5 0.5]) %change disconnect button to gray
guidata(hObject, handles)

% --- Executes on button press in voltPreAmpBlankIn.
function voltPreAmpBlankIn_Callback(hObject, eventdata, handles)
% hObject    handle to voltPreAmpBlankIn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of voltPreAmpBlankIn

pause(0.1)
%create dummy variable
nullVar=0;

%Send command to voltage preamp to toggle blanking input configuration
sendPreAmpCommand(handles.voltPreAmpPort, 'BLINK ', hObject, nullVar, nullVar)

% --- Executes on selection change in voltPreAmpInConfig.
function voltPreAmpInConfig_Callback(hObject, eventdata, handles)
% hObject    handle to voltPreAmpInConfig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns voltPreAmpInConfig contents as cell array
%        contents{get(hObject,'Value')} returns selected item from voltPreAmpInConfig
pause( 0.1 )
%Value of decrement to align drop-down menu selection
decrementValue = 2;

if ( get( hObject ,'Value' ) > 1 )
    %Send command to voltage preamp to set input config configuration
    sendPreAmpCommand( handles.voltPreAmpPort, 'CPLG ' ,hObject, decrementValue )
    
    %Give visual feedback of command completion
    commandFeedback( hObject )
end
    
    
% --- Executes during object creation, after setting all properties.
function voltPreAmpInConfig_CreateFcn(hObject, eventdata, handles)
% hObject    handle to voltPreAmpInConfig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in voltPreAmpFilterMod.
function voltPreAmpFilterMod_Callback(hObject, eventdata, handles)
% hObject    handle to voltPreAmpFilterMod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns voltPreAmpFilterMod contents as cell array
%        contents{get(hObject,'Value')} returns selected item from voltPreAmpFilterMod
pause( 0.1 )
%Value of decrement to align drop-down menu selection
decrementValue = 2;

if ( get( hObject ,'Value' ) > 1 )
    %Send command to voltage preamp to set filter mode configuration
    sendPreAmpCommand( handles.voltPreAmpPort, 'FLTM ' ,hObject, decrementValue )
    
    %Give visual feedback of command completion
    commandFeedback( hObject )
end

% --- Executes during object creation, after setting all properties.
function voltPreAmpFilterMod_CreateFcn(hObject, eventdata, handles)
% hObject    handle to voltPreAmpFilterMod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in voltPreAmpGain.
function voltPreAmpGain_Callback(hObject, eventdata, handles)
% hObject    handle to voltPreAmpGain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns voltPreAmpGain contents as cell array
%        contents{get(hObject,'Value')} returns selected item from voltPreAmpGain
pause( 0.1 )
%Value of decrement to align drop-down menu selection
decrementValue = 2;

if ( get( hObject ,'Value' ) > 1 )
    %Send command to voltage preamp to set gain configuration
    sendPreAmpCommand( handles.voltPreAmpPort, 'GAIN ' ,hObject, decrementValue )
    
    %Give visual feedback of command completion
    commandFeedback( hObject )
end

% --- Executes during object creation, after setting all properties.
function voltPreAmpGain_CreateFcn(hObject, eventdata, handles)
% hObject    handle to voltPreAmpGain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in voltPreAmpInvOut.
function voltPreAmpInvOut_Callback(hObject, eventdata, handles)
% hObject    handle to voltPreAmpInvOut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of voltPreAmpInvOut
pause(0.1)
%create dummy variable
nullVar=0;

%Send command to voltage preamp to toggle invert output signal configuration
sendPreAmpCommand(handles.voltPreAmpPort, 'INVT ', hObject, nullVar, nullVar)


% --- Executes on selection change in voltPreAmpHighPass.
function voltPreAmpHighPass_Callback(hObject, eventdata, handles)
% hObject    handle to voltPreAmpHighPass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns voltPreAmpHighPass contents as cell array
%        contents{get(hObject,'Value')} returns selected item from voltPreAmpHighPass
 pause( 0.1 )
%Value of decrement to align drop-down menu selection
decrementValue = 2;

if ( get( hObject ,'Value' ) > 1 )
    %Send command to voltage preamp to set high pass filter configuration
    sendPreAmpCommand( handles.voltPreAmpPort, 'HFRQ ' ,hObject, decrementValue )
    
    %Give visual feedback of command completion
    commandFeedback( hObject )
end

% --- Executes during object creation, after setting all properties.
function voltPreAmpHighPass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to voltPreAmpHighPass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in voltPreAmpLowPass.
function voltPreAmpLowPass_Callback(hObject, eventdata, handles)
% hObject    handle to voltPreAmpLowPass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns voltPreAmpLowPass contents as cell array
%        contents{get(hObject,'Value')} returns selected item from voltPreAmpLowPass
pause( 0.1 )
%Value of decrement to align drop-down menu selection
decrementValue = 2;

if ( get( hObject ,'Value' ) > 1 )
    %Send command to voltage preamp to set low pass filter configuration
    sendPreAmpCommand( handles.voltPreAmpPort, 'LFRQ ' ,hObject ,decrementValue )
    
    %Give visual feedback of command completion
    commandFeedback( hObject )
end
% --- Executes during object creation, after setting all properties.
function voltPreAmpLowPass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to voltPreAmpLowPass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in voltPreAmpInpSrc.
function voltPreAmpInpSrc_Callback(hObject, eventdata, handles)
% hObject    handle to voltPreAmpInpSrc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns voltPreAmpInpSrc contents as cell array
%        contents{get(hObject,'Value')} returns selected item from voltPreAmpInpSrc
 pause( 0.1 )
%Value of decrement to align drop-down menu selection
decrementValue = 2;

if ( get( hObject ,'Value' ) > 1 )
    %Send command to voltage preamp to set input source configuration
    sendPreAmpCommand( handles.voltPreAmpPort, 'SRCE ' ,hObject, decrementValue )
    
    %Give visual feedback of command completion
    commandFeedback( hObject )
end
    
    
% --- Executes during object creation, after setting all properties.
function voltPreAmpInpSrc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to voltPreAmpInpSrc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function currPreAmpPortNum_Callback(hObject, eventdata, handles)
% hObject    handle to currPreAmpPortNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of currPreAmpPortNum as text
%        str2double(get(hObject,'String')) returns contents of currPreAmpPortNum as a double


% --- Executes during object creation, after setting all properties.
function currPreAmpPortNum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to currPreAmpPortNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in currPreAmpPortDisconnect.
function currPreAmpPortDisconnect_Callback(hObject, eventdata, handles)
% hObject    handle to currPreAmpPortDisconnect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fclose(handles.currPreAmpPortObject);
delete(handles.currPreAmpPortObject);
delete(instrfind('Name',horzcat('Serial-COM',get(handles.currPreAmpPortNum,'String')))); %deletes existing use of the port from other devices
clear handles.currPreAmpPortObject
set(hObject,'BackgroundColor','red')
set(handles.currPreAmpPortConnect,'BackgroundColor',[0.5 0.5 0.5])
guidata(hObject, handles)

% --- Executes on button press in currPreAmpPortConnect.
function currPreAmpPortConnect_Callback(hObject, eventdata, handles)
% hObject    handle to currPreAmpPortConnect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(~isempty(instrfind))
    if(~isempty(instrfind('Name',horzcat('Serial-COM',get(handles.currPreAmpPortNum,'String')))))
        delete(instrfind('Name',horzcat('Serial-COM',get(handles.currPreAmpPortNum,'String')))); %deletes existing use of the port from other devices
    else
        ;
    end
else
    ;
end
handles.currPreAmpPortObject=serial(horzcat('COM',get(handles.currPreAmpPortNum,'String')),'DataBits',8,'BaudRate',9600,'Parity','none','StopBits',2);
fopen(handles.currPreAmpPortObject);

set(hObject,'BackgroundColor',[0.0 1.0 0]) %change connect button to green
set(handles.currPreAmpPortDisconnect,'BackgroundColor',[0.5 0.5 0.5]) %change disconnect button to gray
guidata(hObject, handles)


% --- Executes on selection change in currPreAmpSens.
function currPreAmpSens_Callback(hObject, eventdata, handles)
% hObject    handle to currPreAmpSens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns currPreAmpSens contents as cell array
%        contents{get(hObject,'Value')} returns selected item from currPreAmpSens
fprintf(handles.currPreAmpPortObject,horzcat('SENS ',num2str(get(hObject,'Value')-2)));
    
if( get( handles.UnCalSens , 'Value' ) ) 
    
    pause(0.1)
    fprintf(handles.currPreAmpPortObject,horzcat('SUCM ',num2str(get(hObject,'Value'))));
    
    if 0 <= str2double( ( get( handles.UnCalSensLvl , 'String' ) ) )  &&...
        str2double( ( get( handles.UnCalSensLvl , 'String' ) ) ) <= 100
    UnCalSensGuiValue = num2str( get ( handles.UnCalSensLvl , 'String' ) );
    fprintf( handles.currPreAmpPortObject , horzcat( 'SUCV ' , UnCalSensGuiValue ) );
    commandFeedback( hObject )
        
else
    %Invalid input value message
    msgbox(' Value out range 0 =< Value =< 100','Error','error');
end
else
    % do nothing
end
% --- Executes during object creation, after setting all properties.
function currPreAmpSens_CreateFcn(hObject, eventdata, handles)
% hObject    handle to currPreAmpSens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

set(hObject,'String',['Pop-up Menu';...
    '1 pA/V     ';'2 pA/V     ';'5 pA/V     ';'10 pA/V    ';'20 pA/V    ';'50 pA/V    ';...
    '100 pA/V   ';'200 pA/V   ';'500 pA/V   ';'1 nA/V     ';...
    '2 nA/V     ';'5 nA/V     ';'10 nA/V    ';'20 nA/V    ';'50 nA/V    ';...
    '100 nA/V   ';'200 nA/V   ';'500 nA/V   ';'1 ' char(956) 'A/V     ';'2 ' char(956) 'A/V     ';...
    '5 ' char(956) 'A/V     ';'10 ' char(956) 'A/V    ';'20 ' char(956) 'A/V    ';'50 ' char(956) 'A/V    ';...
    '100 ' char(956) 'A/V   ';'200 ' char(956) 'A/V   ';'500 ' char(956) 'A/V   ';'1 mA/V     ']);


% --- Executes on button press in currPreAmpInOffset.
function currPreAmpInOffset_Callback(hObject, eventdata, handles)
% hObject    handle to currPreAmpInOffset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of currPreAmpInOffset
pause(0.1)
fprintf(handles.currPreAmpPortObject,horzcat('IOON ',num2str(get(hObject,'Value'))));

% --- Executes on selection change in currPreAmpInOffsetLvl.
function currPreAmpInOffsetLvl_Callback(hObject, eventdata, handles)
% hObject    handle to currPreAmpInOffsetLvl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns currPreAmpInOffsetLvl contents as cell array
%        contents{get(hObject,'Value')} returns selected item from currPreAmpInOffsetLvl
fprintf(handles.currPreAmpPortObject,horzcat('IOLV ',num2str(get(hObject,'Value')-2)));
    set(hObject,'BackgroundColor','green');
    pause(0.1);
    set(hObject,'BackgroundColor','white');
    

% --- Executes during object creation, after setting all properties.
function currPreAmpInOffsetLvl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to currPreAmpInOffsetLvl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


set(hObject,'String',['Pop-up Menu';...
    '1 pA       ';'2 pA       ';'5 pA       ';'10 pA      ';'20 pA      ';'50 pA      ';...
    '100 pA/V   ';'200 pA     ';'500 pA     ';'1 nA       ';...
    '2 nA       ';'5 nA       ';'10 nA      ';'20 nA      ';'50 nA      ';...
    '100 nA     ';'200 nA     ';'500 nA     ';'1 ' char(956) 'A       ';'2 ' char(956) 'A       ';...
    '5 ' char(956) 'A       ';'10 ' char(956) 'A      ';'20 ' char(956) 'A      ';'50 ' char(956) 'A      ';...
    '100 ' char(956) 'A     ';'200 ' char(956) 'A     ';'500 ' char(956) 'A     ';'1 mA       ';...
    '2 mA       ';'5 mA       ']);


% --- Executes on button press in currPreAmpOffsetSign.
function currPreAmpOffsetSign_Callback(hObject, eventdata, handles)
% hObject    handle to currPreAmpOffsetSign (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of currPreAmpOffsetSign
pause(0.1)
fprintf(handles.currPreAmpPortObject,horzcat('IOSN ',num2str(get(hObject,'Value'))));


% --- Executes on button press in currPreAmpBiasOn.
function currPreAmpBiasOn_Callback(hObject, eventdata, handles)
% hObject    handle to currPreAmpBiasOn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of currPreAmpBiasOn
pause(0.1)
fprintf(handles.currPreAmpPortObject,horzcat('BSON ',num2str(get(hObject,'Value'))));



function currPreAmpBiasLvl_Callback(hObject, eventdata, handles)
% hObject    handle to currPreAmpBiasLvl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of currPreAmpBiasLvl as text
%        str2double(get(hObject,'String')) returns contents of currPreAmpBiasLvl as a double
pause(0.1);
if -5000>=str2double((get(handles.currPreAmpBiasLvl,'String'))) || str2double((get(handles.currPreAmpBiasLvl,'String')))>=5000
     msgbox('Voltage(mV) value out range -5000=<Voltage=<5000','Error','error');
        
else
   fprintf(handles.currPreAmpPortObject,horzcat('BSLV ',num2str(get(handles.currPreAmpBiasLvl,'String'))));
    set(hObject,'BackgroundColor','green');
    pause(0.1);
    set(hObject,'BackgroundColor','white');

end


% --- Executes during object creation, after setting all properties.
function currPreAmpBiasLvl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to currPreAmpBiasLvl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in currPreAmpFilterMod.
function currPreAmpFilterMod_Callback(hObject, eventdata, handles)
% hObject    handle to currPreAmpFilterMod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns currPreAmpFilterMod contents as cell array
%        contents{get(hObject,'Value')} returns selected item from currPreAmpFilterMod
fprintf(handles.currPreAmpPortObject,horzcat('FLTT ',num2str(get(hObject,'Value')-2)));
    set(hObject,'BackgroundColor','green');
    pause(0.1);
    set(hObject,'BackgroundColor','white');
    

% --- Executes during object creation, after setting all properties.
function currPreAmpFilterMod_CreateFcn(hObject, eventdata, handles)
% hObject    handle to currPreAmpFilterMod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in currPreAmpHighPass.
function currPreAmpHighPass_Callback(hObject, eventdata, handles)
% hObject    handle to currPreAmpHighPass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns currPreAmpHighPass contents as cell array
%        contents{get(hObject,'Value')} returns selected item from currPreAmpHighPass
fprintf(handles.currPreAmpPortObject,horzcat('HFRQ ',num2str(get(hObject,'Value')-2)));
    set(hObject,'BackgroundColor','green');
    pause(0.1);
    set(hObject,'BackgroundColor','white');
    

% --- Executes during object creation, after setting all properties.
function currPreAmpHighPass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to currPreAmpHighPass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in currPreAmpLowPass.
function currPreAmpLowPass_Callback(hObject, eventdata, handles)
% hObject    handle to currPreAmpLowPass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns currPreAmpLowPass contents as cell array
%        contents{get(hObject,'Value')} returns selected item from currPreAmpLowPass
fprintf(handles.currPreAmpPortObject,horzcat('LFRQ ',num2str(get(hObject,'Value')-2)));
    set(hObject,'BackgroundColor','green');
    pause(0.1);
    set(hObject,'BackgroundColor','white');
    

% --- Executes during object creation, after setting all properties.
function currPreAmpLowPass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to currPreAmpLowPass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in currPreAmpGainMod.
function currPreAmpGainMod_Callback(hObject, eventdata, handles)
% hObject    handle to currPreAmpGainMod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns currPreAmpGainMod contents as cell array
%        contents{get(hObject,'Value')} returns selected item from currPreAmpGainMod
fprintf(handles.currPreAmpPortObject,horzcat('GNMD ',num2str(get(hObject,'Value')-2)));
    set(hObject,'BackgroundColor','green');
    pause(0.1);
    set(hObject,'BackgroundColor','white');
    
    

% --- Executes during object creation, after setting all properties.
function currPreAmpGainMod_CreateFcn(hObject, eventdata, handles)
% hObject    handle to currPreAmpGainMod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in currPreAmpInvOut.
function currPreAmpInvOut_Callback(hObject, eventdata, handles)
% hObject    handle to currPreAmpInvOut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of currPreAmpInvOut

pause(0.1)
fprintf(handles.currPreAmpPortObject,horzcat('INVT ',num2str(get(hObject,'Value'))));



function DAQtoVoltPreAmp_Callback(hObject, eventdata, handles)
% hObject    handle to DAQtoVoltPreAmp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DAQtoVoltPreAmp as text
%        str2double(get(hObject,'String')) returns contents of DAQtoVoltPreAmp as a double

%create task to execute

% if(isfield(handles,'DAQtoVoltPreAmp'))
%     handles.DAQtoVoltPreAmp.stop()
%     handles.DAQtoVoltPreAmp.close()
% end

handles.DAQtoVoltPreAmp=py.nidaqmx.Task(); 

%create channel, make sure correct device and channel are based on phyiscal
%connections
handles.DAQtoVoltPreAmp.ao_channels.add_ao_voltage_chan('Dev3/ao0',pyargs('min_val',-5.0,'max_val',5.0));

%Set ON_DEMAND(constant=10390) timing to change voltage with software on demand
handles.DAQtoVoltPreAmp.timing.samp_timing_type=py.nidaqmx.constants.SampleTimingType(10390);

%Execute task
handles.DAQtoVoltPreAmp.write(str2double(get(hObject,'String')));

%Clear task after completion
%handles.DAQtoVoltPreAmp.close()

%Give visual feedback of voltage change execution in GUI
set(hObject,'BackgroundColor','green');
pause(0.1);
set(hObject,'BackgroundColor','white');
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function DAQtoVoltPreAmp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DAQtoVoltPreAmp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in plotCurr.
function plotCurr_Callback(hObject, eventdata, handles)
% hObject    handle to plotCurr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

NRSE       = py.nidaqmx.constants.TerminalConfiguration(10078);
ON_DEMAND = py.nidaqmx.constants.SampleTimingType(10390);

resetPlotControl( handles )
resetStopPlot( handles )

%Create array to hold data points
handles.currPlot_Points=[];

%Create task to execute
handles.analogRead_currPlot=py.nidaqmx.Task();

%Create channel to read signal, make sure it corrsponds with physical
%connection, ground is connect to AI Sense to the Amplifier chasis
handles.analogRead_currPlot.ai_channels.add_ai_voltage_chan('Dev3/ai1'...
    , pyargs( 'min_val', -6.000, 'max_val', 6.000, 'terminal_config', NRSE ) );

%Set constant to 10390=ON_DEMAND timing to use software to read signals on demand
handles.analogRead_currPlot.timing.samp_timing_type = ON_DEMAND; 

% plot to currPlot axes
guidata(hObject,handles);

while( ~get( handles.StopPlot, 'Value' )  ) 
pause(0.3)
if(isfield(handles, 'CH1_Points'))
   handles.PlotFlags=bitset( handles.PlotFlags , 1 );
   newValue = str2num( query( handles.obj1, 'OUTR? 1\n' ) );
   handles.CH1_Points = [ handles.CH1_Points  newValue ];
end
if(isfield(handles,'CH2_Points'))
    handles.PlotFlags = bitset( handles.PlotFlags , 2 );
    newValue = str2num(query(handles.obj1,'OUTR? 2\n'));
    handles.CH2_Points = [ handles.CH2_Points  newValue ];
    
end

if(isfield(handles,'magSensor_Points'))
    handles.PlotFlags = bitset( handles.PlotFlags , 3);
    newValue = handles.analogRead_magSensor.read(); %read one sample
    handles.magSensor_Points = [ handles.magSensor_Points  newValue ];
end
guidata(hObject,handles);

if(isfield(handles,'currPlot_Points'))
    handles.PlotFlags=bitset(handles.PlotFlags,4);
    %Acquire new sample
     newValue1=handles.analogRead_currPlot.read(); %read one sample
    
     %Append new sample to data array
     handles.currPlot_Points=[ handles.currPlot_Points   newValue1 ];
end
    
    guidata(hObject, handles)
    plotSequence(handles);
end


% --- Executes on button press in saveFigs.

function saveFigs_Callback(hObject, eventdata, handles)
% hObject    handle to saveFigs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiwait


if(isfield(handles,'currPlot_Points'))
    fileID=(horzcat('Current Flow Plot_',datestr(clock,30),'.csv'));
    [ file , path ] = uiputfile(fileID,'Save Current Flow plot');
    fopen( path/file , 'w' );
    dlmwrite(fileID,[handles.currPlot_Points]','delimiter','\n','newline','pc');
end


if(isfield(handles,'magSensor_Points'))
    fileID=(horzcat('Magnetic Sensor Plot_',datestr(clock,30),'.csv'));
    [ file , path ] = uiputfile(fileID,'Save Magnetic Sensor plot');
    fopen( path/file , 'w' );
    dlmwrite(fileID,[handles.magSensor_Points]','delimiter','\n','newline','pc');
end
 
 if(isfield(handles,'CH1_Points'))
    fileID=(horzcat('Channel One Plot_',datestr(clock,30),'.csv'));
    [ file , path ] = uiputfile(fileID,'Save Channel One plot');
    fopen( path/file , 'w' );
    dlmwrite(fileID,[handles.CH1_Points]','delimiter','\n','newline','pc');
end

if(isfield(handles,'CH2_Points'))
    fileID=(horzcat('Channel Two Plot_',datestr(clock,30),'.csv'));
    [ file , path ] = uiputfile(fileID,'Save Channel Two plot');
    fopen( path/file , 'w' );
    fopen(fileID,'w');
    dlmwrite(fileID,[handles.CH2_Points]','delimiter','\n','newline','pc');
end


uiresume


% --- Executes during object deletion, before destroying properties.
function plotMagSensor_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to plotMagSensor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if( isfield( handles , 'analogRead_magSensor' ) )
    handles.analogRead_magSensor.stop()
    handles.analogRead_magSensor.close()
    
else
    %do nothing
end

% --- Executes on button press in plotControl.
function plotControl_Callback(hObject, eventdata, handles)
% hObject    handle to plotControl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of plotControl
if( get( hObject ,'Value' ) )
    set( hObject , 'BackgroundColor', 'red' )
    set( hObject , 'String' , 'Resume Plotting' )
    uiwait
else
    uiresume
    set( hObject , 'BackgroundColor', [ 0.94 0.94 0.94 ] )
    set( hObject , 'String' , 'Pause Plotting' )
end

%guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function plotControl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plotControl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

%create variable to enable GUI plotting axes
%4-bit flags, all set to 0s
%LSB->MSB for each axis:
%CH1--CH2--magSensor--CurrPlot 
handles.PlotFlags = fi( 0 ,0 ,4 ,0 );

%create variable to control resume/pause of plotting GUI axes
% handles.toResumePlot      = interrupt_handler();

% handles.PlotFlags=bitset(handles.PlotFlags,1)
% handles.PlotFlags.bin
% guidata( hObject, handles );
% handles.PlotFlags=bitset(handles.PlotFlags,2)
% guidata( hObject, handles );
% handles.PlotFlags.bin
% handles.toResumePlot.Value='yes';
% handles.plotContinue='yes';

guidata( hObject, handles );


% --- Executes during object creation, after setting all properties.
function plotCurr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plotCurr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


function plotCH1(handles)
    axes( handles.CH1 );
    plot( handles.CH1_Points );


function plotCH2(handles)
    axes(handles.CH2);
    plot(handles.CH2_Points);


function plotMagSensor(handles)
    axes(handles.magSensor);
    plot(handles.magSensor_Points);

function plotCurrPlot(handles)
    menuOffset=2;
    CurrentSensSetting= get( handles.currPreAmpSens , 'Value') - menuOffset;
    plotMultiplier = [ 1 2 5 10 20 50 200 200 500 ];
    labelMultiplierSelect = mod( CurrentSensSetting , 9 ) + 1;
    vernierMax = 100;
    vernierGain = vernierMax/get( handles.UnCalSensLvl , 'Value' ); 
    
    
    %set axes to plot in
    axes( handles.currPlot );
    
    %Labels for Y-axis
    yLabelMenu = [
    'p';...
    'n';...
    char(956);...
    'm'; ];
    
    mAselectLvl=27;
    uAselectLvl_low=19;
    uAselectLvl_high=26;
    nAselectLvl_low=10;
    nAselectLvl_high=18;
    
    %plot to axes
    if( get( handles.UnCalSens , 'Value' ) )
        
        %include uncalibrated sensitvity
        plot( vernierGain * plotMultiplier( labelMultiplierSelect ) * handles.currPlot_Points );
    else
        
        %exclude uncalibrated sensitivity
        plot( plotMultiplier( labelMultiplierSelect ) * handles.currPlot_Points );
    end

    %Select label based on previously selected current sensitivity of amp
    if (CurrentSensSetting==mAselectLvl)
        ylabel(horzcat( 'Current(' , yLabelMenu(4) , 'A)') )
    elseif (CurrentSensSetting>= uAselectLvl_low && CurrentSensSetting <=uAselectLvl_high)
        ylabel(horzcat( 'Current(' , yLabelMenu(3) , 'A)') )
    elseif (CurrentSensSetting>= nAselectLvl_low && CurrentSensSetting <=nAselectLvl_high)
        ylabel(horzcat( 'Current(' , yLabelMenu(2) , 'A)') )
    else
        %select pA label
        ylabel(horzcat( 'Current(' , yLabelMenu(1) , 'A)') )
    end
    
    
function plotSequence(handles)
switch bin2dec(handles.PlotFlags.bin)
    case 1
        plotCH1(handles)
    case 2
        plotCH2(handles)
    case 3
        plotCH1(handles)
        plotCH2(handles)
    case 4
        plotMagSensor(handles)
    case 5
        plotCH1(handles)
        plotMagSensor(handles)
    case 6
        plotCH2(handles)
        plotMagSensor(handles)
    case 7
        plotCH1(handles)
        plotCH2(handles)
        plotMagSensor(handles)
    case 8
        plotCurrPlot(handles)
    case 9
        plotCH1(handles)
        plotCurrPlot(handles)
    case 10
        plotCH2(handles)
        plotCurrPlot(handles)
    case 11
        plotCH1(handles)
        plotCH2(handles)
        plotCurrPlot(handles)
    case 12
        plotMagSensor(handles)
        plotCurrPlot(handles)
    case 13
        plotCH1(handles)
        plotMagSensor(handles)
        plotCurrPlot(handles)
    case 14
        plotCH2(handles)
        plotMagSensor(handles)
        plotCurrPlot(handles)
    case 15
        plotCH1(handles)
        plotCH2(handles)
        plotMagSensor(handles)
        plotCurrPlot(handles)
end


function sendLockInCommand( handles ,command ,varargin )
%determine the number of optional arguments
numOptionalAgruments=nargin;

%Find if the Lock-In Amplifier is ready for a new command
if query(handles.obj1,'*STB? 1\n')
    switch numOptionalAgruments
        case 2
            %execute command with not optional arguments(i.e. no text field arguments)   
            fprintf(handles.obj1,horzcat(command,'\n'));
        
        case 3
            %execute command with a single text field arguement
            fprintf(handles.obj1 ,horzcat(command ,num2str(get(varargin{1},'String')),'\n'));
        
        case 4
            %execute command with drop-down menu
            fprintf(handles.obj1 ,horzcat(command ,num2str( get( varargin{1} ,'Value' )-varargin{2} ), '\n' ) );
        
        otherwise 
            %execute radio button with value command
            fprintf(handles.obj1 ,horzcat(command, num2str( get( varargin{1} ,'Value' ) ) ,'\n' ) );
    end
end

function sendPreAmpCommand( port ,command ,varargin )
%determine the number of optional arguments
numOptionalAgruments=nargin;

%Find if the Lock-In Amplifier is ready for a new command
switch numOptionalAgruments
    case 2
        %execute command with not optional arguments(i.e. no text field arguments)
        fprintf(port,command);
        
    case 3
        %execute command with a single text field arguement
        fprintf(port,horzcat(command ,num2str(get(varargin{1},'String'))));
        
    case 4
        %execute command with drop-down menu
        fprintf(port ,horzcat(command ,num2str( get( varargin{1} ,'Value' )-varargin{2} ) ) );
        
    otherwise
        %execute radio button with value command
        fprintf(port ,horzcat(command, num2str( get( varargin{1} ,'Value' ) ) ) );
end


function commandFeedback( hObject )

set(hObject,'BackgroundColor','green');

pause(0.1);

set(hObject,'BackgroundColor','white');


% --- Executes during object creation, after setting all properties.
function magSensor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to magSensor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate magSensor

%set axes labels
xlabel( 'Sample Count' );
ylabel( 'Hall Element Voltage(V)' );


% --- Executes during object creation, after setting all properties.
function currPlot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to currPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate currPlot

%set axes labels
xlabel( 'Sample Count' );
ylabel( 'Current Preamp Voltage(V)' );


% --- Executes during object creation, after setting all properties.
function CH2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CH2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate CH2

%set axes labels
xlabel( 'Sample Count' );
ylabel( 'Channel 2 Voltage(V)' );


% --- Executes during object deletion, before destroying properties.
function plotControl_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to plotControl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object deletion, before destroying properties.
function pulseTowardMotor_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to pulseTowardMotor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%Check if the task has been executed before


if( isfield( handles , 'pulseTrain' ) )
    handles.pulseTrain.stop()
    handles.pulseTrain.close()
    
else
    %do nothing
end

if( isfield( handles , 'pulseDirection' ) )
    handles.pulseDirection.stop()
    handles.pulseDirection.close()
    
else
    %do nothing
end

if( isfield( handles , 'motorEnable' ) )
    handles.motorEnable.stop()
    handles.motorEnable.close()
    
else
    %do nothing
end


% --- Executes during object deletion, before destroying properties.
function plotCurr_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to plotCurr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if( isfield( handles , 'analogRead_currPlot' ) )
    handles.analogRead_currPlot.stop()
    handles.analogRead_currPlot.close()
    
else
    %do nothing
end


% --- Executes during object deletion, before destroying properties.
function Display1Set_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to Display1Set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object deletion, before destroying properties.
function Connect_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to Connect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if( ~isempty( instrfind ) )
    if( ~isempty( instrfind( 'Name' ,horzcat('GPIB0-' ,get( handles.Addr , 'String' ) ) ) ) )
        delete(instrfind('Name',horzcat('GPIB0-',get(handles.Addr,'String')))); %deletes existing use of the port from other devices
    else
        %do nothing
    end
else
    %do nothing
end


% --- Executes during object deletion, before destroying properties.
function voltPreAmpPortConnect_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to voltPreAmpPortConnect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(~isempty(instrfind))
    if(~isempty(instrfind('Name',horzcat('Serial-COM',get(handles.voltPreAmpPortNum,'String')))))
        delete(instrfind('Name',horzcat('Serial-COM',get(handles.voltPreAmpPortNum,'String')))); %deletes existing use of the port from other devices
    else
        %do nothing
    end
else
    %do nothing
end


% --- Executes during object deletion, before destroying properties.
function currPreAmpPortConnect_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to currPreAmpPortConnect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(~isempty(instrfind))
    if(~isempty(instrfind('Name',horzcat('Serial-COM',get(handles.voltPreAmpPortNum,'String')))))
        delete(instrfind('Name',horzcat('Serial-COM',get(handles.voltPreAmpPortNum,'String')))); %deletes existing use of the port from other devices
    else
        %do nothing
    end
else
    %do nothing
end


% --- Executes during object deletion, before destroying properties.
function DAQtoVoltPreAmp_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to DAQtoVoltPreAmp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if( isfield( handles , 'DAQtoVoltPreAmpLvl' ) )
    handles.DAQtoVoltPreAmp.stop()
    handles.DAQtoVoltPreAmp.close()
    
else
    %do nothing
end


% --- Executes on button press in StopPlot.
function StopPlot_Callback(hObject, eventdata, handles)
% hObject    handle to StopPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of StopPlot

set(hObject, 'BackgroundColor', 'red')

uiresume
set( handles.plotControl, 'Value', 0 )
set( handles.plotControl, 'String', 'Pause Plotting' )
set( handles.plotControl , 'BackgroundColor', [ 0.94 0.94 0.94 ] )


% --- Executes on button press in UnCalSens.
function UnCalSens_Callback(hObject, eventdata, handles)
% hObject    handle to UnCalSens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of UnCalSens

pause(0.1)
fprintf(handles.currPreAmpPortObject,horzcat('SUCM ',num2str(get(hObject,'Value'))));



function UnCalSensLvl_Callback(hObject, eventdata, handles)
% hObject    handle to UnCalSensLvl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of UnCalSensLvl as text
%        str2double(get(hObject,'String')) returns contents of UnCalSensLvl as a double

pause( 0.1 );

if 0 <= str2double( ( get( handles.UnCalSensLvl , 'String' ) ) )  &&...
        str2double( ( get( handles.UnCalSensLvl , 'String' ) ) ) <= 100
    UnCalSensGuiValue = num2str( get ( handles.UnCalSensLvl , 'String' ) );
    fprintf( handles.currPreAmpPortObject , horzcat( 'SUCV ' , UnCalSensGuiValue ) );
    commandFeedback( hObject )
        
else
    %Invalid input value message
    msgbox(' Value out range 0 =< Value =< 100','Error','error');
end


% --- Executes during object creation, after setting all properties.
function UnCalSensLvl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to UnCalSensLvl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function resetPlotControl( handles )

set( handles.plotControl, 'Value' , 0 )
set( handles.plotControl, 'String', 'Pause Plotting' )
set( handles.plotControl , 'BackgroundColor', [ 0.94 0.94 0.94 ] )

function resetStopPlot( handles )

set( handles.StopPlot, 'Value' , 0 )
set( handles.StopPlot , 'BackgroundColor', [ 0.94 0.94 0.94 ] )
