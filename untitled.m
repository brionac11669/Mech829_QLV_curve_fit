sig_relax=- dedt*(a*ae*be*(exp(be*dedt*t)/(b + be*dedt) -...
    (exp(be*dedt*tR).*exp(-b*t)*exp(b*tR))/(b + be*dedt)) +...
    ae*be*c*(exp(be*dedt*t)/(d + be*dedt) -...
    (exp(be*dedt*tR).*exp(-d*t)*exp(d*tR))/(d + be*dedt)) +...
    ae*be*g*(exp(be*dedt*t)/(h + be*dedt) - ...
    (exp(be*dedt*tR)*exp(-h*t).*exp(h*tR))/(h + be*dedt))) -...
    dedt*(a*ae*be*(exp(-b*t)/(b + be*dedt) -...
    exp(be*dedt*t)/(b + be*dedt)) +...
    ae*be*c*(exp(-d*t)/(d + be*dedt) ...
    - exp(be*dedt*t)/(d + be*dedt)) +...
    ae*be*g*(exp(-h*t)/(h + be*dedt) -...
    exp(be*dedt*t)/(h + be*dedt)));