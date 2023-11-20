clc;
warning('OFF', 'MATLAB:table:ModifiedAndSavedVarnames') %ignore warnings
if clearall=='n'
    clearvars -except importdata filename savedata save_count time force s0_max_save s0_loc_save
else
    clearvars -except importdata filename savedata

end
if importdata=='y'
    run clean_data.m;
end

if savedata~='y'||~exist('save_count','var')
    save_count=1;
    close all
end

n=10;




