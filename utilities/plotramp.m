function ramp_fig=plotramp(data,exclude_loc,s0_loc)
time=1:exclude_loc;
ramp_fig=figure(2); grid on; hold on
title('Ramp Data and Fit')
yyaxis right
plot(data.time(1:s0_loc-1),abs(data.eps(1:s0_loc-1)-data.eps(s0_loc-1)),...
    '-','Color',[0.8500 0.3250 0.0980])
xlabel('Time (s)'); ylabel('Strain (mm/mm)')

yyaxis left
plot(data.time(1:s0_loc-1),data.force(1:s0_loc-1),'.')
plot(data.time(time),data.ramp_eps(data.time(time)),'m-')
ylabel('Stress (Pa)')
end