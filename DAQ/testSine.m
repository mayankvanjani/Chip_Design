function [] = USB6363_VARIOUS_SINEWAVE_GENERATOR(Vpp,Voff,frequency)

%%  CREATING INPUT SIGNAL 
close all;
clc;

%%  START DAQ SETUP  
Sampling_rate = 1.024e6;

daqreset;
daqSession = daq.createSession('ni');
daqSession.Rate = Sampling_rate;
daqSession.IsContinuous = true;
addAnalogOutputChannel(daqSession,'Dev1',0,'Voltage');

%% Voltage waveform
N = Sampling_rate/frequency;
VDAC = (Vpp/2) * sin(((2*pi/N)*(1:(Sampling_rate/0.01)) - (2*pi/N)))' + Voff;

queueOutputData(daqSession,VDAC);
startBackground(daqSession);
%startForeground(daqSession);

pause(10);
daqSession.stop();

%% Clean up and release hardware
pause(0.1);
%delete(lh);
daqSession.release();
delete(daqSession);

clear daqSession;
disp('Finished');
end