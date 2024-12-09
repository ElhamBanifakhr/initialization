%_________________________________________________________________________% 
% Risk-Based Design Optimization of Contamination Detection 
% Sensors in Water Distribution Systems: Application of an 
% Improved Whale Optimization Algorithm
%  This study conducted based on the "splace-toolkit-master"
% you can use this code by changing the algorithm (WOA_SCSO).
% for more information, please contact to authors


    clear
    clc
%% Based On splace-toolkit-master (https://github.com/KIOS-Research/splace-toolkit)
    file0='file0'; % in gidmethod
    B=epanet('Anytown_Walski1987.inp');
    P=gridmethod(B);
    runMultipleScenarios(file0, 1); %file0 name & 1=use binary or 0=without binary
    ComputeImpactMatrices(file0);
    numberOfSensors=5;
    pathname=[pwd,'\RESULTS\'];
    addpath(genpath(pwd));
    load([pathname,file0,'.0'],'-mat');
    load([pathname,file0,'.w'],'-mat');
    Y.x=[];
    Y.F=[];u=1;
    W{1}=W{1}(:,find(P.SensingNodeIndices));
    % Start with the default options
    nvars=3;
    dim=nvars;
    lb=ones(1,nvars);
    ub=size(W{1},2).*ones(1,nvars);
    fobj=@(x)single(x,W);
    N=50;
    Max_iter=100;
    nRun=20;
    B2=zeros(nRun,10);
   [Leader_score,Leader_pos,Convergence_curve]=WOA_SCSO(W,N,Max_iter,lb,ub,dim)
   