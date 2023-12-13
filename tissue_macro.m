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
dedt=dedt/height;
data.eps=abs(data.eps-max(data.eps))/height;
data.force=data.force*.00981/area;
save_data

%% Parameter Guess & Model Selection
% guess_relax=[1e3 1e5 20];
guess_relax=[0.3 0.04 .3 .004 .4 .3]; %[a b c d g h]
% guess_ramp=[0.0881 0.0859 0.0310 0.0860 0.0021 0.1000];

guess_ramp=[1 .001 1.5 .07 1.4 .3]; %[a b c d g h]
guess_relax3es=[1e3 5e4 10]; %[q0 q1 p1]

%% More prep work
check_range
if runstat==0 
    return; end

%% Relaxation fit #n times using selected model with updated guess
% [data.relax,gof.relax,gof.relax.output]=visco_fit(...
%     modelLib.relax_3es,...
%     data,timerange_relax,guess_relax);
[data.relax_eps,gof.relax_eps,gof.relax_eps.output]=...
    redrelax_fit(modelLib.relax_eps,...
    data,timerange_relax,...
    guess_relax);
    % [0.01839 2.897 0.01839 2.897 0.01839 2.897]);...

[data.relax_3es,gof.relax_3es]=fit(...
    data.time(s0_loc:end),data.force(s0_loc:end),...
    modelLib.relax_3es.eqn,'startpoint',guess_relax3es,'lower',[0 0 0]);
fprintf('3ES Relaxation Curve Fit Result\n')
disp(data.relax_3es);disp(gof.relax_3es)
%% Ramp fit #n times using selected model with updated guess
% Ramp Curve Fit
[data.ramp_eps,gof.ramp_eps,gof.ramp_eps.output]=...
    redrelax_fit(modelLib.ramp_eps,...
    data,timerange_ramp,...
    guess_ramp);




% figure
% hold on, grid on
% plot(data.time(1:s0_loc),data.force(1:s0_loc))
% plot(data.time(1:exclude_loc),data.ramp_eps(data.time(1:exclude_loc)))

%% Linear Elastic Modulus
% timeloc=[find(data.time==t1_lin),find(data.time==t2_lin)];
% [data.em,gof.em]=fit(data.eps(timeloc(1):timeloc(2)),...
%     data.force(timeloc(1):timeloc(2))/area,'poly1');
% goF{save_count}(4,:)=[data.em.p1,data.em.p2,0,...
%     gof.em.sse,gof.em.rsquare,gof.em.rmse];
%% Plotting relaxation
% Raw data
raw_fig=plotraw(data);
legend('Stress','Strain','location','east')

%% Ramp plot
ramp_fig=plotramp(data,exclude_loc,s0_loc(save_count));
legend('Stress','Reduced Relaxation Fit','Strain',...
    'location','southwest')

%% Relaxation plot
relax_fig=plotrelax(data,data.relax_3es,timerange_relax);

% plotrelax(data,data.relax_eps,timerange_relax);

plotrelax(data,data.relax_eps,timerange_relax);
legend('Stress','3ES Relaxation Fit','Reduced Relaxation Fit')


%% Normalized relaxation curve
[norm_fig,count]=plot_norm_relax...
    (data.time,data.force,s0_loc,s0_max,save_count);
legend('10%-0.1%','10%-20%','20%-0.1%','20%-20%','10%-20%','20%-0.1%')

save_data