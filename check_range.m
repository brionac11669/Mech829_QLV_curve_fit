figure(98);grid on;hold on;
plot(data.time(1:s0_loc(save_count)),data.force(1:s0_loc(save_count)),'.')
xlabel('Ramp Time (s)'); ylabel('Ramp Force (N)')
time_confirm=input(sprintf('Confirm time range: [%f %f] (y/n)? ',t1_3es,t2_3es),'s');
if time_confirm=='y'||isequal(time_confirm,"yes")||time_confirm=='1'
    fprintf('Fitting...\n')
else
    fprintf('Operation canceled by user')
    return
end
close 98

timerange_ramp3es=[t1_3es,t2_3es];
timerange_ramplin=[t1_lin,t2_lin];