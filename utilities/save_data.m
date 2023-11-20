if savedata=='y'
    if i==save_count
        save_count=save_count+1;
    else
        time{save_count}=data.time;
        force{save_count}=data.force;
        s0_max_save(save_count)=s0_max;
        s0_loc_save(save_count)=s0_loc;
    end
end
