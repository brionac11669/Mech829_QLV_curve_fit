function ramp_fig=plotramp(data,timerange,s0_loc)
time_3es=find(data.time==timerange(1,1)):find(data.time==timerange(1,2));
time_lin=1:round(find(data.time==timerange(2,2))*1.1);
ramp_fig=figure; grid on; hold on
title('Ramp Data and Fit')
yyaxis right
plot(data.time(1:s0_loc-1),abs(data.eps(1:s0_loc-1)-data.eps(s0_loc-1)),...
    '-','Color',[0.8500 0.3250 0.0980])
xlabel('Time (s)'); ylabel('Strain (mm/mm)')

yyaxis left
plot(data.time(1:s0_loc-1),data.force(1:s0_loc-1),'.')
plot(data.time(time_3es),data.ramp_3es(data.time(time_3es)),'m-')
plot(data.time(time_lin),data.ramp_lin(data.time(time_lin)),'k-')
ylabel('Force (N)')
end