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
    if exist('ramp_fig','var')
        close(ramp_fig)
    end
    if exist('relax_fig','var')
        close(relax_fig)
    end
    if exist('raw_fig','var')
        close(raw_fig)
    end
    clearvars -except importdata filename savedata save_count...
        time force s0_max s0_loc n norm_fig eps0 count_var
end

n=10;


