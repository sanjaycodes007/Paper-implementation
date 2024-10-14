function S = stability(beta,N,N0,L)
B = reshape(beta,N*L+1+N0,N);
FF = zeros(N*L);
FF(1:N,:)= B(1:N*L,:)';
FF(N+1:N*L,1:N*(L-1)) = eye(N*(L-1),N*(L-1));
ee = max(abs(eig(FF)));
S = ee>1;


