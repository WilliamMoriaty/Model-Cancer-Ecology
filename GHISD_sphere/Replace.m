function saddle3 = Replace(saddle,k)
%delete the same saddle node
% saddle:struct
% k: order

error=1.0;
saddle3=struct([]);
for n=k:-1:0
saddle4=struct([]);

for l=1:size(saddle,2)
if(saddle(l).k==n)
saddle4=[saddle4 saddle(l)];
end
end

if (size(saddle4,2)==1)
saddle3=[saddle3 saddle4];
else
N1=size(saddle4,2);i=1;
while(i<N1)
dist=[];
for j=1:i-1
dist=[dist norm(saddle4(i).x-saddle4(j).x)];
end
for j=i+1:N1
dist=[dist norm(saddle4(i).x-saddle4(j).x)];
end
if(min(dist)<error)
saddle4(i)=[];
i=1;
else
i=i+1;
end
N1=size(saddle4,2);

end
saddle3=[saddle3 saddle4];

end
end
end
