Sampling_rate = 1e6;
N = 1e4;
Vpp = 1;
Voff = 0;

%{
x = (1:(Sampling_rate/0.01));
disp(x);

y = (1:10);
disp(y);
%}

VDAC = (Vpp/2)*sin(((2*pi/N)*(1:(Sampling_rate/0.01))-(2*pi/N)))'+Voff;
disp(VDAC);
