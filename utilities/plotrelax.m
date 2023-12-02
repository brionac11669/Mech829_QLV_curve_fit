function relax_fig=plotrelax(data,timerange)
time_relax=find(data.time==timerange(1)): find(data.time==timerange(2));
relax_fig=figure(3); grid on; hold on
title('Relax Data and Fit')
plot(data.time(time_relax),data.force(time_relax),'.')
plot(data.time(time_relax),data.relax(data.time(time_relax)),'-')
xlabel('Time (s)'); ylabel('Force (gf)')
end