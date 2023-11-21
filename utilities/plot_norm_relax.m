function [norm_fig,count_var]=plot_norm_relax(time,force,s0_loc_save,s0_max_save,save_count)
norm_fig=figure(99); hold on; grid on
for count_var=1:save_count
    plot(time(s0_loc_save(count_var):end,save_count)-time(s0_loc_save(count_var),save_count),...
        force(s0_loc_save(count_var):end,save_count)/s0_max_save(count_var),'.')
end
xlabel('Time (s)')
ylabel('\sigma/\sigma_{max}')
title('Normalized Relaxation Curve')
end