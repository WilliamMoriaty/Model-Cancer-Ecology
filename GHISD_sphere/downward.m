k=1;
%from k-order saddle node to find m-order saddle node
m=0;

alpha=0.015;beta=0.015;l=5e-5;
N=5e6;
delta=5e-3;

%load("matlab.mat")
% x=saddle(13).x;   
x=; %k-order saddle node
[ind,V]=Calculate_Eigen(beta,l,x);



for i=1:k
    
   if i>m 
        v=V(:,1:m);
    else
        v=V(:,1:m+1);
        v(:, i)=[];
    end
    
   
    %  + perturb direction
    [x1,~] = Search_kth_saddle(m,alpha,beta,l,x+delta*V(:,i),v,N);
   [ind,~]=Calculate_Eigen(beta,l,x1);
%     [ind,VV]=cal_index(perfm1.x,F_func,opt);
    if ind>-1
       saddle2bDD(2*i-1).p=x1;              %record new saddle
%         plus(j).V=VV;
    end
    
    
    % - perturb direction
    [x2,~] = Search_kth_saddle(m,alpha,beta,l,x-delta*V(:,i),v,N);
   [ind,~]=Calculate_Eigen(beta,l,x2);
%     [ind,VV]=cal_index(perfm2.x,F_func,opt);
   
    if ind>-1
        saddle2bDD(2*i).p=x2;              %record new saddle
%         plus(j).V=VV;
    end
    
end

save("saddle_soluntion",'saddle2bDD')

