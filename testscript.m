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
dedt=.1992;
a =     0.02554  ;
b =         8.7  ;
c =     0.02554 ;
d =       8.923 ;
g =     0.02554 ;
h =        8.77 ;
ae = 0.01277; 
be = 57.35;
tramp=0:.01:1.27;
sig_ramp=-dedt*(a*ae*be*(exp(-b*tramp)/(b + be*dedt) -...
    exp(be*dedt*tramp)/(b + be*dedt)) +...
    ae*be*c*(exp(-d*tramp)/(d + be*dedt) -...
    exp(be*dedt*tramp)/(d + be*dedt)) +...
    ae*be*g*(exp(-h*tramp)/(h + be*dedt) -...
    exp(be*dedt*tramp)/(h + be*dedt)));
plot(sig_ramp)