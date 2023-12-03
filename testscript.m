plot(data.eps(1:s0_loc),data.force(1:s0_loc))
[result,gof]=fit(data.eps(1:s0_loc),data.force(1:s0_loc),ramp_eps,...
    'Exclude',data.eps(1:s0_loc)>0.17,'lower',[0 0]);
time=data.time(1:exclude_loc);
fitforce=result(data.eps(1:exclude_loc));
fiteps=data.eps(1:exclude_loc);
force=data.force(1:exclude_loc);
figure(100); hold on
plot(data.eps(1:s0_loc),data.force(1:s0_loc))
plot(fiteps,fitforce)
disp(result)
disp(gof)

%%
% [result,gof]=fit(data.time(19977:end),data.force(19977:end),modelLib.relax_3es.eqn,'startpoint',[1000 1000 1000])
% time_r=data.time(1:17001);force_r=data.force(1:17001);
[result,gof]=fit(data.time(1:exclude_loc),data.force(1:exclude_loc),ramp_red,...
    'startpoint',[1 1 1 1 1 1],'lower',[0 0 0 0 0 0],...
    'robust','lar','maxiter',1e6)
    % ,'exclude',data.force(1:exclude_loc)>90...)
% 'startpoint',[1 1e3 1 1e3 1 1e3]
disp(result)
disp(gof)

figure
hold on, grid on
% plot(data.time(19977:end),data.force(19977:end))
% plot(data.time(19977:end),result(data.time(19977:end)))
plot(data.time(1:exclude_loc),data.force(1:exclude_loc))
plot(data.time(1:exclude_loc),result(data.time(1:exclude_loc)))

%%
% time=data.time(1:exclude_loc);
% force=data.force(1:exclude_loc);
time=data.time(s0_loc:end);
force=data.force(s0_loc:end);
%%
dedt=.2459;
a =     0.0881
b =     0.0859
c =     0.0310
d =     0.0860
g =      0.0021
h =       0.1000
ae =   71.53;
be = 35.61;
t=0:.001:.81;
sig_ramp=-dedt*(a*ae*be*(exp(-b*t)/(b+be*dedt)-exp(be*dedt*t)/(b+be*dedt)...
                    )+ae*be*c*(exp(-d*t)/(d+be*dedt)-exp(be*dedt*t)/(d+...
                    be*dedt))+ae*be*g*(exp(-h*t)/(h+be*dedt)-exp(be*dedt*t)...
                    /(h+be*dedt)));

figure
plot(sig_ramp)