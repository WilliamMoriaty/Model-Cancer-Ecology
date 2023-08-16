function [S,R,n1] = Downward_Search(m,k,x,eps,alpha,beta,V0,l,N)
% Downward search m-saddle point from k-saddle 
% x: k-saddle point
% epsilon: direction change
% alpha: step size
% V: inital orthonormal direction
% l: a small constant
% v0: inital direction of initial point
% N: step number
S=[];R=[];S=[S x];
% x=gpuArray(x); % x add into gpu
error=1e-4;% tolerance
%V0=Schmidt_orthogonalization(rand(size(x,1),k));
%V0 = Search_direction(k,beta,l,x,V0,N);
%N1=257*3;
if (m==0) % find steady point
for i1=1:k
for i=-1:2:1
x0=x+sign(i)*eps*V0(:,i1);
[x,n1] = Search_kth_saddle(m,alpha,beta,l,x0,V0,N);
% x=gather(x);
if (n1<N) % add m-saddle
dist=[];
for j=1:size(S,2)
dist=[dist norm(x-S(:,j))];
end
if (min(dist)>error)
S=[S x];R=[R x]; % solution set and relation set
end

end

end

end

else
y=x;% k-saddle point
for n=1:k
if n<m
V=[V0(:,1:n-1) V0(:,n+1:m+1)];
else
V=V0(:,1:m);
end
for i=-1:2:1
x0=y+sign(i)*eps*V0(:,n);
[x,n1] = Search_kth_saddle(m,alpha,beta,l,x0,V,N);
% x=gather(x);
if (n1<N && isempty(find(abs(NGSys(x))>10))==1) % add (k-1)-saddle
dist=[];
for j=1:size(S,2)
dist=[dist norm(x-S(:,j))/sqrt(N1)];
end
if (min(dist)>error)
S=[S x];R=[R x]; % solution set and relation set
end

end
end

end

end

end

