function norm_fig=plot_norm_relax(time,force,s0_loc_save,s0_max_save,save_count)
norm_fig=figure(99); hold on; grid on
for i=1:save_count
    plot(time{i}(s0_loc_save(i):end)-time{i}(s0_loc_save(i)),...
        force{i}(s0_loc_save(i):end)/s0_max_save(i),'.')
end
xlabel('Time (s)')
ylabel('\sigma/\sigma_{max}')
title('Normalized Relaxation Curve')
end