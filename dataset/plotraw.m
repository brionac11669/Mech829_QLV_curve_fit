function plotraw(data)
figure(1); grid on; hold on
title('Raw data')
plot(data.time,data.force,'.')
xlabel('Time (s)'); ylabel('Stress (Pa)')
yyaxis right
plot(data.time,data.eps,'-')
xlabel('Time (s)'); ylabel('Strain (m/m)')
end