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
    try close 1
    catch fprintf ('Raw figure closed\n')
    end
    try close 2
    catch fprintf ('Ramp figure closed\n')
    end
    try close 3
    catch fprintf ('Relax figure closed\n')
    end
    clearvars -except importdata filename savedata save_count...
        time force s0_max s0_loc n norm_fig eps0 count_var
end
area=11.7^2/1e6*pi;
height=6.33;
n=10;
%% t1
% ae=23.5; 
% be=17.59;
% r2=0.9999;
%% t3
% ae=67.04; %0.1861
% be=31.87; %0.0442

