function plotramp(data,s0_loc)
time_ramp=1:s0_loc-1;
figure(2); grid on; hold on
title('Ramp Data and Fit')
yyaxis right
plot(data.time(time_ramp),data.eps(time_ramp),...
    '-','Color',[0.8500 0.3250 0.0980])
xlabel('Time (s)'); ylabel('Strain (m/m)')

yyaxis left
plot(data.time(time_ramp),data.force(time_ramp),'.')
plot(data.time(time_ramp),data.ramp_lin(data.time(time_ramp)),'k-')
plot(data.time(time_ramp),data.ramp_3es(data.time(time_ramp)),'m-')

ylabel('Stress (Pa)')
end