function nV=My_orth(V)                %% standard schmit orthogonal
[~,m]=size(V);
if m==0
    nV=V;
    return 
end
nV=V;
nV(:,1)=V(:,1)/norm(V(:,1));
for j=2:m
    q=V(:,j);
    for t=1:j-1
        q=q-q'*nV(:,t)*nV(:,t);
    end
    q=q/norm(q);
    for t=1:j-1
        q=q-q'*nV(:,t)*nV(:,t);
    end
    q=q/norm(q);
    nV(:,j)=q;
end

end