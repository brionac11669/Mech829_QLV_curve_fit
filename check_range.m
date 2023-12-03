figure(98);grid on;hold on
plot(data.time(1:s0_loc(save_count)),data.force(1:s0_loc(save_count)),'.')
t1_ramp=input('t1_ramp (s): ') ; t2_ramp=input('t2_ramp (s): ');
plot([t1_ramp t1_ramp],[0 max(data.force)],'k-');plot([t2_ramp t2_ramp],[0 max(data.force)],'k-')
xlabel('Ramp Time (s)'); ylabel('Ramp Force (N)')

figure(98);grid on;hold on;
xlabel('Ramp Time (s)'); ylabel('Ramp Force (N)')
time_confirm=input(sprintf('Confirm time range: [%.2f %.2f] (y/n)? ',t1_ramp,t2_ramp),'s');
if time_confirm=='y'||isequal(time_confirm,"yes")||time_confirm=='1'
    fprintf('Fitting...\n')
    timerange_ramp=[t1_ramp,t2_ramp];
    timerange_relax=[data.time(s0_loc(save_count)),data.time(end)];
    exclude_loc=find(data.time(1:s0_loc)<=t2_ramp,1,'last');
    models
    RedRelaxMod
    runstat=1;
else
    fprintf('Operation canceled by user')
    runstat=0;
    return
end
try close 98;
catch 
    fprintf('Figure 98 (Ramp stress/time) closed');
end

% timerange_ramplin=[t1_lin,t2_lin];
