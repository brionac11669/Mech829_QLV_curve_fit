% Define fit models
% Relax 2ES Analytical Solution
relax2es = fittype(@(q0,q1,p1,t)...
    eps0(save_count)*(q0*(1-exp(-1/p1*(t-data.time(s0_loc(save_count)))))+...
    q1/p1*exp(-1/p1*(t-data.time(s0_loc(save_count))))),'independent','t');

% Relax 3ES Analytical Solution
relax3es=fittype(@(q0,q1,p1,t)...
    dedt*(q0*t-q1*(exp(-t/p1)-1)+p1*q0*(exp(-t/p1)-1))-dedt*(q0*(t-data.time(s0_loc(save_count)))-...
    q1*(exp(-(t - data.time(s0_loc(save_count)))/p1) - 1) +...
    p1*q0*(exp(-(t - data.time(s0_loc(save_count)))/p1) - 1)),'independent','t');

% Ramp 3ES Analytical Solution
ramp3es = fittype(@(q0,q1,p1,t)...
    dedt*(q0*t-q1*(exp(-t/p1)-1)+p1*q0*(exp(-t/p1)-1)),'independent','t');

% Ramp G(t)
G=fittype(@(a,b,c,d,g,h,t) a*exp(-b*t)+c*exp(-d*t)+g*exp(-h*t),'independent','t');
ramp_eps=fittype(@(ae,be,ep) ae*(exp(be*ep)-1),'independent','ep');

ramp_red=fittype(@(a,b,c,d,g,h,t) ...
-(a*ae*be*.0009952*t.*exp(be*0.0009952*t).*(exp(-b*t) - 1))/b -...
(ae*be*c*.0009952*t.*exp(be*0.0009952*t).*(exp(-d*t) - 1))/d -...
(ae*be*.0009952*t*g.*exp(be*0.0009952*t).*(exp(-h*t) - 1))/h,...
'independent','t');



modelLib.relax_2es.eqn=relax2es;
modelLib.relax_2es.type="Relax";

modelLib.relax_3es.eqn=relax3es;
modelLib.relax_3es.type="Relax";

modelLib.ramp_3es.eqn=ramp3es;
modelLib.ramp_3es.type="Ramp";

modelLib.ramp_eps.eqn=ramp_eps;
modelLib.ramp_eps.type="Ramp";

modelLib.linear.eqn="poly1";
modelLib.linear.type="Ramp";

