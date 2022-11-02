%%Chaotic Binary Particle Swarm Optimization Based Location of Distribution Network Fault 
% 基于混沌二进制粒子群算法的配电网故障诊断
%by Ying Xiong  and Qi Xiong
clc;clear;close all;
%%Traditional Radial Distribution
%Solution is ：00000000010000
% Iexp = [0,0,0,0,0,0,1,1,1,1,0,0,0,0];%the actual value of the node status故障节点状态编码
Iexp = [0,0,0,0,0,0,1,1,1,1,-1,-1,-1,0];%the actual value of the node status故障节点状态编码
%% Binary Particle Swarm Optimization
dim = 14;%the particle dimension
pop = 25;%the population number
MaxIter = 50;%the maximum iteration number 
Vmax = 4;%the velocity range
Vmin = -4;%the velocity range
fobj = @(x) fun(x,Iexp);%fitness function 
%
tic;
[BestX,BestF,PSOCurve] = BPSO(pop,dim,fobj,MaxIter,Vmax,Vmin);
t=toc;
t
tic;
[BestX1,BestF1,PSOCurve1] = CBPSOxq(pop,dim,fobj,MaxIter,Vmax,Vmin);
t=toc;
t
figure
plot(-PSOCurve,'b-','linewidth',1.5);
hold on 
plot(-PSOCurve1,'r-','linewidth',1.5);
title('CBPSO vs BPSO Curve')
xlabel('Number of iterations');
ylabel('Fitness value');
grid on;
legend('BPSO','CBPSO');
disp(['The best solution is ：',num2str(BestX),num2str(BestX1)]);









