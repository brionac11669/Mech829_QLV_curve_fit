syms a b c d g h ti ep t
g=a*exp(-b*ti)+c*exp(-d*ti)+g*exp(-h*ti)
sigep=ae*(exp(be*ep)-1)
dsde=ae*be*exp(be*ep)
sig=int(g*dsde*dedt,ti,0,t)

sig=-(a*ae*be*dedt*exp(be*ep)*(exp(-b*t) - 1))/b -...
    (ae*be*c*dedt*exp(be*ep)*(exp(-d*t) - 1))/d - ...
    (ae*be*dedt*g*exp(be*ep)*(exp(-h*t) - 1))/h

