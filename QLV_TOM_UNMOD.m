clear all
clc
close all

% G(t) Parameters, Toms et al., A2

a = 0.0846;
b = 0.154;
c = 0.148;
d = 0.0028;
g = 0.7623;
h = 0.00003;

% Elastic stress-strain parameters, Toms et al., A2

A = 0.0013; 
B = 11.3;

%Strain function parameters for ramp and hold
t_R = 34.4;        %time end of ramp in sec
e_R = 0.546;       %strain end of ramp
Beta = e_R/t_R;    %slope of the ramped strain increase in 1/sec
cycles = 8;        %total number of cycles

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
            dedt = -Beta;
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
figure
plot (Response(:,1), Response(:,2))
title('Strain versus time')
xlabel('Time (s)')
ylabel('Strain')
figure
plot (Response(:,1), Response(:,3))
title('Stress versus time')
xlabel('Time (s)')
ylabel('Stress')
figure
plot (Response(:,2), Response(:,3))
title('Stress versus Strain')
xlabel('Strain')
ylabel('Stress')
figure
plot (Response(:,1), Response(:,4))
title('Elastic Stress versus time')
xlabel('Time (s)')
ylabel('Elastic Stress')
figure
plot (Response(:,1), Response(:,5))
title('Reduced Relaxation Modulus versus time')
xlabel('Time (s)')
ylabel('Reduced Relaxation Modulus')
figure
plot (Response(:,1), Response(:,6))
title('Derivative of Stress with Strain versus time')
xlabel('Time (s)')
ylabel('dS/de')
