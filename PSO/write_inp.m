clc;clear;
filename1 =char('D:\Chemkin work dir\iC8\IMPSO\iC8ST_data.xlsx');
A1= xlsread(filename1);
c2=[0.01,0.008,0.007,0.006,0.005,0.005,0.005,0.004,0.003,0.003,0.002,0.002,0.002,0.001,0.001];
c3=[0.01,0.008,0.006,0.004,0.003,0.001];
c1=[0.01,0.008,0.006,0.004,0.003,0.002,0.001,0.001];
c = [c1,c2,c3];
for i = 42:70
    fprintf('NEWRUN\nEND\n');
    fprintf('TEMP %7.3f\n',A1(i,2));
    fprintf('TIME %5.3f\n',c(i-41));
    fprintf('ADAP\n\n');
end