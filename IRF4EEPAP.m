% IRF Generating Script, May, 2023, TVQ
clear; clc; close all
q = 12; N = 8; L = 2; N0 = 3; ic = 90;
load data1a.mat
load data2a.mat 
k = size(BETA,1);
Yhat = zeros(q,N,k);
Vhat = zeros(q,N);
ZZ = zeros(q-2,k,N);
for s = 1:8
    Vhat(3,s) = 1; %shock to the Federal Funds rate
    for j = 3:q
        for i = 1:k
            B = reshape(BETA(i,:),N*L+1+N0,N);
            Yhat(j,:,i) = [Yhat(j-1,:,i) Yhat(j-2,:,i)]*B(1:2*N,:) + Vhat(j,:)*AHAT(:,:,i)';
        end
    end
    QQ = squeeze(Yhat(3:end,1,:));
    ZZ(:,:,s) = QQ;
    Vhat(3,:) = 0;
end
names = {'ER','Growth','Inflation','SIR','ULC','BCI','NL2G','M3'};
for i = 1:8
    KK = squeeze(ZZ(:,:,i));
    if i == 1
        KK = KK/mean(KK(1,:));
    end
    subplot(4,2,i)
    plot(mean(KK,2),'b-','LineWidth',2)
    hold on
    plot(prctile(KK,ic,2),'r--')
    plot(prctile(KK,100-ic,2),'r--')
    hold off
    axis tight
    title(names{i})
    xlabel('Periods')
    ylabel('ER')
    h = gca;
    h.FontSize = 11;
    h.XTick = 1:2:10;
    h.XTickLabel = 0:2:10;
end

    
