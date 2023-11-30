function raw_fig=plotraw(data)
raw_fig=figure; grid on; hold on
title('Raw data')
plot(data.time,data.force,'.')
xlabel('Time (s)'); ylabel('Force (N)')
yyaxis right
plot(data.time,data.eps,'-')
xlabel('Time (s)'); ylabel('Strain (m/m)')
end