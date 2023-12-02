% Define fit models
% Relax 2ES Analytical Solution
relax2es = fittype(@(q0,q1,p1,t)...
    eps0(save_count)*(q0*(1-exp(-1/p1*(t-data.time(s0_loc(save_count)))))+...
    q1/p1*exp(-1/p1*(t-data.time(s0_loc(save_count))))),'independent','t');

% Relax 3ES Analytical Solution
relax3es=fittype(@(q0,q1,p1,t)...
    b*(q0*t-q1*(exp(-t/p1)-1)+p1*q0*(exp(-t/p1)-1))-b*(q0*(t-data.time(s0_loc(save_count)))-...
    q1*(exp(-(t - data.time(s0_loc(save_count)))/p1) - 1) +...
    p1*q0*(exp(-(t - data.time(s0_loc(save_count)))/p1) - 1)),'independent','t');

% Ramp 3ES Analytical Solution
ramp3es = fittype(@(q0,q1,p1,t)...
    b*(q0*t-q1*(exp(-t/p1)-1)+p1*q0*(exp(-t/p1)-1)),'independent','t');

% Ramp G(t)
G=fittype(@(a,b,c,d,g,h,t) a*exp(-b*t)+c*exp(-d*t)+g*exp(-h*t),'independent','t');
ramp_eps=fittype(@(ae,be,ep) ae*(exp(be*ep)-1),'independent','ep');

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

ae(4)=67.04;
be(4)=31.87;
exclude(4)=0.07;
exclude_loc(4)=find(data.eps(1:s0_loc)<exclude(4),1,'last');