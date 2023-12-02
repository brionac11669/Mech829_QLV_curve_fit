%% Initialization: Put all your .txt in the same folder as this file
addpath('utilities','dataset')
%% INSERT FILE NAME/data table import HERE
savedata='n';importdata='n';
filename='Nov23_S1_20_01';
%% Importing data based on settting & manual cleanup
initialize
[data,dedt]=read_data(filename);
%% Variable and model prep
% Find maximum stress
s0_max(save_count)=max(data.force); % max stress
s0_loc(save_count)=find(data.force==s0_max(save_count),1,'first'); %find index of maxstress
eps0(save_count)=(max(data.eps)-min(data.eps))/height; % Find maximum strain
data.eps=abs(data.eps-max(data.eps))/height;
exclude_loc=find(data.eps(1:s0_loc)<exclude,1,'last');

save_data
%% Parameter Guess & Model Selection
data.relax.q0=1000; 
data.relax.q1=1000; 
data.relax.p1=1000;
run models.m;

% Load model and ramp time range
figure(98);grid on;hold on
plot(data.time(1:s0_loc(save_count)),data.force(1:s0_loc(save_count)))
t1_3es=input('t1_3es (s): ') ; t2_3es=input('t2_3es (s): ');
t1_lin=input('t1_lin (s): ') ; t2_lin=input('t2_lin (s): ');
plot([t1_lin t1_lin],[0 max(data.force)],'r-');plot([t2_lin t2_lin],[0 max(data.force)],'r-')
plot([t1_3es t1_3es],[0 max(data.force)],'k-');plot([t2_3es t2_3es],[0 max(data.force)],'k-')
xlabel('Ramp Time (s)'); ylabel('Ramp Force (N)')


model_relax=modelLib.relax_3es; 
model_ramp=modelLib.linear;
%% More prep work
% Check ramp time fit interval
check_range

%% Relaxation fit #n times using selected model with updated guess
% Run curve fit 10 times
timerange_relax=[data.time(s0_loc(save_count)),data.time(end)];
[data.relax,gof.relax,gof.relax.output]=...
    visco_fit(model_relax,...
    data,timerange_relax,n,...
    data.relax.q0,data.relax.q1,data.relax.p1);

goF{save_count}=[data.relax.q0,data.relax.q1,data.relax.p1,...
    gof.relax.sse,gof.relax.rsquare,gof.relax.rmse];
%% Ramp fit #n times using selected model with updated guess
% Ramp Curve Fit


% Linear Curve Fit
[data.ramp_lin,gof.ramp_lin,gof.ramp_lin.output]=...
    visco_fit(model_ramp...
    ,data,timerange_ramplin,n,data.ramp.q0,data.ramp.q1,data.ramp.p1);
goF{save_count}(3,:)=[data.ramp_lin.p1,data.ramp_lin.p2,0,...
    gof.ramp_lin.sse,gof.ramp_lin.rsquare,gof.ramp_lin.rmse];

%% Elastic Modulus
timeloc=[find(data.time==t1_lin),find(data.time==t2_lin)];
[data.em,gof.em]=fit(data.eps(timeloc(1):timeloc(2)),data.force(timeloc(1):timeloc(2))/area,'poly1');
goF{save_count}(4,:)=[data.em.p1,data.em.p2,0,...
    gof.em.sse,gof.em.rsquare,gof.em.rmse];
%% Plotting relaxation
% Raw data
raw_fig=plotraw(data);
legend('Stress','Strain','location','east')

% Ramp plot
ramp_fig=plotramp(...
    data,[timerange_ramp3es;timerange_ramplin],s0_loc(save_count));
legend('Stress','3ES Ramp Fit','Linear Ramp Fit','Strain',...
    'location','south')

%% Relaxation plot
relax_fig=plotrelax(data,timerange_relax);
legend('Stress','Relaxation Curve Fit')

fprintf('Summarized Parameter and Goodness of Fit Table \n')
disp(array2table(goF{save_count},'variablenames',...
    {'q0','q1','p1','SSE','RSquare','Root Mean Square'}));

%% Stress Strain plot
figure; grid on; hold on
% figure(97); 
plot(data.eps(timeloc(1):timeloc(2)),data.force(timeloc(1):timeloc(2))/area,'.')
plot(data.eps(timeloc(1):timeloc(2)),data.em(data.eps(timeloc(1):timeloc(2))))
legend('Stress','Elastic Modulus Linear Fit',...
    'location','south')
xlabel('Strain (mm/mm)');ylabel('Stress (Pa)')
%% Normalized relaxation curve
[norm_fig,count]=plot_norm_relax...
    (data.time,data.force,s0_loc,s0_max,save_count);
% legend('10%-0.1%','10%-20%','20%-0.1%','20%-20%','10%-20%','20%-0.1%')

save_data