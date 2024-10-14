% Structural shocks and Hist. Var. Decomposition
% Aug, 2023, TVQ
clear; clc; close all
A = xlsread('EA19Data.xlsx','B2:K85');
data = A(:,1:8);
Ex = A(:,9:end);
pp = Ex(:,end) > 0;
Ex = [Ex pp.*Ex(:,end)];
N0 = size(Ex,2);
L = 2; % lag length of the VAR
[X,Y] = preparedata(data,L);
[T,N] = size(Y);
X = [X ones(T,1) Ex(L+1:end,:)];
load data1.mat
load data2.mat
Beta = mean(BETA);
B = reshape(Beta,N*L+1+N0,N);
D = mean(AHAT2,3);
%% Structural shock decomposition
YHat = X*B;
E = Y - YHat;
U = D\E';
ED = U'.*repmat(D(1,:),T,1);
figure
h1 = bar(ED,'stacked');
h = gca;
ylim([-40,40])
h.FontSize = 13;
h.XTick = 3:12:82;
h.XTickLabel = 2002:3:2022;
xlabel('year')
ylabel('change in ER [%]')
legend('Exch. rate','Growth','Inflation','IIR','ULC','BCI','NL2G','M3',...
        'numColumns',4,'Location','NorthOutside')
h1(8).FaceColor = 'k'; 
%% Historical Variance Decompotion
PO = B(1:16,:)';
A = [PO;eye(N) zeros(N)];
EE = [E 0*E];
CE = 0*EE;
CE(1,:) = EE(1,:);
for i = 2:T
    zz = A*CE(i-1,:)' + EE(i,:)';
    CE(i,:) = zz';
end
CE = CE(:,1:N);
U = D\CE';
ED = U'.*repmat(D(1,:),T,1);
figure
h1 = bar(ED,'stacked');
h = gca;
ylim([-60,60])
h.FontSize = 13;
h.XTick = 3:12:82;
h.XTickLabel = 2002:3:2022;
xlabel('year')
ylabel('change in ER [%]')
legend('Exch. rate','Growth','Inflation','IIR','ULC','BCI','NL2G','M3',...
        'numColumns',4,'Location','NorthOutside')
h1(8).FaceColor = 'k';
%%

    



