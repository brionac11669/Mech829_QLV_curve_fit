%% Initialization: Put all your .txt in the same folder as this file
addpath('utilities','dataset')
%% INSERT FILE NAME/data table import HERE
savedata='y';importdata='n';
filename='Groupmonday_Nov2_Test4S120%';
%% Importing data based on settting & manual cleanup
initialize
[data,b]=read_data(filename);
%% Parameter Guess & Model Selection
data.relax.q0=480; data.relax.q1=4790; data.relax.p1=.9;
data.ramp.q0=268; data.ramp.q1=4.073e-07; data.ramp.p1=0.137;
% p1=16.5959; q0=1.2893; q1=23.2326;
run models.m;

% Change model here
model_relax=modelLib.relax_3es;
model_ramp=modelLib.linear;
% model_relax=relax_2es;
% model_ramp=modelLib.ramp_3es;
%% Variable and model prep
% Find maximum stress
s0_max(save_count)=max(data.force); % max stress
s0_loc(save_count)=find(data.force==s0_max(save_count),1,'first'); %find index of maxstress
eps0(save_count)=max(data.eps)-min(data.eps); % Find maximum strain

save_data

%% Relaxation fit #n times using selected model with updated guess

% Run curve fit 10 times
[data.relax,gof.relax,gof.relax.output]=...
    visco_fit(model_relax,data,s0_loc(save_count),n,...
    data.relax.q0,data.relax.q1,data.relax.p1);

goF{save_count}=[data.relax.q0,data.relax.q1,data.relax.p1,...
    gof.relax.sse,gof.relax.rsquare,gof.relax.rmse];
%% Ramp fit #n times using selected model with updated guess
% Ramp Curve Fit
[data.ramp_3es,gof.ramp_3es,gof.ramp_3es.output]=...
    visco_fit(modelLib.ramp_3es,data,s0_loc(save_count),n,...
    data.ramp.q0,data.ramp.q1,data.ramp.p1);
goF{save_count}(2,:)=[data.ramp_3es.q0,data.ramp_3es.q1,data.ramp_3es.p1,...
    gof.ramp_3es.sse,gof.ramp_3es.rsquare,gof.ramp_3es.rmse];

% Linear Curve Fit
[data.ramp_lin,gof.ramp_lin,gof.ramp_lin.output]=...
    visco_fit(modelLib.linear,data,s0_loc(save_count),n,...
    data.ramp.q0,data.ramp.q1,data.ramp.p1);
goF{save_count}(3,:)=[data.ramp_lin.p1,data.ramp_lin.p2,0,...
    gof.ramp_lin.sse,gof.ramp_lin.rsquare,gof.ramp_lin.rmse];
%% Plotting relaxation
% Raw data

raw_fig=plotraw(data);
legend('Stress','Strain','location','east')

% Ramp plot
ramp_fig=plotramp(data,s0_loc(save_count));
legend('Stress','Linear Ramp Fit','3ES Ramp Fit','Strain',...
    'location','south')

% Relaxation plot
relax_fig=plotrelax(data,s0_loc(save_count));
legend('Stress','Relaxation Curve Fit')

fprintf('Summarized Parameter and Goodness of Fit Table \n')
disp(array2table(goF{save_count},'variablenames',...
    {'q0','q1','p1','SSE','RSquare','Root Mean Square'})); 

%% Normalized relaxation curve
[norm_fig,count]=plot_norm_relax...
    (data.time,data.force,s0_loc,s0_max,save_count);
% legend('10%-0.1%','10%-20%','20%-0.1%','20%-20%','10%-20%','20%-0.1%')

save_data