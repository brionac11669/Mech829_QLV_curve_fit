a =       0.711
b =    0.007387
c =       1.421
d =     0.06774
g =       1.349
h =      0.3418
ae =        23.5
be =       17.59
dedt=0.001;
t=0:0.01:100.75;
modelt=fittype(@(a,t)-0.001*(a*23.5*17.59*(exp(-0.007387*t)/(0.007387+17.59*0.001)-exp(17.59*0.001*t)/(0.007387+17.59*0.001))+23.5*17.59*1.421*(exp(-0.06774*t)/(0.06774+17.59*0.001)-exp(17.59*0.001*t)/(0.06774+17.59*0.001))+23.5*17.59*1.349*(exp(-0.3418*t)/(0.3418+17.59*0.001)-exp(17.59*0.001*t)/(0.3418+17.59*0.001))),'independent','t');

modelz=-dedt*(a*ae*be*(exp(-b*t)/(b+be*dedt)-exp(be*dedt*t)/(b+be*dedt)...
                    )+ae*be*c*(exp(-d*t)/(d+be*dedt)-exp(be*dedt*t)/(d+...
                    be*dedt))+ae*be*g*(exp(-h*t)/(h+be*dedt)-exp(be*dedt*t)...
                    /(h+be*dedt)));

fforce=data.force(1:s0_loc)';ttime=data.time(1:s0_loc);
[aa,bb]=fit(ttime,fforce',modelt,'lower',a,'upper',a)
sse=(sum(data.force(1:s0_loc)'-modelz)*0.00980665)^2
figure(96);grid on;hold on; 
plot(ttime,fforce,'^','markersize',2)
% plot(ttime,modelz)
plot(ttime,aa(ttime))
plot(ttime,data.ramp_eps(data.time(1:s0_loc)),'m-','markersize',25)
ylabel('Force (gf)');xlabel('Time (s)')
legend('Raw Ramp','Fitted with Reduced Relax Coefficient','"Best" Reduced Relaxed Coefficient')

disp(bb)
%%
a =      0.3295
b =     0.04025
c =      0.2629
d =    0.004221
g =      0.3802
h =      0.3015
ae =        0.2033
be =        43.96
dedt=0.001;
t=0:0.01:199.76;
% modelt=fittype(@(a,t)-0.001*(a*23.5*17.59*(exp(-0.007387*t)/(0.007387+17.59*0.001)-exp(17.59*0.001*t)/(0.007387+17.59*0.001))+23.5*17.59*1.421*(exp(-0.06774*t)/(0.06774+17.59*0.001)-exp(17.59*0.001*t)/(0.06774+17.59*0.001))+23.5*17.59*1.349*(exp(-0.3418*t)/(0.3418+17.59*0.001)-exp(17.59*0.001*t)/(0.3418+17.59*0.001))),'independent','t');

modelz=-dedt*(a*ae*be*(exp(-b*t)/(b+be*dedt)-exp(be*dedt*t)/(b+be*dedt)...
                    )+ae*be*c*(exp(-d*t)/(d+be*dedt)-exp(be*dedt*t)/(d+...
                    be*dedt))+ae*be*g*(exp(-h*t)/(h+be*dedt)-exp(be*dedt*t)...
                    /(h+be*dedt)));

fforce=data.force(1:s0_loc)';ttime=data.time(1:s0_loc);
% [aa,bb]=fit(ttime,fforce',modelt,'lower',a,'upper',a)
sse=(sum(data.force(1:s0_loc)'-modelz)*0.00980665)^2
figure(96);grid on;hold on; 
plot(ttime,fforce,'^','markersize',2)
plot(ttime,modelz)
% plot(ttime,aa(ttime))
plot(ttime,data.ramp_eps(data.time(1:s0_loc)),'m')
ylabel('Force (gf)');xlabel('Time (s)')
legend('Raw Ramp','Fitted with Reduced Relax Coefficient','"Best" Reduced Relaxed Coefficient')

