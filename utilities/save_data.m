if savedata=='y'
    if exist('norm_fig','var')&&count_var==save_count
        save_count=save_count+1;
    else
        time{save_count}=data.time;
        force{save_count}=data.force;
        s0_max(save_count)=s0_max;
        s0_loc(save_count)=s0_loc;
    end
end
