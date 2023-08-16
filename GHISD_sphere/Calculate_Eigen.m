function [ind,V] = Calculate_Eigen(beta,l,x)
% Calculate eigenvalue of saddle node
%l: step size
%x0: fixed point
%beta: step size
eps2=5e-6;
ind=-1;
tau=beta;
n=length(x);
maxstep=5e6;
found=0;
k=0;
V=zeros(n,0);
eps1=1e-6;
g=NGSys(x);
if norm(g)>eps1*20
    disp('It is not a critical point')
    return
end

while ~found
    v=randn(n,1);
    v=orthv2V(v,V);
%     figure()
    for j=1:maxstep
        vv=v;
        v=v+tau*(NGSys(x+l*v)-NGSys(x-l*v))/(2*l);
        v=orthv2V(v,V);

        if norm(v-vv)<eps2
           break; 
        end

    end
    k=k+1;
    V=[V,v];
    q=v'*(NGSys(x+l*v)-NGSys(x-l*v))/(2*l);
    if q<-1e-5
        found=1;
    end
end

B=zeros(k);
for i=1:k
    for j=1:k
        q=V(:,i)'*...
       (NGSys(x+l*V(:,j))-NGSys(x-l*V(:,j)))/(2*l);
        B(i,j)=q;
    end
end
lambda=eig(B);
ind=sum(real(lambda)>0);       % order of saddle node
end

function v=orthv2V(v,V)
[~,k]=size(V);
for i=1:k
     v=v-v'*V(:,i)*V(:,i); % orthogonal
end
v=v/norm(v);
end