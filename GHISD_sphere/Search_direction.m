function V = Search_direction(k,beta,l,x0)
% Search direction for k eigenvector 
% beta: step sizes
% l: a small constant

x=x0;
tau=beta;
n=length(x);eps2=1e-5;
% k=k+1;
V=randn(n,k); V=orth(V);
if k==0
    return;
end
maxstep=10e6;
for i=1:maxstep
    VV=V(:,1);
    for j=1:k
        V(:,j)=V(:,j)+tau*(NGSys(x+l*V(:,j))-NGSys(x-l*V(:,j)))/(2*l);
    end
    V=orth(V);
    if norm(VV-V(:,1))<eps2
        break;
    end
end


end

% end