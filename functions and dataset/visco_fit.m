function [data_out,gof,output]=...
    visco_fit(model,data,s0_loc,n,q0,q1,p1)
fitops=fitoptions(model.eqn);
switch model.type
    case"Ramp"
        time_index=1:s0_loc-1;
    case "Relax"
        time_index=s0_loc:length(data.time);
end
if isequal(model.eqn,"poly1")
    n=1;
else
    fitops=set(fitops,'StartPoint',[q0,q1,p1],'Lower',[0,0,0]);
end
for i=1:n
    [data_out,gof,output]=...
        fit(data.time(time_index),data.force(time_index),model.eqn,fitops);
    if n>1
        q0=data_out.q0;
        q1=data_out.q1;
        p1=data_out.p1;
        fitops=set(fitops,'StartPoint',[q0,q1,p1],'Lower',[0,0,0]);
    end
end
if n~=1
    fprintf('%s 3ES Curve Fit Result\n',model.type)
    disp(data_out)
    disp(gof)
    fprintf('\n')
else
    fprintf('Linear Ramp Fit Result\n')
    disp(data_out)
    disp(gof)
    fprintf('\n')
end
end