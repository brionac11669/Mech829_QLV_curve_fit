clc;
addpath('utilities','dataset')
warning('OFF', 'MATLAB:table:ModifiedAndSavedVarnames')
%ignore warnings
if importdata=='y'
    run clean_data.m;
end

if savedata~='y'||~exist('save_count','var')
    clearvars -except importdata filename savedata
    count_var=0;
    save_count=1;
    close all
else
    try
        close(ramp_fig)
        close(relax_fig)
        close(raw_fig)
    catch
        close all
    end
    clearvars -except importdata filename savedata save_count...
        time force s0_max s0_loc n norm_fig eps0 count_var
end

n=10;


