function [data_out,gof,output]=...
    redrelax_fit(model,data,time,guess)
fitops=fitoptions(model.eqn);
[time_loc(1),time_loc(2)]=deal...
    (find(data.time==time(1)), find(data.time==time(2)));
switch model.type
    case "Ramp"
        time_index=time_loc(1):time_loc(2);
        fitops=set(fitops,'StartPoint',guess,'Lower',[0,0,0,0,0,0]);
    case "Relax"
        time_index=time_loc(1):time_loc(2);
       fitops=set(fitops,'StartPoint',guess,'Lower',[0,0,0,0,0,0]);
end
    
[data_out,gof,output]=...
        fit(data.time(time_index),data.force(time_index),model.eqn,fitops);

switch model.type
    case "Ramp"
        fprintf('%s Reduced Modulus Fit Result\n',model.type)
        disp(data_out)
        disp(gof)
        fprintf('\n')
    case "Relax"
        fprintf('Reduced Relaxation Fit Result\n')
        disp(data_out)
        disp(gof)
        fprintf('\n')
end
end