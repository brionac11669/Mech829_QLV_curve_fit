function relax_fig=plotrelax(data,relaxtype,timerange)
time_relax=find(data.time==timerange(1)): find(data.time==timerange(2));
relax_fig=figure(3); grid on; hold on
title('Relax Data and Fit')
plot(data.time(time_relax),data.force(time_relax),'.')
plot(data.time(time_relax),relaxtype(data.time(time_relax)),'-')
xlabel('Time (s)'); ylabel('Force (gf)')
end
% 0.0881
% 0.0859
% 0.0310
% 0.0860
% 0.0021
% 0.1000

% a=0.0881
% b=0.0859
% c=0.0310
% d=0.0860
% g=0.0021
% h=0.1000