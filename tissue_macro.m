%% Initialization: Put all your .txt in the same folder as this file
% IMPORT DATA OPTION: y (existing dataset) or n (new .txt file)
globals

%% INSERT FILE NAME HERE, USE IF IMPORTING FROM NEW (importdata='n')
initialize
filename='Nov13Find-Relaxation20%20%S1';
[testcase,b]=readdata(filename);
%% Manual data cleanup
data.time=testcase.Time_S;
data.force=testcase.Fz_N;
data.eps=testcase.Position_z__Mm;

%% Variable and model prep
% Find maximum stress
s0_max=max(data.force); % max stress
s0_loc=find(data.force==s0_max,1,'first'); %find index of maxstress
eps0=max(data.eps)-min(data.eps); % Find maximum strain

save_data
% Legacy line to use with built-in curve-fitting
% time=data.time(sig_loc:end);Fz=data.Fz(sig_loc:end);
% time=data.time(1:sig_loc-1);Fz=data.Fz(1:sig_loc-1);
%% Curve fit relaxation with independent variable t
% GUESS q0 q1 p1
data.relax.q0=480; data.relax.q1=4790; data.relax.p1=.9; % p1=16.5959;q0=1.2893;q1=23.2326;
run models.m;
model=modelLib.relax_3es; % Change model here
% model_relax=relax_2es;
% Run curve fit 10 times
[data.relax,gof.relax,gof.relax.output]=...
    visco_fit(model,data,s0_loc,n,data.relax.q0,data.relax.q1,data.relax.p1);
goF=[data.relax.q0,data.relax.q1,data.relax.p1,...
    gof.relax.sse,gof.relax.rsquare,gof.relax.rmse];
%% Run fit #n times using selected model with updated guess
% GUESS q0 q1 p1
data.ramp.q0=268; data.ramp.q1=4.073e-07; data.ramp.p1=0.137;
model_ramp=modelLib.linear;
% model_ramp=modelLib.ramp_3es;

% Ramp Curve Fit
[data.ramp_3es,gof.ramp_3es,gof.ramp_3es.output]=...
    visco_fit(modelLib.ramp_3es,data,s0_loc,n,...
    data.ramp.q0,data.ramp.q1,data.ramp.p1);
goF(2,:)=[data.ramp_3es.q0,data.ramp_3es.q1,data.ramp_3es.p1,...
    gof.ramp_3es.sse,gof.ramp_3es.rsquare,gof.ramp_3es.rmse];

% Linear Curve Fit
[data.ramp_lin,gof.ramp_lin,gof.ramp_lin.output]=...
    visco_fit(modelLib.linear,data,s0_loc,n,...
    data.ramp.q0,data.ramp.q1,data.ramp.p1);
goF(3,:)=[data.ramp_lin.p1,data.ramp_lin.p2,0,...
    gof.ramp_lin.sse,gof.ramp_lin.rsquare,gof.ramp_lin.rmse];
%% Plotting relaxation
% Raw data

plotraw(data)
legend('Stress','Strain','location','east')

% Ramp plot
plotramp(data,s0_loc)
legend('Stress','Linear Ramp Fit','3ES Ramp Fit','Strain',...
    'location','south')

% Relaxation plot
plotrelax(data,s0_loc)
legend('Stress','Relaxation Curve Fit')

fprintf('Summarized Parameter and Goodness of Fit Table \n')
disp(array2table(goF,'variablenames',...
    {'q0','q1','p1','SSE','RSquare','Root Mean Square'})); 

%% Normalized relaxation curve
norm_fig=plot_norm_relax(time,force,s0_loc_save,s0_max_save,save_count);
% legend('10%-0.1%','10%-20%','20%-0.1%','20%-20%','10%-20%','20%-0.1%')

save_data