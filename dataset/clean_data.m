% Import data and cleanup
% mon_s2c1=structreadtable('Groupmonday_Oct30_S2_C1.txt'); % DONT USE THIS; raw data contains preconditioning
% mon_s2c1.dedt=readmatrix('Groupmonday_Oct30_S2_C1.txt','range',[18 2 18 2]);

mon_s2c2.table=readtable('Groupmonday_Oct30_S2_C2.txt');% fast
mon_s2c2.dedt=readmatrix('Groupmonday_Oct30_S2_C2.txt','range',[18 2 18 2]);

mon_s2c3.table=readtable('Groupmonday_Oct30_S2_C3.txt');% fast
mon_s2c3.dedt=readmatrix('Groupmonday_Oct30_S2_C3.txt','range',[18 2 18 2]);

% DONT USE THIS; raw data is unusable; sample is squished based on graph
mon_s2c4.table=readtable('Groupmonday_Oct30_S2_C4.txt'); 
mon_s2c4.dedt=readmatrix('Groupmonday_Oct30_S2_C4.txt','range',[18 2 18 2]);

thu_s1c1.table=readtable('Groupmonday_Nov2_Test1S1.txt'); %slow
thu_s1c1.dedt=readmatrix('Groupmonday_Nov2_Test1S1.txt','range',[18 2 18 2]);

thu_s1c2.table=readtable('Groupmonday_Nov2_Test2S1.txt'); %fast
thu_s1c2.dedt=readmatrix('Groupmonday_Nov2_Test2S1.txt','range',[18 2 18 2]);

thu_s1c3.table=readtable('Groupmonday_Nov2_Test3S120%.txt'); %slow
thu_s1c3.dedt=readmatrix('Groupmonday_Nov2_Test3S120%.txt','range',[18 2 18 2]);

thu_s1c4.table=readtable('Groupmonday_Nov2_Test4S120%.txt'); %fast
thu_s1c4.dedt=readmatrix('Groupmonday_Nov2_Test4S120%.txt','range',[18 2 18 2]);


% RAW Data cleanup
% mon_s2c1_1.table=mon_s2c1.table(1688:8497,:); % USE THIS ONE; precondition
% mon_s2c1_2=mon_s2c1.table(8524:end,:); %USE THIS ONE; actual mon_s2c1 %slow
% thu_s1c1(15821:end,:)=[]; % delete corrupted data