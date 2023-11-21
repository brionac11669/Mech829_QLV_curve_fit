function norm_fig=plot_norm_relax(time,force,s0_loc_save,s0_max_save,save_count)
global count
norm_fig=figure(99); hold on; grid on
for count=1:save_count
    plot(time{count}(s0_loc_save(count):end)-time{count}(s0_loc_save(count)),...
        force{count}(s0_loc_save(count):end)/s0_max_save(count),'.')
end
xlabel('Time (s)')
ylabel('\sigma/\sigma_{max}')
title('Normalized Relaxation Curve')
end