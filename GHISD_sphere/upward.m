k=0;
m=k+1;   %m>k,m=k+1 usually
n=1;   %n>m，dimension of upper subspace
alpha=0.015;beta=0.015;l=5e-5;
N=5e6;
delta=5e-3;

%load('matlab.mat')
 x=; %k order saddle node




Vgo=Search_direction(n,beta,l,x);   
v=Vgo;  

for j=1:n-k
    plus(j).p=zeros(387,1);
    minus(j).p=zeros(387,1);
%     plus(j).V=zeros(2*N^2,n+1);
%     minus(j).V=zeros(2*N^2,n+1);
end


for j=1:n-k
    
    v=[Vgo(:,1:k),Vgo(:,j+k)];
    
   
    %  + perturb direction
    [x1,~] = Search_kth_saddle(m,alpha,beta,l,x+delta*Vgo(:,j-1+m),v,N);
   [ind1,~]=Calculate_Eigen(beta,l,x1);
%     [ind,VV]=cal_index(perfm1.x,F_func,opt);
    if ind1>-1
        plus(j).p=x1;             %record new saddle node
%         plus(j).V=VV;
    end
    
    
    % - perturb direction
    [x2,~] = Search_kth_saddle(m,alpha,beta,l,x-delta*Vgo(:,j-1+m),v,N);
   [ind2,~]=Calculate_Eigen(beta,l,x2);
%     [ind,VV]=cal_index(perfm2.x,F_func,opt);
   
    if ind2>-1
        minus(j).p=x2;             %record new saddle node
%         plus(j).V=VV;
    end
    
end

% save("saddle",'minus','plus')


