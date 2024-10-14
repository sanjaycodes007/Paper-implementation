function [X,Y] = preparedata(data,L)
[m,n] = size(data);
X = zeros(m-L,L*n);
for i = 1:L
    X(:,(1:n)+(i-1)*n) = data(L-i+1:m-i,:);
end
Y = data(L+1:m,:);
