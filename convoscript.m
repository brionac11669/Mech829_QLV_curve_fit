
clc


% G(t) Parameters, Toms et al., A2

% a =     0.881;b =     0.0859;c =     0.0310;
% d =     0.0860;g =      0.0021;h =       0.1000;
% a =     0.07;
% b =     2.897;
% c =     0.04;
% d =     2.897;
% g =     0.04;
% h =       2.897;
[a,b,c,d,g,h]=deal(0.0690, 2.9246, 0.0025, 2.0319, 0.0534, 0.1484);
% Elastic stress-strain parameters, Toms et al., A2

A =       71.53;
B =       35.61;

%Strain function parameters for ramp and hold
t_R = .81;        %time end of ramp in sec
e_R = 0.1992;       %strain end of ramp
Beta = .2;    %slope of the ramped strain increase in 1/sec
% Beta=e_R/t_R
cycles = 1;        %total number of cycles

t_max = 8;   %total time in sec

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
t_ramp=0:dT:tR;
% sig_ramp=dedt*(...
%     (ae*be*c*exp(be*e_R).*(exp(-d*(t_ramp - tR)) - 1))/d +...
%     (ae*be*g*exp(be*e_R).*(exp(-h*(t_ramp - tR)) - 1))/h +...
%     (a*ae*be*exp(be*e_R).*(exp(-b*(t_ramp - tR)) - 1))/b)...
%     -dedt*(...
%     (a*ae*be*exp(be*dedt*t_ramp).*(exp(-b*t_ramp) - 1))/b +...
%     (ae*be*c*exp(be*dedt*t_ramp).*(exp(-d*t_ramp) - 1))/d +...
%     (ae*be*g*exp(be*dedt*t_ramp).*(exp(-h*t_ramp) - 1))/h);
% sig_ramp=- dedt*(...
%     (a*ae*be*exp(be*dedt*t_ramp).*(exp(-b*t_ramp) - 1))/b +...
%     (ae*be*c*exp(be*dedt*t_ramp).*(exp(-d*t_ramp) - 1))/d +...
%     (ae*be*g*exp(be*dedt*t_ramp).*(exp(-h*t_ramp) - 1))/h);

sig_ramp =-dedt*(...
    a*ae*be*(exp(-b*t_ramp)/(b+be*dedt)-exp(be*dedt*t_ramp)/(b+be*dedt))+...
    ae*be*c*(exp(-d*t_ramp)/(d+be*dedt)-exp(be*dedt*t_ramp)/(d+be*dedt))+...
    ae*be*g*(exp(-h*t_ramp)/(h+be*dedt)-exp(be*dedt*t_ramp)/(h+be*dedt))...
                );

sig_relax=-dedt*(...
    a*ae*be*(exp(-b*trelax)/(b + be*dedt)-exp(be*dedt*trelax)/(b+be*dedt))+...
    ae*be*c*(exp(-d*trelax)/(d + be*dedt)-exp(be*dedt*trelax)/(d+be*dedt))+...
    ae*be*g*(exp(-h*trelax)/(h + be*dedt)-exp(be*dedt*trelax)/(h + be*dedt))...
                )...
                    -...
           dedt*(...
    a*ae*be*(exp(be*dedt*trelax)/(b + be*dedt)-...
            (exp(be*dedt*tR).*exp(-b*trelax)*exp(b*tR))/(b + be*dedt)) +...
    ae*be*c*(exp(be*dedt*trelax)/(d + be*dedt) -...
            (exp(be*dedt*tR).*exp(-d*trelax)*exp(d*tR))/(d + be*dedt)) +...
    ae*be*g*(exp(be*dedt*trelax)/(h + be*dedt) - ...
            (exp(be*dedt*tR)*exp(-h*trelax).*exp(h*tR))/(h + be*dedt)) ...
                );
%%
% close all
% figure
% plot (Response(:,1), Response(:,2))
% title('Strain versus time')
% xlabel('Time (s)')
% ylabel('Strain')
figure(90)
plot (Response(1:64,1), Response(1:64,3),'^-')
hold on; grid on
plot(t_ramp,sig_ramp)
plot(trelax,sig_relax)
legend('Convolution','Analytical Ramp','Analytical Relax')
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
