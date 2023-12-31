% Reduced Relaxation Modulus Analytial
[result,gof_ramp]=fit(data.eps(1:exclude_loc),data.force(1:exclude_loc),...
    ramp_eps,'lower',[0 0]);
figure(97); grid on; hold on
plot(data.eps(1:s0_loc),data.force(1:s0_loc))
plot(data.eps(1:exclude_loc),result(data.eps(1:exclude_loc)))
xlabel('Strain (mm/mm)');ylabel('Stress (Pa)'),legend('Stress-Strain','Curve Fit','location','southeast')
disp(result)
disp(gof_ramp)
fprintf(['Closing Ramp stress/strain figure. \n' ...
    'Press any key to continue...\n'])
pause
try close 97;
catch 
    fprintf('Figure 97 (Ramp stress/strain) closed\n');
end
ae=result.ae;be=result.be;
% ramp_red=fittype(@(a,b,c,d,g,h,t) ...
% -(a*ae*be*dedt.*exp(be*dedt*t).*(exp(-b*t) - 1))/b -...
% (ae*be*c*dedt.*exp(be*dedt*t).*(exp(-d*t) - 1))/d -...
% (ae*be*dedt*g.*exp(be*dedt*t).*(exp(-h*t) - 1))/h,...
% 'independent','t');

ramp_red=fittype(@(a,b,c,d,g,h,t)-dedt*(a*ae*be*(exp(-b*t)/(b + be*dedt) -...
    exp(be*dedt*t)/(b + be*dedt)) +...
    ae*be*c*(exp(-d*t)/(d + be*dedt) -...
    exp(be*dedt*t)/(d + be*dedt)) +...
    ae*be*g*(exp(-h*t)/(h + be*dedt) -...
    exp(be*dedt*t)/(h + be*dedt))),'independent','t');

relax_red=fittype(@(a,b,c,d,g,h,t)- dedt*(a*ae*be*(exp(be*dedt*t)/(b + be*dedt) -...
    (exp(be*dedt*data.time(s0_loc)).*exp(-b*t)*exp(b*data.time(s0_loc)))/(b + be*dedt)) +...
    ae*be*c*(exp(be*dedt*t)/(d + be*dedt) -...
    (exp(be*dedt*data.time(s0_loc)).*exp(-d*t)*exp(d*data.time(s0_loc)))/(d + be*dedt)) +...
    ae*be*g*(exp(be*dedt*t)/(h + be*dedt) - ...
    (exp(be*dedt*data.time(s0_loc))*exp(-h*t).*exp(h*data.time(s0_loc)))/(h + be*dedt))) -...
    dedt*(a*ae*be*(exp(-b*t)/(b + be*dedt) -...
    exp(be*dedt*t)/(b + be*dedt)) +...
    ae*be*c*(exp(-d*t)/(d + be*dedt) ...
    - exp(be*dedt*t)/(d + be*dedt)) +...
    ae*be*g*(exp(-h*t)/(h + be*dedt) -...
    exp(be*dedt*t)/(h + be*dedt))),'independent','t');


modelLib.ramp_eps.eqn=ramp_red;
modelLib.ramp_eps.type="Ramp";
modelLib.relax_eps.eqn=relax_red;
modelLib.relax_eps.type="Relax";