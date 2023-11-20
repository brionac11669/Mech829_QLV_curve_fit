function plotrelax(data,s0_loc)
figure(3); grid on; hold on
title('Relax Data and Fit')
plot(data.time(s0_loc:end),data.force(s0_loc:end),'.')
plot(data.time(s0_loc:end),data.relax(data.time(s0_loc:end)),'-')
xlabel('Time (s)'); ylabel('Stress (Pa)')
end