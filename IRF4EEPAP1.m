% IRF Generating Script, Aug, 2023, TVQ
clear; clc; close all
load data1a.mat; load data2a.mat
q = 22; N = 8; L = 2; ic = 90; ic1 = 90;
kk = size(BETA,1);
N0 = 3; Yhat = zeros(q,N,kk);
Vhat = zeros(q,N);
ZZ = zeros(q-2,kk,N);
ZZZ = ZZ;
ZZ1 = ZZ;
ZZZ1 = ZZ;
Yh2 = Yhat;
Yhat1 = Yhat; 
Yh3 = Yh2;
for s = 1:8
    Vhat(3,s) = 1; 
    for j = 3:q
        for i = 1:kk
            B = reshape(BETA(i,:),N*L+1+N0,N);
            qq = sum(B(:,end-1:end),2);
            qq1 = B(:,end-1);
            Yhat(j,:,i) = [Yhat(j-1,:,i) Yhat(j-2,:,i)]*B(1:2*N,:) + Vhat(j,:)*AHAT(:,:,i);
            Yhat1(j,:,i) = -Yhat(j,:,i);  
            Yh2(j,:,i) = qq(s)*Yhat(j,:,i);
            Yh3(j,:,i) = -qq1(s)*Yhat(j,:,i);
        end
    end
    QQ = squeeze(Yhat(3:end,1,:));
    QQQ = squeeze(Yh2(3:end,1,:));
    ZZ(:,:,s) = QQ;
    ZZZ(:,:,s) = QQQ;
    QQ1 = squeeze(Yhat1(3:end,1,:));
    QQQ1 = squeeze(Yh3(3:end,1,:));
    ZZ1(:,:,s) = QQ1;
    ZZZ1(:,:,s) = QQQ1;
    Vhat(3,:) = 0;
end
names = {'ER','Growth','Inflation','SIR','ULC','BCI','NL2G','M3'};
OO = sum(ZZZ,3);
OO1 = sum(ZZZ1,3);
figure
plot(mean(OO,2),'b-','LineWidth',2)
hold on
plot(mean(OO1,2),'m-','LineWidth',2)
plot(prctile(OO,ic,2),'r--')
plot(prctile(OO,100-ic,2),'r--')
plot(prctile(OO1,ic1,2),'g--')
plot(prctile(OO1,100-ic1,2),'g--')
axis tight
xlabel('Periods')
ylabel('ER')
xlim([1 20])
h = gca;
h.XTick = 1:2:22;
h.XTickLabel = 0:2:21;
h.YTick = -1:0.25:1;
h.YTickLabel = h.YTick;
h.FontSize = 12;
legend('Rise','Fall','Location','SouthEast')
%     
