%% Initialization: Put all your .txt in the same folder as this file
% IMPORT DATA OPTION: y (existing dataset) or n (new .txt file)
importdata='y';
%% INSERT FILE NAME HERE, USE IF IMPORTING FROM NEW (importdata='n')
% filename='Groupmonday_Nov2_Test1S1';
initialize

filename=thu_s1c3; % USE IF IMPORT FROM EXISTING (importdata='y')
[testcase,b]=readdata(filename,importdata);
%% Manual data cleanup
data.time=testcase.Time_S;
data.force=testcase.Fz_N;
data.eps=testcase.Position_z__Mm;

%% Variable and model prep
% Find maximum stress
s0_max=max(data.force); % max stress
s0_loc=find(data.force==s0_max,1,'first'); %find index of maxstress
eps0=max(data.eps)-min(data.eps); % Find maximum strain
% Legacy line to use with built-in curve-fitting
% time=data.time(sig_loc:end);Fz=data.Fz(sig_loc:end);
% time=data.time(1:sig_loc-1);Fz=data.Fz(1:sig_loc-1);
%% Curve fit relaxation with independent variable t
% GUESS q0 q1 p1
q0=480; q1=4790; p1=.9; % p1=16.5959;q0=1.2893;q1=23.2326;
run models.m;
model=modelLib.relax_3es; % Change model here
% model_relax=relax_2es;

% Run curve fit 10 times
[data.relax,gof.relax,gof.relax.output]=...
    visco_fit(model,data,s0_loc,n,q0,q1,p1);
table=[data.relax.q0,data.relax.q1,data.relax.p1,gof.relax.sse,gof.relax.rsquare,gof.relax.rmse];
%% Run fit #n times using selected model with updated guess
% GUESS q0 q1 p1
q0=268; q1=4.073e-07; p1=0.137;
model_ramp=modelLib.linear;
% model_ramp=modelLib.ramp_3es;

[data.ramp_3es,gof.ramp_3es,gof.ramp_3es.output]=...
    visco_fit(modelLib.ramp_3es,data,s0_loc,n,q0,q1,p1);
table(2,:)=[data.ramp_3es.q0,data.ramp_3es.q1,data.ramp_3es.p1,gof.ramp_3es.sse,gof.ramp_3es.rsquare,gof.ramp_3es.rmse];
[data.ramp_lin,gof.ramp_lin,gof.ramp_lin.output]=...
    visco_fit(modelLib.linear,data,s0_loc,n,q0,q1,p1);
table(3,:)=[data.ramp_lin.p1,data.ramp_lin.p2,0,gof.ramp_lin.sse,gof.ramp_lin.rsquare,gof.ramp_lin.rmse];
%% Plotting relaxation
% Raw data
close all
plotraw(data)
legend('Stress','Strain','location','east')

% Ramp plot
plotramp(data,s0_loc)
legend('Stress','Linear Ramp Fit','3ES Ramp Fit','Strain',...
    'location','south')

% Relaxation plot
plotrelax(data,s0_loc)
legend('Stress','Relaxation Curve Fit')
disp(table)