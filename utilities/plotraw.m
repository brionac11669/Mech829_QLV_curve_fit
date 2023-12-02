function raw_fig=plotraw(data)
raw_fig=figure; grid on; hold on
title('Raw data')
plot(data.time,data.force,'.')
xlabel('Time (s)'); ylabel('Force (gf)')
yyaxis right
plot(data.time,abs(data.eps-max(data.eps)),'-')
xlabel('Time (s)'); ylabel('Strain (mm/mm)')
end