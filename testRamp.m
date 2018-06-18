function [] = USB6363_RAMP_GENERATOR

%%  CREATING INPUT SIGNAL 
close all;
clc;

%%  START DAQ SETUP  
Sampling_rate = 1.024e6;

daqreset;
daqSession = daq.createSession('ni');
daqSession.Rate = Sampling_rate;
daqSession.IsContinuous = 1;
addAnalogOutputChannel(daqSession,'Dev1',(0:1),'Voltage');

%% Voltage waveform
ramp1_s = 0.9;
ramp1_t = 2.6;
ramp2_s = 0.5;
ramp2_t = 3.9;

N      =(4.25/1000)*Sampling_rate;
N_dc   =(91.5/1000)*Sampling_rate;
step1  =(ramp1_t-ramp1_s)/N;
step2  =(ramp2_t-ramp2_s)/N;
ramp1=[linspace(ramp1_s,ramp1_t,(N+1)) linspace((ramp1_t-step1),ramp1_s,N) ramp1_s*ones(1,N_dc)]';
ramp2=[linspace(ramp2_s,ramp2_t,(N+1)) linspace((ramp2_t-step2),ramp2_s,N) ramp2_s*ones(1,N_dc)]';

ramp1tmp = ramp1;
ramp2tmp = ramp2;
cycle = 1006;

for(k1=1:(cycle-1))
    ramp1tmp = [ramp1tmp;ramp1];
    ramp2tmp = [ramp2tmp;ramp2];
end

VDAC = [ramp1tmp ramp2tmp];

queueOutputData(daqSession,VDAC);
startBackground(daqSession);
pause(1000*(2*N+N_dc)/Sampling_rate);
daqSession.stop();

%% Clean up and release hardware
pause(0.1);
%delete(lh);
daqSession.release();
delete(daqSession);

clear daqSession;
end