alpha=0.015;beta=0.015;l=5e-5;
N=5e6;
delta=5e-3;

%%  Ergodic Search
saddle=struct([]);
saddle1=struct;
%%load("matlab.mat")
x=;   %k-saddle node，
k=;

saddle(1).k=k;
saddle(1).x=x;

k1=saddle(1).k;

%% Develpment solution_Landscape
for k2=k1:-1:1 % Downward-search from k1 to 1-saddle

count=[];

for l1=1:size(saddle,2)
if(saddle(l1).k==k2)
count=[count l1];
end
end

if (isempty(count))
    continue;
else
for t=1:size(count,2)
x=saddle(count(t)).x;
[~,V]=Calculate_Eigen(beta,l,x);
for m=k2-1:k2-1

for i=1:k2
    
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
       saddle1.k=ind;
       saddle1.x=x1;
       saddle=[saddle saddle1];              %record new saddle node

    end
       
    % - perturb direction
    [x2,~] = Search_kth_saddle(m,alpha,beta,l,x-delta*V(:,i),v,N);
   [ind,~]=Calculate_Eigen(beta,l,x2);

   
    if ind>-1
       saddle1.k=ind;
       saddle1.x=x2;
       saddle=[saddle saddle1];              %record new saddle node
%         
    end
  
end
 
end

end

end
%% replace all saddle nodes
saddle = Replace(saddle,k1);
save("GHiSD2.mat",'saddle');
end










