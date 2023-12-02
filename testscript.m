[result,gof]=fit(data.eps(1:s0_loc),data.force(1:s0_loc),ramp_eps,...
    'Exclude',data.eps(1:s0_loc)>0.07);

fitforce=result(data.eps(1:exclude_loc(filename(8))));
fiteps=data.eps(1:exclude_loc(4));
force=data.force(1:exclude_loc(4));
figure(100); hold on
plot(data.eps(1:s0_loc),data.force(1:s0_loc))
plot(fiteps,fitforce)
disp(result)
disp(gof)

%%
% [result,gof]=fit(data.time(19977:end),data.force(19977:end),modelLib.relax_3es.eqn,'startpoint',[1000 1000 1000])
time_r=data.time(1:17001);force_r=data.force(1:17001);
[result,gof]=fit(data.time(1:17001),data.force(1:17001),ramp_red,...
    'startpoint',[1 1 1 1 1 1],'lower',[0 0 0 0 0 0],...
    'robust','lar','maxiter',1e6)
% 'startpoint',[1 1e3 1 1e3 1 1e3]
figure
hold on, grid on
% plot(data.time(19977:end),data.force(19977:end))
% plot(data.time(19977:end),result(data.time(19977:end)))
plot(data.time(1:17001),data.force(1:17001))
plot(data.time(1:17001),result(data.time(1:17001)))