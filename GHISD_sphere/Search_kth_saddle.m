function [x,i] = Search_kth_saddle(k,alpha,beta,l,x,V0,N)
% Search kth saddle
% alpha,beta: step sizes
% l: a small constant
% x0: initial point
% v0: inital direction of initial point
% N: step number
error=1e-6;% iteration tolerance


[~,kk]=size(V0);
V = V0;
V = My_orth(V);
if (k>0)
for i=1:N

F=NGSys(x);% gradient system
nF=norm(F);
if nF<error
break; % stop
end
if nF>1e1
F=F/nF;
end
x=x+alpha*(F-2*V(:,1:k)*(V(:,1:k)'*F));

for j=1:kk % Update direction V

V(:,j)=V(:,j)+beta*(NGSys(x+l*V(:,j))-NGSys(x-l*V(:,j)))/(2*l);
end
V=My_orth(V); % orthogonalization
% determination 

% if (isempty(find(x<-1e1))==0)
% break 
% end

end

else


for i=1:N

F=NGSys(x);% gradient system
nF=norm(F);
if nF<error
break; % stop
end
if nF>1e1
F=F/nF;
end
x=x+alpha*F; %Update x



end

end

end
