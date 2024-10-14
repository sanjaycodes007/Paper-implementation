% Estimating BVAR script, Sep, 2022, TVQ
clear; clc; close all
REPS = 1;%1.1e4;
BURN = 0;%1e3;
A = xlsread('EA19Data.xlsx','B2:K85');
load rsign2n.mat 
load index2n.mat 
data = A(:,1:8);
Ex = A(:,9:end);
pp = Ex(:,end) > 0;
Ex = [Ex pp.*Ex(:,end)];
N0 = size(Ex,2);
L = 2; %  length of lag of the VAR model
[X,Y] = preparedata(data,L);
[T,N] = size(Y);
X = [X ones(T,1) Ex(L+1:end,:)];
% priors for VAR coefficients
lamdaP = 1;  
tauP = 10*lamdaP;  
epsilonP = 1;  
muP = mean(Y)';
sigmaP = zeros(N,1);
deltaP = zeros(N,1);
for i = 1:N
    [xtemp,ytemp] = preparedata(Y(:,i),1);
    btemp = xtemp\ytemp;
    etemp = ytemp - xtemp*btemp;
    stemp = etemp'*etemp/length(ytemp);
    deltaP(i) = btemp(1);
    sigmaP(i) = stemp;
end
[yd,xd] = create_dummies(lamdaP,tauP,deltaP,epsilonP,L,muP,sigmaP,N);
xd = [xd zeros(size(xd,1),N0)];
Y0 = [Y;yd];
X0 = [X;xd];
Xp = X0'*X0;
mstar = Xp\X0'*Y0;  % OLS on the appended data
mstar = mstar(:);
ixx = Xp\eye(size(Xp,2));  
sigma = eye(N); 
BETA = zeros(REPS-BURN,length(mstar));
AHAT = zeros(N,N,REPS-BURN);
for i = 1:REPS
    rng('shuffle'); s = rng;
    vstar = kron(sigma,ixx);
    while 1
        beta = mstar + (randn(1,N*(N*L+1+N0))*chol(vstar))';        
        S = stability(beta,N,N0,L);
        if S == 0
            break
        end
    end
    e = Y0 - X0*reshape(beta,N*L+1+N0,N);
    scale = e'*e;
    sigma = iwpQ(T+size(yd,1),inv(scale));
    while 1
        K = randn(N);
        [Q,R] = qr(K);
        Sig = chol(sigma);
        Sig1 = (Sig*Q);  
        [Sig1,stop] = generateX(Sig1,ind,rsign);
        if stop == 0
            break
        end
    end
    if i>BURN
        AHAT(:,:,i-BURN) = Sig1;
        BETA(i-BURN,:) = beta';
    end
end
% save data1.mat BETA
% save data2.mat AHAT

