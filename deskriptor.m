function out = deskriptor(x)
[m,n] = size(x);
xmean = mean(x);
xmed = median(x);
quar1 = prctile(x,25);
quar3 = prctile(x,75);
xmin = min(x);
xmax = max(x);
xste = std(x);
xskew = skewness(x);
xkurt = kurtosis(x);
nobs = m*ones(1,n);
out = [xmean;xmed;quar1;quar3;xmax;xmin;xste;xskew;xkurt;nobs];




