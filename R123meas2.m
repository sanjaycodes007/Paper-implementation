% Script for computing measures R0, R1, R2 and R3 
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
load data1.mat; load data2.mat
q = size(BETA,1); ic = 90;
beta = mean(BETA);
y = Y(:,1);
%% R0
X1 = X(:,[19,20]);
yy = zeros(q,T);
for i = 1:q    
    b = BETA(i,[19,20]);
    y0 = X1*b';
    yy(i,:) = y0';
end
R0 = yy;
figure
plot(mean(yy),'g-','LineWidth',1.5)
hold on
plot(prctile(yy,ic),'r--')
plot(prctile(yy,100-ic),'r--')
xlabel('year')
ylabel('R0')
h = gca;
h.YTick = -20:5:20;
h.YTickLabel = h.YTick;
h.FontSize = 13;
h.XTick = 3:12:82;
h.XTickLabel = 2002:3:2022;
axis([0 82 -20 20])
%% R1
X1 = X(:,[19,20]);
X2 = X(:,18);
yy1 = zeros(q,T);
yy2 = yy1;
for i = 1:q
    b1 = BETA(i,[19,20]);
    b2 = BETA(i,18);    
    y1 = X1*b1';
    yy1(i,:) = y1';
    y2 = X2*b2';
    yy2(i,:) = y2';
end
figure
R1 = abs(yy1)./(abs(yy1) + abs(yy2));
% R1 = yy1./(yy1 + yy2);
plot(mean(R1),'b-','LineWidth',1.5)
hold on
plot(prctile(R1,ic),'k--')
plot(prctile(R1,100-ic),'k--')
xlabel('year')
ylabel('R1')
h = gca;
h.YTick = 0:0.2:1;
h.YTickLabel = h.YTick;
h.FontSize = 13;
h.XTick = 3:12:82;
h.XTickLabel = 2002:3:2022;
axis([0 82 0 1])
%% R2
X1 = X(:,17:20);
X2 = X(:,1:16);
yy1 = zeros(q,T);
yy2 = yy1;
for i = 1:q
    b1 = BETA(i,17:20);
    b2 = BETA(i,1:16);    
    y1 = X1*b1';
    yy1(i,:) = y1';
    y2 = X2*b2';
    yy2(i,:) = y2';
end
R2 = abs(yy1)./(abs(yy1) + abs(yy2));
figure
plot(mean(R2),'k-','LineWidth',1.5)
hold on
plot(prctile(R2,ic),'m--')
plot(prctile(R2,100-ic),'m--')
xlabel('year')
ylabel('R2')
h = gca;
h.YTick = 0:0.2:1;
h.YTickLabel = h.YTick;
h.FontSize = 13;
h.XTick = 3:12:82;
h.XTickLabel = 2002:3:2022;
axis([0 82 0 0.8])
% R3
yy = zeros(q,T);
E = yy;
for i = 1:q
    b = BETA(i,1:20);    
    y0 = X*b';
    yy(i,:) = y0';
    E(i,:) = (y - y0)';
end
R3 = abs(yy)./(abs(yy) + abs(E));
figure
plot(mean(R3),'m-','LineWidth',1.5)
hold on
plot(prctile(R3,ic),'g--')
plot(prctile(R3,100-ic),'g--')
xlabel('year')
ylabel('R3')
h = gca;
h.YTick = 0:0.2:1;
h.YTickLabel = h.YTick;
h.FontSize = 13;
h.XTick = 3:12:82;
h.XTickLabel = 2002:3:2022;
axis([0 82 0 1])
O = [mean(R0)' mean(R1)' mean(R2)' mean(R3)'];
out = deskriptor(O);







