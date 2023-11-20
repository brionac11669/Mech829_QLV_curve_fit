
function [data_out,gof,output]=ramp_linearfit(model,data,s0_loc)
    [data_out,gof,output] =...
        fit(data.time(1:s0_loc-1),data.force(1:s0_loc-1),model.eqn);
    fprintf('Ramp Linear Fit Result\n')
    disp(data_out)
    disp(gof)
    fprintf('\n')
end