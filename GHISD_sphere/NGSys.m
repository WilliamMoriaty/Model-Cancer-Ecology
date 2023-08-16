function F = NGSys(x)
% gradient fucntion:F(x);
n=128;% discrete space
L=50;% radius
D1=0.06;D2=3;D3=0.0;
A1=1.35;A2=0.25;A3=3.5;
E1=4.0;E2=5.0;E3=5.0;E4=4.0;
D=1.08;%D=lambda
C1=0.1;C2=1.0;C3=0.4;
n1=1;n2=4;n3=4;n4=4;
dr=L/(n);
 %ri=(i-0.5)dr,i=1,2,...,n
%thetaj=j*dtheta,j=1,2,...,n
F=zeros([n+1,3]);
%F=gpuArray(zeros([n,n,3]));
%F=zeros([n,n,3]);
x=reshape(x,[n+1,3]);
DD=ones(1,3);DD(1)=D1;DD(2)=D2;DD(3)=D3;
u=DD.*x;
%%
i=1;
F(i,1:3)=(3/dr)*(u(i+1,1:3)-u(i,1:3))/dr;

%%
i=n+1;
ri=(i-0.5)*dr;
F(i,1:3)=(ri)^-2*((i*dr)^2+((i-1)*dr)^2)*(u(i-1,1:3)-u(i,1:3))/dr^2;

%% 
for i=2:n
ri=(i-0.5)*dr;
F(i,1:3)=(ri)^-2*((i*dr)^2*u(i+1,1:3)-((i*dr)^2+((i-1)*dr)^2)*u(i,1:3)+((i-1)*dr)^2*u(i-1,1:3))/dr^2;
end

F(1:n+1,1)=F(1:n+1,1)+x(1:n+1,1).*(1-x(1:n+1,1))+x(1:n+1,1).*(x(1:n+1,3).^n4)./(1+E2*x(1:n+1,3).^n4)-x(1:n+1,2).*(x(1:n+1,1).^n1)./(1+E1*x(1:n+1,1).^n1)-C1*x(1:n+1,1);
F(1:n+1,2)=F(1:n+1,2)+D+A1*x(1:n+1,2).*x(1:n+1,1).^n1./(1+E1*x(1:n+1,1).^n1)-A2*x(1:n+1,2).*(x(1:n+1,3).^n2)./(1+E3*x(1:n+1,3).^n2)-C2*x(1:n+1,2);
F(1:n+1,3)=F(1:n+1,3)+A3*x(1:n+1,1).^n3./(1+E4*x(1:n+1,1).^n3)-C3*x(1:n+1,3);

F=reshape(F,(n+1)*3,1);
end