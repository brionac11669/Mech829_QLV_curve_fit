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