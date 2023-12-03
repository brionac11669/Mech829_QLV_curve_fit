
clc


% G(t) Parameters, Toms et al., A2

a =     0.02554  ;
b =         20  ;
c =    .02 ;
d =       8.923 ;
g =     0.012554 ;
% h =        8.77 ;
h=.003;

% Elastic stress-strain parameters, Toms et al., A2

A = 0.01277; 
B = 57.35;

%Strain function parameters for ramp and hold
t_R = 1.27;        %time end of ramp in sec
e_R = 0.1992;       %strain end of ramp
Beta = .2;    %slope of the ramped strain increase in 1/sec
cycles = 1;        %total number of cycles

t_max = 2*t_R*cycles;   %total time in sec

%Other system parameters

dT = t_R/30;
dt = dT/100;
i = 1;
Response = [0, 0, 0, 0, 0, 0];

% Main loop

for t_i=dT:dT:t_max
    
    stress = 0;
    strain = 0;
    i = i + 1;
       
    %Convolution loop
    for t_n = dt:dt:t_i
        
        if mod(floor(t_n/t_R),2) <= 0
            dedt = Beta;
        else
            dedt = 0;
        end
        
        strain = strain + dedt*dt;
        
        %Elastic Stress-strain function
        
        stress_e = A*(exp(B*strain) - 1);
        dsde = A*B*exp(B*strain);
        
        %Reduced relaxation modulus
        G = a*exp(-b*(t_i)) + c*exp(-d*(t_i)) + g*exp(-h*(t_i));
        G_ = a*exp(-b*(t_i-t_n)) + c*exp(-d*(t_i-t_n)) + g*exp(-h*(t_i-t_n));
        
        %Stress
        
        stress = stress + dsde*dedt*dt*G_;
        
    end
    Response(i,1) = t_i;
    Response(i,2) = strain;
    Response(i,3) = stress; 
    Response(i,4) = stress_e;
    Response(i,5) = G;
    Response(i,6) = dsde;
    %End of convolution loop
    
end
%End of main loop

%% test section
ae=A;be=B;dedt=Beta;tR=t_R;trelax=tR:dT:t_max;
tramp=0:dT:1.28;
% sig_ramp=dedt*(...
%     (ae*be*c*exp(be*e_R).*(exp(-d*(tramp - tR)) - 1))/d +...
%     (ae*be*g*exp(be*e_R).*(exp(-h*(tramp - tR)) - 1))/h +...
%     (a*ae*be*exp(be*e_R).*(exp(-b*(tramp - tR)) - 1))/b)...
%     -dedt*(...
%     (a*ae*be*exp(be*dedt*tramp).*(exp(-b*tramp) - 1))/b +...
%     (ae*be*c*exp(be*dedt*tramp).*(exp(-d*tramp) - 1))/d +...
%     (ae*be*g*exp(be*dedt*tramp).*(exp(-h*tramp) - 1))/h);
% sig_ramp=- dedt*(...
%     (a*ae*be*exp(be*dedt*tramp).*(exp(-b*tramp) - 1))/b +...
%     (ae*be*c*exp(be*dedt*tramp).*(exp(-d*tramp) - 1))/d +...
%     (ae*be*g*exp(be*dedt*tramp).*(exp(-h*tramp) - 1))/h);

sig_ramp=-dedt*(a*ae*be*(exp(-b*tramp)/(b + be*dedt) -...
    exp(be*dedt*tramp)/(b + be*dedt)) +...
    ae*be*c*(exp(-d*tramp)/(d + be*dedt) -...
    exp(be*dedt*tramp)/(d + be*dedt)) +...
    ae*be*g*(exp(-h*tramp)/(h + be*dedt) -...
    exp(be*dedt*tramp)/(h + be*dedt)));
 %%
sig_relax=- dedt*(a*ae*be*(exp(be*dedt*trelax)/(b + be*dedt) -...
    (exp(be*dedt*tR).*exp(-b*trelax)*exp(b*tR))/(b + be*dedt)) +...
    ae*be*c*(exp(be*dedt*trelax)/(d + be*dedt) -...
    (exp(be*dedt*tR).*exp(-d*trelax)*exp(d*tR))/(d + be*dedt)) +...
    ae*be*g*(exp(be*dedt*trelax)/(h + be*dedt) - ...
    (exp(be*dedt*tR)*exp(-h*trelax).*exp(h*tR))/(h + be*dedt))) -...
    dedt*(a*ae*be*(exp(-b*trelax)/(b + be*dedt) -...
    exp(be*dedt*trelax)/(b + be*dedt)) +...
    ae*be*c*(exp(-d*trelax)/(d + be*dedt) ...
    - exp(be*dedt*trelax)/(d + be*dedt)) +...
    ae*be*g*(exp(-h*trelax)/(h + be*dedt) -...
    exp(be*dedt*trelax)/(h + be*dedt)));
%%
% close all
% figure
% plot (Response(:,1), Response(:,2))
% title('Strain versus time')
% xlabel('Time (s)')
% ylabel('Strain')
figure(90)
plot (Response(:,1), Response(:,3))
hold on; 
plot(tramp,sig_ramp)
plot(trelax,sig_relax)

title('Stress versus time')
xlabel('Time (s)')
ylabel('Stress')
% 
% figure
% plot (Response(:,2), Response(:,3))
% title('Stress versus Strain')
% xlabel('Strain')
% ylabel('Stress')
% figure
% plot (Response(:,1), Response(:,4))
% title('Elastic Stress versus time')
% xlabel('Time (s)')
% ylabel('Elastic Stress')
% figure
% plot (Response(:,1), Response(:,5))
% title('Reduced Relaxation Modulus versus time')
% xlabel('Time (s)')
% ylabel('Reduced Relaxation Modulus')
% figure
% plot (Response(:,1), Response(:,6))
% title('Derivative of Stress with Strain versus time')
% xlabel('Time (s)')
% ylabel('dS/de')
